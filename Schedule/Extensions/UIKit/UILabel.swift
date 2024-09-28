import UIKit

extension UILabel {
    
    // - Инициализируем свойства, которые будем использовать для UILabel
    convenience init(text: String, font: UIFont?, aligment: NSTextAlignment = .left) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = .black
        self.textAlignment = aligment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
