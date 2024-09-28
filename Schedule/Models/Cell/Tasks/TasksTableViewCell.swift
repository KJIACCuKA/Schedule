import UIKit

class TasksTableViewCell: UITableViewCell {
    
    weak var cellTaskDelegate: PressReadyTaskButtonDelegate?
    var index: IndexPath?
    
    //MARK: - Создание UI-Элементов

    private lazy var taskName = UILabel(text: "Программирование", font: .avenirNextDemiBold20())
    
    private lazy var taskDescription = UILabel(text: "Научиться писать extension", font: .avenirNext14())
    
    private lazy var readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        taskDescription.numberOfLines = 2
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Настройка UI-Элементов
    
    private func addViews() {
        // - Добавляем кнопку поверх ячейки
        self.contentView.addSubview(readyButton)
        self.addSubview(taskName)
        self.addSubview(taskDescription)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.widthAnchor.constraint(equalToConstant: 40),
            readyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    @objc private func readyButtonTapped() {
        guard let index = index else { return }
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
}
