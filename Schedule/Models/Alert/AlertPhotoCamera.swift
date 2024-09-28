//
//  PhotoCameraAlert.swift
//  Schedule
//
//  Created by Никита Козловский on 14.09.2024.
//

import UIKit

extension UIViewController {
    
    func alertPhotoOrCamera(completionHandler: @escaping (UIImagePickerController.SourceType) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
            let camera = UIImagePickerController.SourceType.camera
            completionHandler(camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            let photoLibrary = UIImagePickerController.SourceType.photoLibrary
            completionHandler(photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
        
    }
}
