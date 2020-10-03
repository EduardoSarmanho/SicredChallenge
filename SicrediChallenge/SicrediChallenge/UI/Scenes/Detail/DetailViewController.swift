import UIFlow

class DetailViewController: UIFlowViewController<DetailViewFeatures, DetailViewNavigation> {
    
    @IBOutlet weak var organizatorCollectionView: UICollectionView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var organizatorsView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var personCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        guard let vm = viewModel else { return }
        vm.getEventDetail()
    }
    
    override func updateUI() {
        guard let vm = viewModel else { return }
        removeLoader()
        
        switch vm.state {
        case .started:
            vm.getEventDetail()
        case .loading:
            presentLoader()
        case .requestFailed:
            showErrorAlert()
            break
        case .requestSucceded:
            setupInformation()
        }
    }
}

// MARK: - Functions
extension DetailViewController {
    
    func setupInformation() {
        guard let vm = viewModel,
              let event = vm.event else { return }
        
        self.titleLabel.text = event.title
        self.priceLabel.text = "R$ \(event.price ?? 0)".replacingOccurrences(of: ".", with: ",")
        self.dateLabel.text = event.date?.milisecondToDateString
        formatAddress(event: event) 
        
        if event.people?.count == 0 {
            self.organizatorsView.removeFromSuperview()
        }
        
        self.descriptionTextView.text = event.description
        loadImage(stringUrl: event.image ?? "")
        organizatorCollectionView.reloadData()
    }
    
    private func loadImage(stringUrl: String){
        let url = URL(string: stringUrl)
        eventImageView.kf.setImage(with: url, completionHandler:  { result in
            switch result {
            case .failure:
                self.eventImageView.image = #imageLiteral(resourceName: "NoImage")
            case .success:
                break
            }
        })
    }
    
    func presentLoader() {
        activityIndicator.isHidden = false
        loaderView.isHidden = false
    }
    
    func removeLoader() {
        activityIndicator.isHidden = true
        loaderView.isHidden = true
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "error.detail.uialert.title", message: "error.detail.uialert.message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.coordinator?.backToHome(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func formatAddress(event: EventDetail) {
        GeoCoder.getLocal(latitude: event.latitude ?? 0, longitude: event.longitude ?? 0) { local in
            self.addressLabel.text = "\(local?.street ?? ""), \(local?.number ?? ""), \(local?.city ?? ""), \(local?.state ?? "")"
        }
    }
}

// MARK: - IBActions
extension DetailViewController {
    @IBAction func backPressed(_ sender: UIButton) {
        coordinator?.backToHome(animated: true)
    }
}

// MARK: - CollectionDelegate
extension DetailViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm  = viewModel else { return 0 }
        return vm.event?.people?.count ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vm = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? OrganizatorCollectionViewCell,
              let people = vm.event?.people?[indexPath.row] else { return UICollectionViewCell() }
        
        cell.setupOrganizatorCell(people: people)
        
        return cell
    }
}
