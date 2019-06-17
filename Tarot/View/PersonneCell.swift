//
//  PersonneCell.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class PersonneCell: UITableViewCell {
    
    @IBOutlet weak var photoDeProfil: ImageArrondie!
    @IBOutlet weak var nomEtPrenom: UILabel!
    @IBOutlet weak var numerDeTel: UILabel!
    @IBOutlet weak var adresseMail: UILabel!
    
    var personne: Personne!
    
    func miseEnPlace(personne: Personne) {
        self.personne = personne
        photoDeProfil.image = self.personne.photo as? UIImage
        var nomComplet = ""
        if let prenom = self.personne.prenom {
            nomComplet += "Prenom: " + prenom + " "
        }
        if let nom = self.personne.nom {
            nomComplet += "Nom: " + nom
        }
//        nomEtPrenom.text = nomComplet
//        let num = String(self.personne.numero)
//        numerDeTel.text = num
//        adresseMail.text = self.personne.mail ?? ""
        
    }
    
}
