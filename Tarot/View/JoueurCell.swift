//
//  JoueurCell.swift
//  Tarot
//
//  Created by Serge Gori on 22/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit


class JoueurCell: UITableViewCell {
    
    @IBOutlet weak var surnomLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var donneurLabel: UILabel!
    @IBOutlet weak var contratLabel: UILabel!
    
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
        
        donneurLabel.isHidden = self.joueur.donneur == false
        surnomLabel.text = dicoJoueurs[Int(self.joueur.idJoueur)]
        pointsLabel.text = String(self.joueur.points)
        ordreImage.image = UIImage(named: "icons8-cerclé-" + String(self.joueur.ordre) + "-1")
//        classementImage.image = UIImage(named: "icons8-cerclé-" + String(self.joueur.classement) + "-1")
        
//        self.self.isEditing = joueur.donneur == false
    }
    
    
}

