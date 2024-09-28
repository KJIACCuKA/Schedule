import UIKit

// - Создаем делегата для кнопки (нужен чтоб передавать данные на другой экран)
protocol PressReadyTaskButtonDelegate: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}
