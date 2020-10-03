import UIFlow

class HomeViewController: UIFlowViewController<HomeViewFeatures, HomeViewNavigation> {
   
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        guard let vm = viewModel else { return }
        vm.getEvents()
    }
    
    override func updateUI() {
        guard let vm = viewModel else { return }
        removeLoader()
        switch vm.state {
        case .started:
            vm.getEvents()
        case .loading:
            presentLoader()
        case .requestFailed:
            showErrorAlert()
        case .requestSucceded:
            eventsTableView.reloadData()
        }
    }
}

// MARK: - Functions
extension HomeViewController {
    
    func presentLoader() {
        activeIndicator.isHidden = false
        eventsTableView.isHidden = true
    }
    
    func removeLoader() {
        activeIndicator.isHidden = true
        eventsTableView.isHidden = false
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "error.home.uialert.title", message: "error.home.uialert.message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.eventsTableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm  = viewModel else { return 0 }
        return vm.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventTableViewCell,
              let event = vm.events?[indexPath.row] else { return UITableViewCell() }
        
        cell.setupEventCell(event: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vm = viewModel,
              let eventIdString = vm.events?[indexPath.row].id,
              let eventId = Int(eventIdString) else { return }

        coordinator?.goToDetails(self, event: eventId)
    }
}

