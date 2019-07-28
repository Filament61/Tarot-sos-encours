//
//  PartieController.swift
//  Tarot
//
//  Created by Serge Gori on 22/07/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class PartieController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var joueursTableView: UITableView!
    @IBOutlet weak var jeuxTableView: UITableView!
    
    var cellJoueur = "JoueurCell"
    var cellJeu = "JeuCell"

    var joueurs = [Joueur]()
    var jeux = [JeuResultat]()

    var cells =  [PersonneCell]()
    
    var preneur = JoueurCell()
//    var preneur = JoueurCell()

//    var partie = Partie()
    var jeu = JeuResultat()

    let idPartie = NSManagedObject.nextAvailble("idPartie", forEntityName: "Partie")
    let now = Date()

    // Est initialisée par le controlleur appelant
    var isNouvelle = true
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        joueursTableView.delegate = self
        joueursTableView.dataSource = self
        jeuxTableView.delegate = self
        jeuxTableView.dataSource = self
        miseEnPlace()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dicoJoueursMaJ()
        fetchParties()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == joueursTableView {
            return 1
        }
        if tableView == jeuxTableView {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == joueursTableView {
            return joueurs.count
        }
        if tableView == jeuxTableView {
            return jeux.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == joueursTableView {
            return 54
        }
        if tableView == jeuxTableView {
            return 22
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == joueursTableView {
            let joueurDeLaCell = joueurs[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellJoueur) as? JoueurCell {
                cell.miseEnPlace(joueur: joueurDeLaCell)
                return cell
            }
        }
        if tableView == jeuxTableView {
            let jeuDeLaCell = jeux[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellJeu) as? JeuCell {
                cell.miseEnPlace(jeu: jeuDeLaCell)
                return cell
            }
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
        let requete: NSFetchRequest<Joueur> = Joueur.fetchRequest()
        let tri = NSSortDescriptor(key: "ordre", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            joueurs = try viewContext.fetch(requete)
            joueursTableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == joueursTableView {
            return true
        }
        if tableView == jeuxTableView {
            return false
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == joueursTableView {
            preneur = joueursTableView.cellForRow(at: indexPath) as! JoueurCell
            //        if preneur.ordre > 0 {
            //            self.performSegue(withIdentifier: "Segue", sender: self)
            //        }
        }
        if tableView == jeuxTableView {

        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == joueursTableView {
            let petite = UIContextualAction(style: .normal, title:  "Petite", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //self.isEditing = false
                //                        let cell = tableView.cellForRow(at: indexPath) as! JoueurCell
                //            self.preneur = cell
                self.performSegue(withIdentifier: "Segue", sender: self)
                print("more button tapped")
                success(false)
            })
            petite.backgroundColor = UIColor.lightGray
            
            let garde = UIContextualAction(style: .normal, title:  "Garde", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //self.isEditing = false
                print("favorite button tapped")
                success(false)
            })
            garde.backgroundColor = UIColor.orange
            
            let sans = UIContextualAction(style: .normal, title:  "Sans", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //self.isEditing = false
                print("share button tapped")
                success(false)
            })
            sans.backgroundColor = UIColor.blue
            
            let contre = UIContextualAction(style: .normal, title:  "Contre", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //self.isEditing = false
                print("share button tapped")
                success(false)
            })
            contre.backgroundColor = UIColor.green
            
            return UISwipeActionsConfiguration(actions: [contre, sans, garde, petite,])
        }
        
        
        if tableView == jeuxTableView {
            return UISwipeActionsConfiguration()
            
        }
        return UISwipeActionsConfiguration()
    }
    
    //    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //        //        return UISwipeActionsConfiguration()
    //
    //        guard let cell = tableView.cellForRow(at: indexPath) as? PersonneCell else { return nil }
    //
    //        let choixAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
    //
    //            // Recherche d'une cellule déjà sélectionnée
    //            if let pointeur = self.cellTab.firstIndex(of: cell) {
    //                self.cellTab.remove(at: pointeur)
    //                cell.idx = -1
    //                print("Index existant : \(pointeur)")
    //                // Mise à jour des cellules déjà sélectionnées
    //                var item = pointeur
    //                while item < self.cellTab.count {
    //                    self.cellTab[item].idx = item + 1
    //                    item += 1
    //                    print("Réindexation : \(item)")
    //                }
    //                // Nouvelle cellule sélectionnée
    //            } else {
    //                self.cellTab.append(cell)
    //                cell.idx = self.cellTab.count
    //                print("Index nouveau : \(self.cellTab.count)")
    //            }
    //            for item in self.cellTab {
    //                let surnom = item.surnom.text
    //                print("Choix : \(surnom ?? "")")
    //            }
    //
    //            self.listeJoueurs.text = ""
    //            for joueur in self.cellTab {
    //                self.listeJoueurs.text = self.listeJoueurs.text! + joueur.surnom.text! + "\n"
    //            }
    //
    //            self.nbJoueursImage.image = UIImage(named: "icons8-cerclé-" + String(self.cellTab.count) + "-1")
    //            success(true)
    //        })
    //
    //        if let _ = self.cellTab.firstIndex(of: cell) {
    //            choixAction.image = UIImage(named: "icons8-annuler-(dernier-chiffre)-50")
    //            choixAction.backgroundColor = .red
    //        } else {
    //            choixAction.image = UIImage(named: "icons8-cerclé-" + String(cellTab.count + 1) + "-1")
    //            choixAction.backgroundColor = .purple
    //        }
    //
    //        return UISwipeActionsConfiguration(actions: [choixAction])
    //    }
    //
    
    @IBAction func Tri(_ sender: UIBarButtonItem) {
        self.joueurs.sort(by: { (first: Joueur, second: Joueur) -> Bool in
            return UIContentSizeCategory(rawValue: String(first.ordre)) > UIContentSizeCategory(rawValue: String(second.ordre))
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PartieEnCours" {
            let toto = 1
        }
        if segue.identifier == "NouvellePartie" {
            
        }
        if segue.identifier == "Segue" {
            //            let qui = self.preneur.idx
            let JeuResultatController = segue.destination as! JeuResultatController
            //            JeuResultatController.preneur = preneur.ordre - 1
            JeuResultatController.joueurs = joueurs
        }
    }
    
    func miseEnPlace() {
        //        let format = DateFormatter()
        //        format.dateFormat = "dd/MM/YYYY HH:mm"
        //        horodateLabel.text = format.string(from: now)
        //
        //        idPartieLabel.text = String(idPartie)
        //
        //        nbJoueursImage.image = UIImage(named: "icons8-cerclé-0-1")
    }
    
    
    func fetchParties() {
        let requete: NSFetchRequest<Partie> = Partie.fetchRequest()
        let tri = NSSortDescriptor(key: "idPartie", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            let parties = try viewContext.fetch(requete)
            AppDelegate.partie = parties.last!
            
            // Traitement des joueurs
            let setJoueurs = AppDelegate.partie.participants
            joueurs = setJoueurs?.allObjects as! [Joueur]
            joueurs.sort(by: { $0.ordre < $1.ordre })
            joueursTableView.reloadData()
            
            // Traitement des jeux
            let setJeux = AppDelegate.partie.jeux
            jeux = setJeux?.allObjects as! [JeuResultat]
            jeux.sort(by: { $0.idJeu > $1.idJeu })
            jeuxTableView.reloadData()

        } catch {
            print(error.localizedDescription)
        }
    }

}
