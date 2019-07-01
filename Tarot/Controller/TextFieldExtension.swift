//
//  TextFieldExtension.swift
//  Tarot
//
//  Created by Serge Gori on 19/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

extension AjoutJoueurController: UITextFieldDelegate {
    
    func miseEnPlaceTextField() {
        prenomTextField.delegate = self
        nomTextField.delegate = self
//        telTextField.delegate = self
        surnomTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
}
