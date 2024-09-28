import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {
    
    lazy var headerLabel = UILabel(text: "Header", font: .avenirNext14())
    let headerNameArray = ["ДАТА И ВРЕМЯ", "ПРЕДМЕТ", "ПРЕПОДАВАТЕЛЬ", "ЦВЕТ", "ПЕРИОД"]
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
        headerLabel.textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String], section: Int) {
        headerLabel.text = nameArray[section]
    }
    
    private func addViews() {
        self.addSubview(headerLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
