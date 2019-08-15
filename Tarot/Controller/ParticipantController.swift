//
//  ParticipantsController.swift
//  Tarot
//
//  Created by Serge Gori on 17/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class ParticipantController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellId = "ParticipantCell"
    
    var participants = [Joueur]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchParticipants()
    }
    
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return joueursTab.count
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let participantDeLaCell = participants[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ParticipantCell {
            cell.miseEnPlace(participant: participantDeLaCell)
            return cell
        }
        return UITableViewCell()
        
    }
    
    func fetchParticipants() {
        participants = Joueur.all(TrierPar: .points)
        tableView.reloadData()
    }
    
}
