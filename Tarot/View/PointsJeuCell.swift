//
//  PointsJeuCell.swift
//  Tarot
//
//  Created by Serge Gori on 26/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class PointsJeuCell: UITableViewCell {
    
    @IBOutlet weak var gainLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!    
    @IBOutlet weak var petitAuBoutLabel: UILabel!
    @IBOutlet weak var poigneeLabel: UILabel!
    @IBOutlet weak var chelemLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var pointsJeu: PointsJeu!
    
    func miseEnPlace(pointsJeu: PointsJeu) {
        self.pointsJeu = pointsJeu
//        if let valeur = self.pointsJeu?.total {
//            totalLabel.text = String(valeur)
//        }
        if let valeur = self.pointsJeu?.petitAuBout {
            petitAuBoutLabel.text = String(valeur)
        }
        if let valeur = self.pointsJeu?.poignee {
            poigneeLabel.text = String(valeur)
        }
        if let valeur = self.pointsJeu?.chelem {
            chelemLabel.text = String(valeur)
        }
        if let valeur = self.pointsJeu?.total {
            totalLabel.text = String(valeur)
        }
//        if let leNom = self.personne.nom {
//            nom.text = leNom
//        }
//        if let lePrenom = self.pointsJeu.prenom {
//            prenom.text = lePrenom
//        }
    
}
}
