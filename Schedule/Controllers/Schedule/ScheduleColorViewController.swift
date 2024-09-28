//
//  ScheduleColorViewController.swift
//  Schedule
//
//  Created by Никита Козловский on 13.09.2024.
//

import UIKit

class ScheduleColorViewController: UITableViewController {
    
    private let idOptionsColorCell = "idOptionsColorCell"
    private let idOptionsHeader = "idOptionsScheduleHeader"
    let headerNameArray = ["КРАСНЫЙ", "ОРАНЖЕВЫЙ", "ЖЕЛТЫЙ", "ЗЕЛЕНЫЙ", "СИНИЙ", "ФИОЛЕТОВЫЙ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForTableView()
        view.backgroundColor = .cyan
        title = "Выберите цвет"
    }
    
    private func settingsForTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: idOptionsColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
    }
}

//MARK: - UITableViewDataSource

extension ScheduleColorViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // - Задаем разным секциям разные количества ячеек
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsColorCell, for: indexPath) as? ColorTableViewCell else { return UITableViewCell() }
        // - Передаем названия ячеек
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeader) as? HeaderOptionsTableViewCell else { return UIView() }
        // - Присваиваем названия Хэдерам
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
