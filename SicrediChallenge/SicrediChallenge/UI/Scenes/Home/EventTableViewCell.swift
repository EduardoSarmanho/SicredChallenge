import UIKit
import Kingfisher

class EventTableViewCell: UITableViewCell {
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupEventCell(event: Event) {
        loadImage(stringUrl: event.image ?? "")
        titleLabel.text = event.title
        priceLabel.text = "R$ \(event.price ?? 0)".replacingOccurrences(of: ".", with: ",")
        setCity(latitude: event.latitude ?? 0, longitude: event.longitude ?? 0)
        dateLabel.text = event.date?.milisecondToDateString
        descriptionLabel.text = event.description
    }
    
    private func setCity(latitude: Double, longitude: Double) {
        GeoCoder.getLocal(latitude: latitude, longitude: longitude) { local in
            self.cityLabel.text = local?.city
        }
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
}
