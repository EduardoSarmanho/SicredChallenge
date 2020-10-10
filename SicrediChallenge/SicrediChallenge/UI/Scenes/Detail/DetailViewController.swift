import UIFlow

class DetailViewController: UIFlowViewController<DetailViewFeatures, DetailViewNavigation> {
    
    @IBOutlet weak var checkinButton: UIButton!
    @IBOutlet weak var organizatorCollectionView: UICollectionView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var organizatorsView: UIView!
    @IBOutlet weak var descriptionTextView: UILabel!
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
            showErrorAlert(title: "error.detail.uialert.title", message: "error.detail.uialert.message")
        case .requestSucceded:
            setupInformation()
        case .checkinSucceded:
            setCheckinAsDone()
        case .checkinFailed:
            showErrorAlert(title: "error.checkin.uialert.title", message: "error.checkin.uialert.message")
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
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title.localized, message: message.localized , preferredStyle: .alert)
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
    
    func openCheckinPopUp() {
        
        guard let popupContent: CheckinPopupViewController  = CheckinPopupViewController.create() as? CheckinPopupViewController else { return }
        
        let cardPopup = SBCardPopupViewController(contentViewController: popupContent)
        
        popupContent.delegate = self
        
        cardPopup.show(onViewController: self)
    }
    
    func setCheckinAsDone() {
        checkinButton.setTitle("", for: .normal)
        checkinButton.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        checkinButton.isEnabled = false
    }
}

// MARK: - IBActions
extension DetailViewController {
    @IBAction func checkinPressed(_ sender: UIButton) {
        openCheckinPopUp()
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

// MARK: - CheckinPopupDelegate
extension DetailViewController: CheckinPopupDelegate {
    
    func doCheckin(name: String, email: String) {
        guard let vm  = viewModel else { return }
        vm.sendCheckin(name: name, email: email)
    }
}
