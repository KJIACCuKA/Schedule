//
//  ContactOptionTableViewController.swift
//  Schedule
//
//  Created by Никита Козловский on 14.09.2024.
//

import UIKit

class ContactOptionTableViewController: UITableViewController {
    
    private let idOptionsTeacherCell = "idOptionsTeacherCell"
    private let idOptionsTeacherHeader = "idOptionsTeacherHeader"
    let headerNameArray = ["ИМЯ", "ТЕЛЕФОН", "E-MAIL", "ТИП", "ВЫБЕРИТЕ ИЗОБРАЖЕНИЕ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForTableView()
        view.backgroundColor = .cyan
        title = "Добавить преподавателя"
    }
    
    private func settingsForTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(ContactOptionTableViewCell.self, forCellReuseIdentifier: idOptionsTeacherCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTeacherHeader)
        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
    }
}

//MARK: - UITableViewDataSource

extension ContactOptionTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTeacherCell, for: indexPath) as? ContactOptionTableViewCell else { return UITableViewCell() }
        // - Передаем названия ячеек
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTeacherHeader) as? HeaderOptionsTableViewCell else { return UIView() }
        // - Присваиваем названия Хэдерам
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // - Передаем переменные в ячейку
        guard let cell = tableView.cellForRow(at: indexPath) as? ContactOptionTableViewCell else { return }
        switch indexPath.section {
        case 0:
            alertForCellName(label: cell.nameCellLabel, name: "Имя преподавателя", placeholder: "Введите имя преподавателя")
        case 1:
            alertForCellName(label: cell.nameCellLabel, name: "Телефон преподавателя", placeholder: "Введите телефон преподавателя")
        case 2:
            alertForCellName(label: cell.nameCellLabel, name: "E-mail преподавателя", placeholder: "Введите e-mail преподавателя")
        case 3:
            alertFriendOrTeacher(label: cell.nameCellLabel) { _ in
                print("OK")
            }
        case 4:
            alertPhotoOrCamera { source in
                self.chooseImagePicker(source: source)
            }
        default:
            print("Tap last cell")
        }
    }
    
}

//MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension ContactOptionTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // - Метод описывает способ загрузки фотографий из галереи или с помощью камеры
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            // - Разрешаем редактировать фотографию
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let cell = tableView.cellForRow(at: [4,0]) as? ContactOptionTableViewCell else { return }
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.nameCellLabel.isHidden = true
        dismiss(animated: true)
    }
}
