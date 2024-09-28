import UIKit
import RealmSwift

// - ДЛЯ ПРОЕКТА TRACKER МОЖНО СДЕЛАТЬ ТАКУЮ ЖЕ РЕАЛИЗАЦИЮ ДЛЯ ЭКРАНОВ С ДОБАВЛЕНИЕМ ПРИВЫЧЕК
class OptionsScheduleTableViewController: UITableViewController {
    
    private let idOptionsScheduleCell = "idOptionsScheduleCell"
    private let idOptionsHeader = "idOptionsScheduleHeader"
    let headerNameArray = ["ДАТА И ВРЕМЯ", "ПРЕДМЕТ", "ПРЕПОДАВАТЕЛЬ", "ЦВЕТ", "ПЕРИОД"]
    private let scheduleModel = ScheduleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForTableView()
        view.backgroundColor = .cyan
        title = "Настройка расписания"
        createBarButton()
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? String.self)
    }
    
    private func settingsForTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(OptionsScheduleTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
    }
    
    private func createBarButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func saveButtonTapped() {
        print("PRINT SUKA BLYAT")
        
        RealmManager.shared.saveScheduleModel(model: scheduleModel)
    }
}

//MARK: - UITableViewDataSource

extension OptionsScheduleTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // - Задаем разным секциям разные количества ячеек
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as? OptionsScheduleTableViewCell else { return UITableViewCell() }
        // - Передаем названия ячеек 
        cell.cellConfigure(indexPath: indexPath)
        cell.switchRepeatDelegate = self
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
        // - Передаем переменные в ячейку
        guard let cell = tableView.cellForRow(at: indexPath) as? OptionsScheduleTableViewCell else { return }
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLabel) { numberWeekday, date in
                self.scheduleModel.scheduleDate = date
                self.scheduleModel.scheduleWeekday = numberWeekday
                print("OK")
            }
        case [0,1]:
            alertTime(label: cell.nameCellLabel) { timeString in
                self.scheduleModel.scheduleTime = timeString
                print("OK time")
            }
        case [1,0]:
            alertForCellName(label: cell.nameCellLabel, name: "Название предмета", placeholder: "Введите название предмета") { text in
                self.scheduleModel.scheduleName = text
            }
        case [1,1]:
            alertForCellName(label: cell.nameCellLabel, name: "Тип предмета", placeholder: "Введите тип предмета") { text in
                self.scheduleModel.scheduleType = text
            }
            
        case [1,2]:
            alertForCellName(label: cell.nameCellLabel, name: "Корпус", placeholder: "Введите номер корпуса") { text in
                self.scheduleModel.scheduleBuilding = text
            }
        case [1,3]:
            alertForCellName(label: cell.nameCellLabel, name: "Аудитория", placeholder: "Введите номер аудитории") { text in
                self.scheduleModel.scheduleAudience = text
            }
        case [2,0]:
            let teachersVC = TeachersViewController()
            navigationController?.pushViewController(teachersVC, animated: true)
        case [3,0]:
            let colorVC = ScheduleColorViewController()
            navigationController?.pushViewController(colorVC, animated: true)
        default:
            print("Tap last cell")
        }
    }
}

extension OptionsScheduleTableViewController: SwitchRepeatDelegate {
    func switchRepeat(value: Bool) {
        print(value)
        scheduleModel.scheduleRepeat = value
    }
}
