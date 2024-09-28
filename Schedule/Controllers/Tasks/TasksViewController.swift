import UIKit
import FSCalendar

class TasksViewController: UIViewController {
    
    let idTasksCell = "idTasksCell"
    var calendarHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Создание UI-Элементов
    
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
    
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .cyan
        tableView.bounces = false
        return tableView
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Задачи"
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
        addViews()
        setConstraints()
        swipeAction()
        settingsForTasksTableView()
        createBarButton()
    }
    
    //MARK: - Настройка UI-Элементов
    
    private func createBarButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func addViews() {
        view.addSubview(calendar)
        view.addSubview(showHideButton)
        view.addSubview(tasksTableView)
    }
    
    private func setConstraints() {
        
        // - Позволяет изменять размер календаря (сворачивать и тд)
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
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
            tasksTableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func settingsForTasksTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.register(TasksTableViewCell.self, forCellReuseIdentifier: idTasksCell)
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
    
    @objc private func addButtonTapped() {
        let taskOptionTVC = TaskOptionTableViewController()
        navigationController?.pushViewController(taskOptionTVC, animated: true)
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

extension TasksViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        // - При изменении параметров календаря - будут меняться его констрейнты
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}

//MARK: - FSCalendarDelegate

extension TasksViewController: FSCalendarDelegate {
    
}

//MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idTasksCell, for: indexPath) as? TasksTableViewCell else { return UITableViewCell() }
        cell.cellTaskDelegate = self
        cell.index = indexPath
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
//MARK: - PressReadyTaskButtonDelegate

extension TasksViewController: PressReadyTaskButtonDelegate {
    func readyButtonTapped(indexPath: IndexPath) {
        print("TAP")
    }
    
    
}

//MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    
}
