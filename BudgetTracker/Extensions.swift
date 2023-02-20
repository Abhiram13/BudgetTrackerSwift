import UIKit

extension UIColor {
    static var SystemBasedBg: UIColor {
        if SystemColor() == .dark {
            return UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1);
        } else {
            return UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1);
        }
    }
    
    static var SystemBasedText: UIColor {
        return SystemColor() == .dark ? .white : .black;
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgba: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0 ;
        return String(format:"#%06x", rgba)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension String {
    func decode() -> String {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
    
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
}
