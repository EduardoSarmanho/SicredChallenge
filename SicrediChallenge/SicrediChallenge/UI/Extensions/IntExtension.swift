import UIKit

extension Int {
    
    /// Convert miliseconds to a formmated date String
    var milisecondToDateString: String{
        let milisecond = Double(self)
        
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)/1000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: dateVar)
    }
}
