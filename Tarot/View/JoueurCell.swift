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
    
//    @IBOutlet weak var ordreLabel: UILabel!
    @IBOutlet weak var ordreImage: UIImageView!
    @IBOutlet weak var classementImage: UIImageView!
    
    @IBOutlet weak var jeuPointsLabel: UILabel!
    @IBOutlet weak var jeuEtatLabel: UILabel!
    
    var joueur: Joueur!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func miseEnPlace(joueur: Joueur, jeuJoueur: JeuJoueur?) {
        
        self.joueur = joueur
        // Mémorisation de idJoueur dans le tag de la cellule
        self.tag = Int(self.joueur.idJoueur)

        if !joueur.enJeu {
            contratLabel.text = EtatJoueur.horsJeu.nom
        } else {
            contratLabel.text = joueur.mort == true ? EtatJoueur.mort.nom : nil
        }
        
        let pts = FloatString(float: self.joueur.points)

        surnomLabel.text = dicoJoueurs[self.joueur.idJoueur]
        pointsLabel.text =  pts.string //String(self.joueur.points)
        pointsLabel.textColor = self.joueur.points > 0.0 ? UIColor.blue : UIColor.red

//        ordreLabel.text = String(self.joueur.ordre)
        ordreImage.image = UIImage(named: "icons8-cerclé-" + String(self.joueur.ordre) + "-1")
        classementImage.image = UIImage(named: "icons8-cerclé-" + String(self.joueur.classement) + "-1")

        let isEnable = !joueur.mort && joueur.enJeu
        contratLabel.isEnabled = isEnable
        surnomLabel.isEnabled = isEnable
        pointsLabel.isEnabled = isEnable
//        ordreLabel.isEnabled = isEnable
        ordreImage.isOpaque = isEnable
        
        donneurLabel.isEnabled = joueur.donneur

        donneurLabel.isHidden = !self.joueur.donneur
        ordreImage.isHidden = !defaultSettings.bool(forKey: donneAffJoueurs)
        classementImage.isHidden = !defaultSettings.bool(forKey: pointsAffJoueurs) || joueur.classement == 0

        // Affichage des informations d'une mène dans les cellules des joueurs
        do {
            jeuEtatLabel.text = String()
            jeuPointsLabel.text = String()
            if defaultSettings.bool(forKey: jeuxAffJoueurs) && defaultSettings.bool(forKey: jeuxAffJoueursEnCours)
                || defaultSettings.bool(forKey: jeuDernierAffJoueurs) {
                if let jeuJoueur = jeuJoueur {
                    let pts = FloatString(float: jeuJoueur.points)
                    jeuEtatLabel.text = EtatJoueur(rawValue: jeuJoueur.etat)?.nom
                    jeuPointsLabel.text = pts.string
                }
            }
        }
        
    }
}


class JeuJoueurCell: UITableViewCell {
    @IBOutlet weak var idJeuLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var contratLabel: UILabel!
    
//    var jeuJoueur: JeuJoueur!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func miseEnPlace(jeuJoueur: JeuJoueur, jeu: JeuResultat, offset: Int) {
        
//        self.jeuJoueur = jeuJoueur
        // Mémorisation de idJoueur dans le tag de la cellule
        self.tag = Int(jeuJoueur.idJoueur)

        // Affichage du contrat du preneur 
        contratLabel.text = jeuJoueur.etat == EtatJoueur.preneur.rawValue ? Contrat(rawValue: Int(jeu.contrat).minus())?.nom : String()

        idJeuLabel.text = String(Int(jeuJoueur.idJeu) - offset + 1)
//        idJeuLabel.text = String(jeuJoueur.idJeu)

        let pts = FloatString(float: jeuJoueur.points)
        pointsLabel.text =  pts.string //String(self.joueur.points)
        pointsLabel.textColor = jeuJoueur.points > 0.0 ? UIColor.blue : UIColor.red
        // Affichage de l'état du joueur s'il n'est pas le preneur
        etatLabel.text = jeuJoueur.etat != EtatJoueur.preneur.rawValue ? EtatJoueur(rawValue: jeuJoueur.etat)?.nom : String()


//        // Affichage des informations d'une mène dans les cellules des joueurs
//        do {
//            jeuEtatLabel.text = String()
//            jeuPointsLabel.text = String()
//            if defaultSettings.bool(forKey: jeuxAffJoueurs) && defaultSettings.bool(forKey: jeuxAffJoueursEnCours)
//                || defaultSettings.bool(forKey: jeuDernierAffJoueurs) {
//                if let jeuJoueur = jeuJoueur {
//                    let pts = FloatString(float: jeuJoueur.points)
//                    jeuPointsLabel.text = pts.string
//                }
//            }
//        }
        
    }

    
}
