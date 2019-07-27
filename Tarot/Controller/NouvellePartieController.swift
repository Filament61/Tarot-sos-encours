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
    
    @IBOutlet weak var idPartieLabel: UILabel!
    @IBOutlet weak var horodateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listeJoueurs: UILabel!
    @IBOutlet weak var nbJoueursImage: UIImageView!
    
    var cellId = "PersonneCell"
    
    var joueurs = [Personne]()
    var cellTab = [PersonneCell]()
    var cells =  [PersonneCell]()
    //    var preneur = PersonneCell()
    
    var partie = Partie()
    
    let idPartie = NSManagedObject.nextAvailble("idPartie", forEntityName: "Partie")
    let now = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        miseEnPlace()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJoueurs()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joueurs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // ATTENTION SI LA LISTE EST TROP LONGUE --> MAUVAISE GESTION DES INDEX
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let joueurDeLaCell = joueurs[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PersonneCell {
            cell.miseEnPlace(personne: joueurDeLaCell)
            return cell
        }
        return UITableViewCell()
        
    }
    
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        switch editingStyle {
    //        case .delete:
    //            if let _ = tableView.cellForRow(at: indexPath) as? JoueurCell {
    //                let personneASupprimmer = joueurs[indexPath.row]
    //                contexte.delete(personneASupprimmer)
    //                do {
    //                    try contexte.save()
    //                } catch {
    //                    print(error.localizedDescription)
    //                }
    //                joueurs.remove(at: indexPath.row)
    //                self.tableView.deleteRows(at: [indexPath], with: .fade)
    //            }
    //
    //        default: break
    //        }
    //    }
    
    
    func fetchJoueurs() {
        let requete: NSFetchRequest<Personne> = Personne.fetchRequest()
        let tri = NSSortDescriptor(key: "nom", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            joueurs = try viewContext.fetch(requete)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        preneur = tableView.cellForRow(at: indexPath) as! PersonneCell
        //        if preneur.idx > 0 {
        //            self.performSegue(withIdentifier: "Segue", sender: self)
        //        }
    }
    
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let petite = UIContextualAction(style: .normal, title:  "Petite", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
    //            //self.isEditing = false
    ////                        let cell = tableView.cellForRow(at: indexPath) as! JoueurCell
    ////            self.preneur = cell
    //            self.performSegue(withIdentifier: "Segue", sender: self)
    //            print("more button tapped")
    //            success(false)
    //        })
    //        petite.backgroundColor = UIColor.lightGray
    //
    //        let garde = UIContextualAction(style: .normal, title:  "Garde", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
    //            //self.isEditing = false
    //            print("favorite button tapped")
    //            success(false)
    //        })
    //        garde.backgroundColor = UIColor.orange
    //
    //        let sans = UIContextualAction(style: .normal, title:  "Sans", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
    //            //self.isEditing = false
    //            print("share button tapped")
    //            success(false)
    //        })
    //        sans.backgroundColor = UIColor.blue
    //            let contre = UIContextualAction(style: .normal, title:  "Contre", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
    //                //self.isEditing = false
    //                print("share button tapped")
    //                success(false)
    //        })
    //        contre.backgroundColor = UIColor.green
    //
    //
    //        return UISwipeActionsConfiguration(actions: [contre, sans, garde, petite,])
    //    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //        return UISwipeActionsConfiguration()
        
        guard let cell = tableView.cellForRow(at: indexPath) as? PersonneCell else { return nil }
        
        let choixAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            // Recherche d'une cellule déjà sélectionnée
            if let pointeur = self.cellTab.firstIndex(of: cell) {
                self.cellTab.remove(at: pointeur)
                cell.idx = -1
                print("Index existant : \(pointeur)")
                // Mise à jour des cellules déjà sélectionnées
                var item = pointeur
                while item < self.cellTab.count {
                    self.cellTab[item].idx = item + 1
                    item += 1
                    print("Réindexation : \(item)")
                }
                // Nouvelle cellule sélectionnée
            } else {
                self.cellTab.append(cell)
                cell.idx = self.cellTab.count
                print("Index nouveau : \(self.cellTab.count)")
            }
            for item in self.cellTab {
                let surnom = item.surnom.text
                print("Choix : \(surnom ?? "")")
            }
            
            self.listeJoueurs.text = ""
            for joueur in self.cellTab {
                self.listeJoueurs.text = self.listeJoueurs.text! + joueur.surnom.text! + "\n"
            }
            
            self.nbJoueursImage.image = UIImage(named: "icons8-cerclé-" + String(self.cellTab.count) + "-1")
            success(true)
        })
        
        if let _ = self.cellTab.firstIndex(of: cell) {
            choixAction.image = UIImage(named: "icons8-annuler-(dernier-chiffre)-50")
            choixAction.backgroundColor = .red
        } else {
            choixAction.image = UIImage(named: "icons8-cerclé-" + String(cellTab.count + 1) + "-1")
            choixAction.backgroundColor = .purple
        }
        
        return UISwipeActionsConfiguration(actions: [choixAction])
    }
    
    
    @IBAction func Tri(_ sender: UIBarButtonItem) {
        self.joueurs.sort(by: { (first: Personne, second: Personne) -> Bool in
            return UIContentSizeCategory(rawValue: first.surnom!) > UIContentSizeCategory(rawValue: second.surnom!)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Mise à jour du dictionnaire des noms des joueurs
        dicoJoueurs.removeAll()
        for item in cellTab {
            dicoJoueurs[Int(item.idJoueurLabel.text!)!] = item.surnom.text
        }
        
        if segue.identifier == "Segue" {
            //            let qui = self.preneur.idx
            let PartieController = segue.destination as! PartieController
            //            PartieController.preneur = preneur.idx - 1
            PartieController.cellTab = cellTab
        }
    }
    
    func miseEnPlace() {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/YYYY HH:mm"
        horodateLabel.text = format.string(from: now)
        
        idPartieLabel.text = String(idPartie)
        
        nbJoueursImage.image = UIImage(named: "icons8-cerclé-0-1")
    }
    
    @IBAction func nouvellePartieAction(_ sender: Any) {
        //        var participants = partie.mutableSetValue(forKey: #keyPath(Partie.participants))
        
        Partie.save(partie, participants: cellTab, idPartie: idPartie, hD: now)
        
        fetchParties()
    }
    
    
    func fetchParties() {
        let requete: NSFetchRequest<Partie> = Partie.fetchRequest()
        let tri = NSSortDescriptor(key: "idPartie", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            let parties = try viewContext.fetch(requete)
            //            tableView.reloadData()
            let toto = parties.count
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


