import UIKit

class CheckinPopupViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailErrorWarningLabel: UILabel!
    @IBOutlet weak var nameErrorWarningLabel: UILabel!
    
    var popupViewController: SBCardPopupViewController?
    
    weak var delegate: CheckinPopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Functions
extension CheckinPopupViewController {
    func isFieldValid() -> Bool {
        
        if (emailTextField.text?.isValidEmail ?? false){
            emailErrorWarningLabel.isHidden = true
        } else {
            emailErrorWarningLabel.isHidden = false
        }
        
        if (nameTextField.text?.count ?? 0) >= 3 {
            nameErrorWarningLabel.isHidden = true
        } else {
            nameErrorWarningLabel.isHidden = false
        }
        
        if !nameErrorWarningLabel.isHidden || !emailErrorWarningLabel.isHidden { return false }
        
        return true
    }
}


// MARK: - IBActions
extension CheckinPopupViewController {
    @IBAction func confirmPressed(_ sender: UIButton) {
        if isFieldValid() {
            self.delegate?.doCheckin(name: nameTextField.text ?? "", email: emailTextField.text ?? "")
            dismissPopUp()
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismissPopUp()
    }
}

// MARK: - SBCard Popup
extension CheckinPopupViewController: SBCardPopupContent {
    var allowsTapToDismissPopupCard: Bool {
        true
    }
    
    var allowsSwipeToDismissPopupCard: Bool {
        false
    }
    
    static func create() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "CheckinPopupViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CheckinPopupViewController") as! CheckinPopupViewController
        return viewController
    }
    
    func dismissPopUp() {
        popupViewController?.close()
    }
}
