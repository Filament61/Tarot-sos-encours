//
//  ParticipantCell.swift
//  Tarot
//
//  Created by Serge Gori on 17/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit


class ParticipantCell: UITableViewCell {
    
    @IBOutlet weak var ordreLabel: UILabel!
    @IBOutlet weak var idJoueurLabel: UILabel!
    
    var participant: Joueur!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func miseEnPlace(participant: Joueur) {
        
        self.participant = participant
        
        idJoueurLabel.text = String(self.participant.idJoueur)
        ordreLabel.text = String(self.participant.ordre)
    }
    
    
}
