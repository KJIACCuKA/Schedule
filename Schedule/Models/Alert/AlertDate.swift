//
//  AlertDate.swift
//  Schedule
//
//  Created by Никита Козловский on 11.09.2024.
//

import UIKit

extension UIViewController {
    func alertDate(label: UILabel, completionHandler: @escaping (Int, NSDate) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        
        let datePicker = UIDatePicker()
        alert.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            
            let calendar = Calendar.current
            let component = calendar.dateComponents([.weekday], from: datePicker.date)
            guard let weekday = component.weekday else { return }
            let numberWeekday = weekday
            let date = datePicker.date as NSDate
            completionHandler(numberWeekday, date)
            
            label.text = dateString
            label.textColor = .black
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}
