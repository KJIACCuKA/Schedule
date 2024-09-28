//
//  TaskOptionTableViewController.swift
//  Schedule
//
//  Created by Никита Козловский on 13.09.2024.
//

import UIKit

class TaskOptionTableViewController: UITableViewController {
    
    private let idOptionsTaskCell = "idOptionsTaskCell"
    private let idOptionsTasksHeader = "idOptionsTasksHeader"
    let headerNameArray = ["ДАТА", "ПРЕДМЕТ", "ЗАДАНИЕ", "ЦВЕТ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForTableView()
        view.backgroundColor = .cyan
        title = "Добавить задачу"
    }
    
    private func settingsForTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(OptionsTaskTableViewCell.self, forCellReuseIdentifier: idOptionsTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
    }
}

//MARK: - UITableViewDataSource

extension TaskOptionTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTaskCell, for: indexPath) as? OptionsTaskTableViewCell else { return UITableViewCell() }
        // - Передаем названия ячеек
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTasksHeader) as? HeaderOptionsTableViewCell else { return UIView() }
        // - Присваиваем названия Хэдерам
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // - Передаем переменные в ячейку
        guard let cell = tableView.cellForRow(at: indexPath) as? OptionsTaskTableViewCell else { return }
        switch indexPath.section {
        case 0:
            alertDate(label: cell.nameCellLabel) { numberWeekday, date in
                print("OK")
            }
        case 1:
            alertForCellName(label: cell.nameCellLabel, name: "Название предмета", placeholder: "Введите название предмета")
        case 2:
            alertForCellName(label: cell.nameCellLabel, name: "Задание", placeholder: "Введите задание")
        case 3:
            let colorTaskTVC = ColorTaskTableViewController()
                navigationController?.pushViewController(colorTaskTVC, animated: true)
        default:
            print("Tap last cell")
        }
    }
    
}
