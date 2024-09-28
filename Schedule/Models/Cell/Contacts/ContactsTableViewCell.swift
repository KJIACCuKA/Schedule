//
//  ContactsTableViewCell.swift
//  Schedule
//
//  Created by Никита Козловский on 14.09.2024.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    //MARK: - Создание UI-Элементов

    private lazy var teacherName = UILabel(text: "Cruella De Vill", font: .avenirNext14())
    
    private lazy var phoneNumber = UILabel(text: "+7 666 66 66", font: .avenirNext14())
    
    private lazy var emailLabel = UILabel(text: "nek-koz@mail.ru", font: .avenirNext14())
    
    private lazy var photoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.backgroundColor = .clear
        image.layer.cornerRadius = 20
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var phoneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "phone.fill")
        image.backgroundColor = .clear
        image.layer.cornerRadius = 20
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var emailImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "envelope.fill")
        image.backgroundColor = .clear
        image.layer.cornerRadius = 20
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()

    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        emailLabel.numberOfLines = 2
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Настройка UI-Элементов
    
    private func addViews() {
        self.addSubview(teacherName)
        self.addSubview(phoneImage)
        self.addSubview(emailImage)
        self.addSubview(phoneNumber)
        self.addSubview(emailLabel)
        self.addSubview(photoImage)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            photoImage.heightAnchor.constraint(equalToConstant: 60),
            photoImage.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            teacherName.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 10),
            teacherName.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [phoneImage, phoneNumber, emailImage, emailLabel], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            stackView.leadingAnchor.constraint(equalTo: photoImage.trailingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
    }
    
}
