//
//  Extensions.swift
//  FX App
//
//  Created by Kuda Zata on 3/5/2023.
//

import Foundation
import UIKit

extension Double {
    func toStringWithTwoDecimalPlaces() -> String {
        return String(format: "%.2f", self)
    }
}

extension String {
    /// This function returns a date object from a string
    /// - Returns: A Date object
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2")

        return dateFormatter.date(from: self) ?? Date()
    }
}

extension UIViewController {
    /// This function creates a UIAlert from any view controller within the app.
    /// - Parameters:
    ///   - title: The title of the alert (eg "Enter name")
    ///   - message: The text body of the alert
    ///   - completion: A completion block to be executed when a user clicks OK button
    func showGeneralAlert(title: String, message: String, buttonTitle: String? = "OK", completion: (() -> Void)? = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

