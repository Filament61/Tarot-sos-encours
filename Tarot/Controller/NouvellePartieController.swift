//
//  NouvellePartieController.swift
//  Tarot
//
//  Created by Serge Gori on 22/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class NouvellePartieController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellId = "JoueurCell"
    
    var joueurs = [Joueur]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJoueurs()
    }
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return joueursTab.count
    //    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joueurs.count
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 320
    //    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? UITableViewCell
        //        cell?.textLabel?.text = "\(indexPath.row)"
        //        return cell!
        //
        let joueurDeLaCell = joueurs[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? JoueurCell {
            cell.miseEnPlace(personne: joueurDeLaCell)
            return cell
        }
        return UITableViewCell()
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if let personneASupprimmer = joueurs[indexPath.row] as? Joueur {
                contexte.delete(personneASupprimmer)
                do {
                    try contexte.save()
                } catch {
                    print(error.localizedDescription)
                }
                joueurs.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        default: break
        }
    }
    
    
    func fetchJoueurs() {
        let requete: NSFetchRequest<Joueur> = Joueur.fetchRequest()
        let tri = NSSortDescriptor(key: "nom", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            joueurs = try contexte.fetch(requete)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let more = UIContextualAction(style: .normal, title:  "More", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //self.isEditing = false
            print("more button tapped")
            success(true)
        })
        more.backgroundColor = UIColor.lightGray
        
        let favorite = UIContextualAction(style: .normal, title:  "favorite", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //self.isEditing = false
            print("favorite button tapped")
            success(true)
        })
        favorite.backgroundColor = UIColor.orange
        
        let share = UIContextualAction(style: .normal, title:  "share", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //self.isEditing = false
            print("share button tapped")
            success(true)
        })
        share.backgroundColor = UIColor.blue
        
        return UISwipeActionsConfiguration(actions: [share, favorite, more,])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, marked as Closed")
            success(true)
        })
        closeAction.image = UIImage(named: "tick")
        closeAction.backgroundColor = .purple
        
        return UISwipeActionsConfiguration(actions: [closeAction])

    }
    
}
