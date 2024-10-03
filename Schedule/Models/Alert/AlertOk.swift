//
//  AlertOk.swift
//  Schedule
//
//  Created by Никита Козловский on 03.10.2024.
//

import UIKit

extension UIViewController {
    
    func alertOK(title: String, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
