//
//  ExtensionUIViewController.swift
//  ApiDemo
//
//  Created by Sunil Developer on 24/11/22.
//

import Foundation
import UIKit
//let Alert = "Alert!!!"
extension UIViewController {
    func showAlert(title: String, message: String, hendler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: hendler)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }


}
