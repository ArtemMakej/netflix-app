//
//  ImagePickerController.swift
//  Netflix App
//
//  Created by Artem Mackei on 17.07.2024.
//

import UIKit

class ImagePickerController {
    
    private lazy var pickerViewController = UIImagePickerController()
    
    init() {
        pickerViewController.sourceType = .camera
        pickerViewController.allowsEditing = true
    }
    
    func getViewController(delegate: UINavigationControllerDelegate & UIImagePickerControllerDelegate) -> UIViewController {
        pickerViewController.delegate = delegate
        return pickerViewController
    }
}
