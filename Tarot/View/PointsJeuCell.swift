//
//  PointsJeuCell.swift
//  Tarot
//
//  Created by Serge Gori on 26/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class PointsJeuCell: UITableViewCell {
    
    @IBOutlet weak var idJeuLabel: UILabel!
    @IBOutlet weak var horodateLabel: UILabel!
    @IBOutlet weak var gainLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!    
    @IBOutlet weak var petitAuBoutLabel: UILabel!
    @IBOutlet weak var sousTotalLabel: UILabel!
    @IBOutlet weak var poigneeLabel: UILabel!
    @IBOutlet weak var chelemLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    func miseEnPlace(jR: JeuResultat) {
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM/YYYY HH:mm"
        horodateLabel.text = format.string(from: jR.horodate ?? Date())
    

        idJeuLabel.text = String(jR.idJeu)
        
        
        let score = JeuComplet(Contrat: Int(jR.contrat),
                               NombreDeBout: Int(jR.nbBout),
                               PointFaits: jR.pointsFaits,
                               PetitAuBout: Int(jR.petitAuBout),
                               Poignée: Int(jR.poignee),
                               Chelem: Int(jR.chelem))
        
        
        gainLabel.text = score.gainText()
        baseLabel.text = score.baseText()
        sousTotalLabel.text = score.SousTotalText()
        petitAuBoutLabel.text = score.pointsPetitAuBoutText()
        poigneeLabel.text = score.pointsPoigneeText()
        chelemLabel.text = score.pointsChelemText()
        totalLabel.text = score.totalText()
        
        
    }
    
    
}
