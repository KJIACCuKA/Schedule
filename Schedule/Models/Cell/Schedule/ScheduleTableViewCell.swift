import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    //MARK: - Создание UI-Элементов
    
    private lazy var lessonName = UILabel(text: "Программирование", font: .avenirNextDemiBold20())
    
    private lazy var lessonTime = UILabel(text: "08:00", font: .avenirNextDemiBold20())
    
    private lazy var teacherName = UILabel(text: "Антонов Антон Антонович", font: .avenirNext20(), aligment: .right)
    
    private lazy var typeLabel = UILabel(text: "Тип:", font: .avenirNext14(), aligment: .right)
    
    private lazy var lessonType = UILabel(text: "Лекция", font: .avenirNextDemiBold14())
    
    private lazy var buildingLabel = UILabel(text: "Корпус:", font: .avenirNext14(), aligment: .right)
    
    private lazy var lessonBuilding = UILabel(text: "1", font: .avenirNextDemiBold14())
    
    private lazy var audLabel = UILabel(text: "Аудитория:", font: .avenirNext14(), aligment: .right)
    
    private lazy var lessonAud = UILabel(text: "101", font: .avenirNextDemiBold14())
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Настройка UI-Элементов
    
    private func setConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [lessonName, teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        // - Добавляем элементы в StackView. Альтернативный способ можно сделать через пример выше (см. файл: UIStackViewExtension)
//        stackView.addArrangedSubview(lessonName)
//        stackView.addArrangedSubview(teacherName)
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//        stackView.distribution = .fillEqually
//        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel, lessonType, buildingLabel, lessonBuilding, audLabel, lessonAud], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
}
