//
//  Alert.swift
//  Schedule
//
//  Created by Никита Козловский on 13.09.2024.
//

import UIKit

extension UIViewController {
    
    func alertForCellName(label: UILabel, name: String, placeholder: String) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            let alertTF = alert.textFields?.first
            guard let text = alertTF?.text else {
                return
            }
            label.text = text
            label.textColor = .black
        }
        
        alert.addTextField { alertTF in
            alertTF.placeholder = placeholder
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
