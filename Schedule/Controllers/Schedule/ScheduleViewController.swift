import UIKit
import FSCalendar
import RealmSwift

class ScheduleViewController: UIViewController {
    
    private let idScheduleCell = "idScheduleCell"
    private var calendarHeightConstraint: NSLayoutConstraint!
    
    let localRealm = try! Realm()
    var scheduleArray: Results<ScheduleModel>!
    
    
    //MARK: - Создание UI-Элементов
    
    private lazy var scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .cyan
        tableView.bounces = false
        return tableView
    }()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private lazy var showHideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Открыть календарь", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 10)
        button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Расписание"
        addViews()
        setConstraints()
        swipeAction()
        settingsForTableView()
        createBarButton()
        
//        navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
    }
    
    //MARK: - Настройка UI-Элементов
    
    private func addViews() {
        view.addSubview(calendar)
        view.addSubview(showHideButton)
        view.addSubview(scheduleTableView)
    }
    
    private func setConstraints() {
        
        // - Позволяет изменять размер календаря (сворачивать и тд)
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            scheduleTableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            scheduleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scheduleTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func settingsForTableView() {
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: idScheduleCell)
    }
    
    private func createBarButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func showHideButtonTapped() {
        // - Описываем условия изменения календаря. Если календарь скрыт, то при нажатии на кнопку раскрываем его (и наоборот)
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Закрыть календарь", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Открыть календарь", for: .normal)
        }
    }
    
    //MARK: - SwipeGestureRecognizer
    
    // - Этот и еще один метод ниже позволяет свайпом раскрывать и закрывать объект
    private func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        // -  Указываем направление свайпа
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        // -  Указываем направление свайпа
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc private func addButtonTapped() {
        let optionsScheduleVC = OptionsScheduleTableViewController()
        navigationController?.pushViewController(optionsScheduleVC, animated: true)
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
    }
    
}

//MARK: - FSCalendarDataSource

extension ScheduleViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        // - При изменении параметров календаря - будут меняться его констрейнты
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        print(weekday)
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            guard let calendar = Calendar.current.date(byAdding: components, to: dateStart) else { return Date() }
            return calendar
        }()
        
        let predicateRepeat = NSPredicate(format: "scheduleWeekday = \(weekday) AND scheduleRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "scheduleRepeat = false AND scheduleDate = BETWEEN %@", [dateStart, dateEnd])
        
        // - Объединяем созданные предикаты
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(predicateRepeat)
        print(scheduleArray)
    }
}

//MARK: - FSCalendarDelegate

extension ScheduleViewController: FSCalendarDelegate {
    
}

//MARK: - UITableViewDataSource

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idScheduleCell, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - UITableViewDelegate

extension ScheduleViewController: UITableViewDelegate {
    
}
