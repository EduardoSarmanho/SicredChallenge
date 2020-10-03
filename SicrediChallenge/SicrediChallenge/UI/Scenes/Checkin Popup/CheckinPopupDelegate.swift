import Foundation

protocol CheckinPopupDelegate: class {
    
    func doCheckin(name: String, email: String)
}
