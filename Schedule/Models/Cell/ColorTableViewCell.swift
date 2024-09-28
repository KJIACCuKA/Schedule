//
//  ColorScheduleTableViewCell.swift
//  Schedule
//
//  Created by Никита Козловский on 13.09.2024.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    private lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
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
        switch indexPath.section {
        case 0: backgroundViewCell.backgroundColor = .red
        case 1: backgroundViewCell.backgroundColor = .orange
        case 2: backgroundViewCell.backgroundColor = .yellow
        case 3: backgroundViewCell.backgroundColor = .green
        case 4: backgroundViewCell.backgroundColor = .blue
        case 5: backgroundViewCell.backgroundColor = .purple
        default: backgroundViewCell.backgroundColor = .white
        }
    }
    
    private func addViews() {
        self.addSubview(backgroundViewCell)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
    }
}
