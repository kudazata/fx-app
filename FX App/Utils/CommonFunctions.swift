//
//  CommonFunctions.swift
//  FX App
//
//  Created by Kuda Zata on 3/5/2023.
//

import Foundation
import UIKit

/// This function creates a UIAlert from any view controller within the app.
/// - Parameters:
///   - title: The title of the alert (eg "Enter name")
///   - message: The text body of the alert
///   - vc: the ViewController from which the alert will be displayed
///   - completion: A completion block to be executed when a user clicks OK button
func showGeneralAlert(title: String, message: String, vc: UIViewController, buttonTitle: String? = "OK", completion: (() -> Void)? = {}) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
        completion?()
    }))
    vc.present(alert, animated: true, completion: nil)
}


/// This function returns a date object from a string
/// - Parameters:
///   - dateString: A string containing a date
/// - Returns: A Date object
func convertStringToDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2")

    return dateFormatter.date(from: dateString) ?? Date()
}
