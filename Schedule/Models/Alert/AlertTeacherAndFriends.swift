//
//  AlertTeacherAndFriends.swift
//  Schedule
//
//  Created by Никита Козловский on 14.09.2024.
//

import UIKit

extension UIViewController {
    
    func alertFriendOrTeacher(label: UILabel, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let friendAction = UIAlertAction(title: "Друг", style: .default) { _ in
            label.text = "Друг"
            label.textColor = .black
            let typeContact = "Друг"
            completionHandler(typeContact)
        }
        
        let teacherAction = UIAlertAction(title: "Преподаватель", style: .default) { _ in
            label.text = "Преподаватель"
            label.textColor = .black
            let typeContact = "Преподаватель"
            completionHandler(typeContact)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(friendAction)
        alertController.addAction(teacherAction)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}
