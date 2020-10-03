import UIKit

class OrganizatorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var organizatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setupOrganizatorCell(people: People) {
        nameLabel.text = people.name
        loadImage(stringUrl: people.picture ?? "")
    }
    
    private func loadImage(stringUrl: String){
        activityIndicator.isHidden = false
        let url = URL(string: stringUrl)
        organizatorImageView.kf.setImage(with: url, completionHandler:  { result in
            self.activityIndicator.isHidden = true
            switch result {
            case .failure:
                self.organizatorImageView.image = #imageLiteral(resourceName: "NoImage")
            case .success:
                break
            }
        })
    }
}
