//
//  PersonneCell.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class JoueurCell: UITableViewCell {
    

    
    @IBOutlet weak var idxLabel: UILabel!
    @IBOutlet weak var idxImage: ImageArrondie!
    @IBOutlet weak var idJoueurLabel: UILabel!
    @IBOutlet weak var photoDeProfil: ImageArrondie!
    @IBOutlet weak var surnom: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    //    @IBOutlet weak var numerDeTel: UILabel!
//    @IBOutlet weak var adresseMail: UILabel!
    
    var joueur: Joueur!
//    var idx: Int
    
    func miseEnPlace(joueur: Joueur) {
        
        idxLabel.text = "0"
        
        self.joueur = joueur
        
        idxImage.image = UIImage(named: "icons8-cercle")
        idJoueurLabel.text = String(self.joueur.idJoueur)
        
        photoDeProfil.image = self.joueur.photo as? UIImage

        if let leSurnom = self.joueur.surnom {
            surnom.text = leSurnom
        }
        if let leNom = self.joueur.nom {
            nom.text = leNom
        }
        if let lePrenom = self.joueur.prenom {
            prenomLabel.text = lePrenom
        }


    }
    
}
