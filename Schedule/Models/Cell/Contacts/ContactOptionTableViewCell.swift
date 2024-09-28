//
//  ContactOptionTableViewCell.swift
//  Schedule
//
//  Created by Никита Козловский on 14.09.2024.
//

import UIKit

class ContactOptionTableViewCell: UITableViewCell {
    
    let cellNameArray = ["Введите имя преподавателя", "Введите телефон преподавателя", "Введите e-mail преподавателя", "Введите тип", "Выберите изображение"]
    
    lazy var backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - Функция для заполнения ячеек названиями из массива cellNameArray
    func cellConfigure(indexPath: IndexPath) {
        nameCellLabel.text = cellNameArray[indexPath.section]
        nameCellLabel.textColor = .lightGray
    }
    
    private func addViews() {
        self.addSubview(backgroundViewCell)
        self.addSubview(nameCellLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
        NSLayoutConstraint.activate([
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15),
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
