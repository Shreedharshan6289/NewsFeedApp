//
//  UIKItExtensions.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import Foundation
import UIKit


extension UIColor {
    
    class var themeColor: UIColor {
        return .hexToColor("B3152A")
    }
    
    class var bgColor: UIColor {
        return .hexToColor("353446")
    }
    
    static let txtColor = UIColor.white
    static let darkTxtColor = UIColor.black
    static let secondaryColor = UIColor.white
    
    static func hexToColor (_ hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UITextField
{
    enum Direction
    {
        case Left
        case Right
    }
    
    func padding(_ width: CGFloat) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        leftViewMode = .always
        leftView = view
        
    }
    
}

extension UISegmentedControl {
    
    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        self.setTitleTextAttributes(attributes, for: state)
    }
    
    func setTitleFont(_ font: UIFont, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.font] = font
        self.setTitleTextAttributes(attributes, for: state)
    }
    
}


extension UIFont {
    class func appTitleFont(ofSize:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize:ofSize)
    }
    class func appBoldTitleFont(ofSize:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize:ofSize)
    }
    class func appFont(ofSize:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize:ofSize)
    }
    class func appBoldFont(ofSize:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize:ofSize)
    }
    class func appRegularFont(ofSize:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize:ofSize)
    }
    class func appSemiBold(ofSize:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize:ofSize)
    }
    class func appMediumFont(ofSize:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize:ofSize)
    }
}

extension UIButton {
    
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
    
}

extension UIViewController {
    func showAlert(_ title :String? = nil , message: String? = nil)
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        if let title = title {
            let titleFont = [NSAttributedString.Key.font: UIFont.appBoldTitleFont(ofSize: 18)]
            let titleAttrString = NSAttributedString(string: title, attributes: titleFont)
            alert.setValue(titleAttrString, forKey: "attributedTitle")
        }
        if let message = message {
            let messageFont = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 16)]
            let messageAttrString = NSAttributedString(string: message, attributes: messageFont)
            alert.setValue(messageAttrString, forKey: "attributedMessage")
        }
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension String {
    
    func formatDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) ?? ISO8601DateFormatter().date(from: self) else {
            return "Unknown Date"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy, hh:mm a z" // Example: "Jul 13, 2023, 12:31 PM GMT+5:30"
        formatter.timeZone = TimeZone.current // Set to user's time zone
        
        return formatter.string(from: date)
    }
    
}
