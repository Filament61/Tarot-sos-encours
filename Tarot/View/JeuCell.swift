//
//  JeuCell.swift
//  Tarot
//
//  Created by Serge Gori on 27/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit


class JeuCell: UITableViewCell {

    @IBOutlet weak var idJeuLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var jeu: JeuResultat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func miseEnPlace(jeu: JeuResultat) {
        
        self.jeu = jeu
        
        idJeuLabel.text = String(jeu.idJeu)
        totalLabel.text = String(jeu.total)
    }
}
