//
//  PersonneCell.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class JoueurCell: UITableViewCell {
    

    
    @IBOutlet weak var photoDeProfil: ImageArrondie!
    @IBOutlet weak var surnom: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var prenom: UILabel!
    //    @IBOutlet weak var numerDeTel: UILabel!
//    @IBOutlet weak var adresseMail: UILabel!
    
    var joueur: Joueur!
    
    func miseEnPlace(joueur: Joueur) {
        self.joueur = joueur
        
        photoDeProfil.image = self.joueur.photo as? UIImage

        if let leSurnom = self.joueur.surnom {
            surnom.text = leSurnom
        }
        if let leNom = self.joueur.nom {
            nom.text = leNom
        }
        if let lePrenom = self.joueur.prenom {
            prenom.text = lePrenom
        }


    }
    
}
