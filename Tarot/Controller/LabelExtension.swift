//
//  LabelExtension.swift
//  Tarot
//
//  Created by Serge Gori on 02/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

extension AjoutJoueurController {

    func miseEnPlaceLabel() {
        idJoueurLabel.text = String(idJoueur)
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM/YYYY HH:mm"
        horodateLabel.text = format.string(from: now)
    }
}

