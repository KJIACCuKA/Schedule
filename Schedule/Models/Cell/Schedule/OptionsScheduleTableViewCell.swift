//
//  TestCell.swift
//  Schedule
//
//  Created by Никита Козловский on 10.09.2024.
//

import UIKit

class OptionsScheduleTableViewCell: UITableViewCell {
    
    let cellNameArray = [["Дата", "Время"],
                         ["Название", "Тип", "Корпус", "Аудитория"],
                         ["Имя преподавателя"],
                         [""],
                         ["Повторять каждые 7 дней"]]
    
    private lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var repeatSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.isOn = true
        mySwitch.isHidden = true
        mySwitch.onTintColor = .blue
        mySwitch.addTarget(self, action: #selector(switchChanged(paramTarget:)), for: .valueChanged)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        return mySwitch
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
        nameCellLabel.text = cellNameArray[indexPath.section][indexPath.row]
        nameCellLabel.textColor = .lightGray
        
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = .red
        }
        
        if indexPath == [4,0] {
            repeatSwitch.isHidden = false
        }
    }
    
    private func addViews() {
        self.addSubview(backgroundViewCell)
        self.addSubview(nameCellLabel)
        self.contentView.addSubview(repeatSwitch)
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
        
        NSLayoutConstraint.activate([
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -15),
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc private func switchChanged(paramTarget: UISwitch) {
        
    }
}
