//
//  JoueurCell.swift
//  Tarot
//
//  Created by Serge Gori on 22/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

/// Cellule utilsée pour représenter les informations d'un joueur.
/// Utilisée dans PartieController.
///
/// - Warning: `cell.tag` est utilisé pour mémoriser `idJoueur` du joueur représenté par la cellulle.
///
class JoueurCell: UITableViewCell {
    
    @IBOutlet weak var surnomLabel: UILabel!
    @IBOutlet weak var pointsLabel: LabelPoints!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var donneurLabel: UILabel!
    @IBOutlet weak var contratLabel: UILabel!
    
    @IBOutlet weak var ordreLabel: UILabel!
    @IBOutlet weak var ordreImage: UIImageView!
    @IBOutlet weak var classementImage: UIImageView!
    
    var joueur: Joueur!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func miseEnPlace(joueur: Joueur) {
        
        self.joueur = joueur
        // Mémorisation de idJoueur dans le tag de la cellule
        self.tag = Int(self.joueur.idJoueur)

        if !joueur.enJeu {
            contratLabel.text = "Hors-jeu"
        } else {
        contratLabel.text = joueur.mort == true ? "Hors mène" : nil
        }
        
        donneurLabel.isHidden = self.joueur.donneur == false
        surnomLabel.text = dicoJoueurs[Int(self.joueur.idJoueur)]
        pointsLabel.text = String(self.joueur.points)
        pointsLabel.textColor = self.joueur.points > 0.0 ? UIColor.blue : UIColor.red

        ordreLabel.text = String(self.joueur.ordre)
        ordreImage.image = UIImage(named: "icons8-cerclé-" + String(self.joueur.ordre) + "-1")

        let isEnable = joueur.mort || !joueur.enJeu
        
        donneurLabel.isEnabled = joueur.donneur
        
        contratLabel.isEnabled = !isEnable
        surnomLabel.isEnabled = !isEnable
        pointsLabel.isEnabled = !isEnable
        ordreLabel.isEnabled = !isEnable
        ordreImage.isOpaque = !isEnable
        

self.tag = Int(self.joueur.idJoueur)
        
//        classementImage.image = UIImage(named: "icons8-cerclé-" + String(self.joueur.classement) + "-1")
        
//        self.self.isEditing = joueur.donneur == false
    }
    
//    if nbMortsSegment.selectedSegmentIndex != 0 {
//    if nbMortsSegment.selectedSegmentIndex == 1 && joueur.idx == nbJoueurs {
//    joueur.etatLabel.text = "Mort"
//    morts.append(joueur.idx)
//    }
//    if nbMortsSegment.selectedSegmentIndex == 2 && joueur.idx == nbJoueurs {
//    joueur.etatLabel.text = "Mort (-1)"
//    morts.append(joueur.idx)
//    }
//    if nbMortsSegment.selectedSegmentIndex == 2 && joueur.idx == nbJoueurs.minus() {
//    morts.append(joueur.idx)
//    joueur.etatLabel.text = "Mort (-2)"
//    }
//    }

    
}

