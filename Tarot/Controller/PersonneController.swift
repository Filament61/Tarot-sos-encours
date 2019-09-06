//
//  PersonneController.swift
//  Tarot
//
//  Created by Serge Gori on 18/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class JoueursController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellId = "PersonneCell"
    
    var joueurs = [Personne]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //        view.layoutMargins.left = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPersonnes()
    }
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return joueursTab.count
    //    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joueurs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let joueurDeLaCell = joueurs[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PersonneCell {
            cell.miseEnPlace(personne: joueurDeLaCell)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if let _ = tableView.cellForRow(at: indexPath) as? PersonneCell {
                let personneASupprimmer = joueurs[indexPath.row]
                viewContext.delete(personneASupprimmer)
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                joueurs.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        default: break
        }
    }
    
    
    func fetchPersonnes() {
        //        let requete: NSFetchRequest<Joueur> = Joueur.fetchRequest()
        //        let tri = NSSortDescriptor(key: "nom", ascending: true)
        //        requete.sortDescriptors = [tri]
        
        joueurs = Personne.all()
        //        joueurs = Personne.joueurPartie(idJoueurs: [2,1,3,5,7])
        tableView.reloadData()
        
        //        do {
        //            joueurs = try contexte.fetch(requete)
        //            tableView.reloadData()
        //        } catch {
        //            print(error.localizedDescription)
        //        }
    }
    
    
}
