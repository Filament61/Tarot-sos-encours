//
//  AjoutPersonneControllerExtension.swift
//  Tarot
//
//  Created by Serge Gori on 19/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

extension AjoutPersonneController {
    
    func miseEnPlaceLabel() {
        idJoueurLabel.text = String(idJoueur)
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM/YYYY HH:mm"
        horodateLabel.text = format.string(from: now)
    }
}

extension AjoutPersonneController {
    
    func miseEnPlaceNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(clavierRentre), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clavierSort), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func clavierRentre(notification: Notification) {
        UIView.animate(withDuration: 0.35) {
            self.contrainteDuBas.constant = 0
        }
    }
    
    @objc func clavierSort(notification: Notification) {
        if let hauteur = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            UIView.animate(withDuration: 0.35, animations: {
                self.contrainteDuBas.constant = -hauteur
            })
        }
    }
    
}

extension AjoutPersonneController: UITextFieldDelegate {
    
    func miseEnPlaceTextField() {
        prenomTextField.delegate = self
        nomTextField.delegate = self
        surnomTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

extension AjoutPersonneController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func miseEnPlaceImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        imageDeProfil.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(prendrePhoto))
        imageDeProfil.addGestureRecognizer(tap)
    }
    
    @objc func prendrePhoto() {
        guard imagePicker != nil else { return }
        let alerte = UIAlertController(title: "Prendre photo", message: "Choisissez votre média", preferredStyle: .actionSheet)
        let appareil = UIAlertAction(title: "Appareil Photo", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker?.sourceType = .camera
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        let librairie = UIAlertAction(title: "Librairie", style: .default) { (action) in
            self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        let annuler = UIAlertAction(title: "Annuler", style: .destructive, handler: nil)
        alerte.addAction(appareil)
        alerte.addAction(librairie)
        alerte.addAction(annuler)
        self.present(alerte, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        var image: UIImage?
        
        if let editee = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            image = editee
        } else if let originale = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            image = originale
        }
        
        imageDeProfil.image = image
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}


