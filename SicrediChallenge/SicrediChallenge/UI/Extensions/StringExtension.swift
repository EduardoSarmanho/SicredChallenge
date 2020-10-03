import UIKit

extension String {
    
    /// Returns the localized string
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns if is a valid email
    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
