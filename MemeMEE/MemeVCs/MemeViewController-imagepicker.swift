//
//  MemeViewController-imagepicker.swift
//  MemeMEE
//
//  Created by khalid alhazmi on 18/03/2019.
//  Copyright © 2019 khalid alhazmi. All rights reserved.
//

import Foundation
import UIKit
extension MemeViewController: UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    //Image delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage{
            imageView.image = chosenImage
            cancelButton.isEnabled = true
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
