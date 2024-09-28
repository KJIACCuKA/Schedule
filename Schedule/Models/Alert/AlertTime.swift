//
//  AlertTime.swift
//  Schedule
//
//  Created by Никита Козловский on 13.09.2024.
//

import UIKit

extension UIViewController {
    func alertTime(label: UILabel, completionHandler: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        
        let datePicker = UIDatePicker()
        alert.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "RU_ru") as Locale
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: datePicker.date)
            
            let timeSchedule = datePicker.date
            completionHandler(timeSchedule)
            
            label.text = timeString
            label.textColor = .black
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
