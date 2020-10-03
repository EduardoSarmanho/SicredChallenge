import UIFlow

class DetailViewController: UIFlowViewController<DetailViewFeatures, DetailViewNavigation> {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var organizatorsView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
    }
    
    override func updateUI() {

    }
}

// MARK: - Functions
extension DetailViewController {
}
