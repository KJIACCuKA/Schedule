import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    //MARK: - Настройка TabBar
    
    private func setupTabBar() {
        let scheduleVC = createNavigationController(vc: ScheduleViewController(), itemName: "Расписание", itemImage: "calendar.badge.clock")
        let tasksVC = createNavigationController(vc: TasksViewController(), itemName: "Задачи", itemImage: "text.badge.checkmark")
        let contactsVC = createNavigationController(vc: ContactsTableViewController(), itemName: "Контакты", itemImage: "rectangle.stack.person.crop")
        
        viewControllers = [scheduleVC, tasksVC, contactsVC]
    }
    
    private func createNavigationController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        tabBar.clipsToBounds = true
        tabBar.layer.borderWidth = 0.3
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor(red:0.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha:0.5).cgColor
        
        // - withAlignmentRectInsets = выравниваем иконку
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        // - Выравниваем текст barItem
//        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.layer.borderWidth = 0.3
        navigationController.navigationBar.layer.borderColor = UIColor(red:0.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha:0.5).cgColor
        navigationController.navigationBar.clipsToBounds = true
        navigationController.tabBarItem = item
        
        // - Полоска навигации у navControllera (Убрали с версии XCode13, но можно вернуть методом ниже
//        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        
        return navigationController
        
    }


}

