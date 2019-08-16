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
    
    @IBOutlet weak var tableTriBarButton: UIBarButtonItem!
    @IBOutlet weak var surnomTriBarButton: UIBarButtonItem!
    @IBOutlet weak var pointsTriBarButton: UIBarButtonItem!
    
    let cellJoueur = "JoueurCell"
    let cellJeu = "JeuCell"
    
    //    var joueurs = [Joueur]()
    var jeux: [JeuResultat]?
    var jeuJ: [JeuJoueur]?
    
    var cells =  [PersonneCell]()
    
    var preneur: JoueurCell?
    //    var preneur = JoueurCell()
    
    //    var partie = Partie()
    var jeu: JeuResultat?
    
    let idPartie = NSManagedObject.nextAvailble("idPartie", forEntityName: "Partie")
    let now = Date()
    
    // Est initialisée par le controlleur appelant
    var isNouvelle = true
    
    @IBOutlet weak var hauteurTableJoueurContrainte: NSLayoutConstraint!
    //    var donneur: varCirculaire?
    
    lazy var gestionJoueurs = GestionJoueurs(joueurs: [Joueur](), NouvellePartie: isNouvelle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joueursTableView.delegate = self
        joueursTableView.dataSource = self
        jeuxTableView.delegate = self
        jeuxTableView.dataSource = self
        //        miseEnPlace()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dicoJoueursMaJ()
        fetchParties()
        miseEnPlace()
        
        /// Si jeux est vide, alors c'est une partie nouvelle.
        /// Les enregistrements de Joueurs sont pour le prochain jeu !
        /// Sinon, il faut se positionner sur les joueurs suivants...
        //        if let jeux = jeux {
        //            //                if let _ = gestionJoueurs.preneur { gestionJoueurs.preneur = gestionJoueurs.joueursPartie[1] }
        //            //                if let _ = gestionJoueurs.partenaire { gestionJoueurs.partenaire = gestionJoueurs.joueursPartie[1] }
        //        }
        
        // On initialise la variable donneur avec les informations contenues dans la table Joueurs
        //        if let idxDonneur = joueurs.firstIndex(where: {$0.donneur == true}) {
        //            donneur?.reInit(nb: joueurs.count, ordre: idxDonneur)
        //        } else {
        //            donneur?.reInit(nb: joueurs.count, ordre: 1)
        //        }
        
        //        gestionJoueurs.nbJoueursPartie = joueurs.count
        //        joueurs = gestionJoueurs.donneSuivante(joueurs: joueurs)
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
            return gestionJoueurs.joueursPartie.count
        }
        if tableView == jeuxTableView {
            return jeux?.count ?? 0
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
            let joueurDeLaCell = gestionJoueurs.joueursPartie[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellJoueur) as? JoueurCell {
                cell.miseEnPlace(joueur: joueurDeLaCell)
                cell.isHighlighted = joueurDeLaCell.donneur == true
                return cell
            }
        }
        if tableView == jeuxTableView {
            if let jeuDeLaCell = jeux?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: cellJeu) as? JeuCell {
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
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var reponse: Bool = false
        if tableView == joueursTableView {
            guard let cell = tableView.cellForRow(at: indexPath) as? JoueurCell else { return false }
            reponse = (self.gestionJoueurs.joueursPartie.firstIndex(where: { $0.idJoueur == cell.tag && ($0.mort || !$0.enJeu )}) == nil)
        }
        if tableView == jeuxTableView {
            reponse = false
        }
        return reponse
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == joueursTableView {
            //            preneur = joueursTableView.cellForRow(at: indexPath) as! JoueurCell
            //        if preneur.ordre > 0 {
            //            self.performSegue(withIdentifier: "Segue", sender: self)
            //        }
        }
        if tableView == jeuxTableView {
            
        }
    }

    
    func choixContrat(contrat: Contrat, cell: JoueurCell) {
        if self.gestionJoueurs.modeJeu == ModeJeu.duo {
            if let _ = self.gestionJoueurs.preneur {
                self.gestionJoueurs.partenaire = self.gestionJoueurs.joueursPartie.first(where: { $0.idJoueur == cell.tag })
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewControllerID = "JeuResultatController"
                let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! JeuResultatController
                vc.gj = self.gestionJoueurs
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.gestionJoueurs.preneur = self.gestionJoueurs.joueursPartie.first(where: { $0.idJoueur == cell.tag })
                // Affectation du contrat choisi
                self.gestionJoueurs.contrat = contrat
                cell.contratLabel.text = self.gestionJoueurs.contrat?.nom
                print("\(self.gestionJoueurs.contrat?.nom ?? "") sélectionnée")
            }
        } else {
            self.gestionJoueurs.preneur = self.gestionJoueurs.joueursPartie.first(where: { $0.idJoueur == cell.tag })
            // Affectation du contrat choisi
            self.gestionJoueurs.contrat = contrat
            cell.contratLabel.text = self.gestionJoueurs.contrat?.nom
            print("\(self.gestionJoueurs.contrat?.nom ?? "") sélectionnée")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewControllerID = "JeuResultatController"
            let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! JeuResultatController
            vc.gj = self.gestionJoueurs
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == joueursTableView {
            guard let cell = tableView.cellForRow(at: indexPath) as? JoueurCell else { return nil }
            let petite = UIContextualAction(style: .normal, title: Contrat.petite.abv, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //                self.isEditing = false
                self.choixContrat(contrat: Contrat.petite, cell: cell)
                success(true)
            })
            petite.backgroundColor = Contrat.petite.couleur
            
            let garde = UIContextualAction(style: .normal, title: Contrat.garde.abv, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //self.isEditing = false
                self.choixContrat(contrat: Contrat.garde, cell: cell)
                success(true)
            })
            garde.backgroundColor = Contrat.garde.couleur
            
            let sans = UIContextualAction(style: .normal, title: Contrat.gardeSans.abv, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //                self.isEditing = false
                self.choixContrat(contrat: Contrat.gardeSans, cell: cell)
                success(true)
            })
            sans.backgroundColor = Contrat.gardeSans.couleur
            
            let contre = UIContextualAction(style: .normal, title: Contrat.gardeContre.abv, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //                self.isEditing = false
                self.choixContrat(contrat: Contrat.gardeContre, cell: cell)
                success(true)
            })
            contre.backgroundColor = Contrat.gardeContre.couleur
            
            return UISwipeActionsConfiguration(actions: [contre, sans, garde, petite])
        }
        
        func actionContrat() {
            
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
        //        self.joueurs.sort(by: { (first: Joueur, second: Joueur) -> Bool in
        //            return UIContentSizeCategory(rawValue: String(first.ordre)) > UIContentSizeCategory(rawValue: String(second.ordre))
        //        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "PartieEnCours" {
            //            let toto = 1
        }
        if segue.identifier == "NouvellePartie" {
            
        }
        if segue.identifier == "Segue" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewControllerID = "JeuResultatController"
            let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! JeuResultatController
            vc.gj = self.gestionJoueurs
            self.navigationController?.pushViewController(vc, animated: true)
            //            let qui = self.preneur.idx
            let JeuResultatController = segue.destination as! JeuResultatController
            //            JeuResultatController.preneur = preneur.ordre - 1
            //                JeuResultatController.joueurs = joueurs
            //                JeuResultatController.donneur = donneur
            JeuResultatController.gj = gestionJoueurs
            
        }
    }
    
    func miseEnPlace() {
        // Réglage de la hauteur du tableau des joueurs
        self.joueursTableView.layoutIfNeeded()
        self.hauteurTableJoueurContrainte.constant = self.joueursTableView.contentSize.height
        // Mise à jour des icones de tri
        tableTriBarButton.image = defaultSettings.integer(forKey: "tableJoueursPartieOrdre") == How.asc.rawValue ?
            UIImage(named: "icons8-tri-numérique-fin") : UIImage(named: "icons8-tri-numérique-inversé-fin")
        surnomTriBarButton.image = defaultSettings.integer(forKey: "surnomJoueursPartieOrdre") == How.asc.rawValue ?
            UIImage(named: "icons8-tri-alphabétique-fin") : UIImage(named: "icons8-tri-alphabétique-inversé-fin")
        pointsTriBarButton.image = defaultSettings.integer(forKey: "pointsJoueursPartieOrdre") == How.asc.rawValue ?
            UIImage(named: "icons8-tri") : UIImage(named: "icons8-tri-inversé")
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
            gestionJoueurs = GestionJoueurs(joueurs: setJoueurs?.allObjects as! [Joueur], NouvellePartie: isNouvelle)
            let decode = gestionJoueurs.decodeTypePartie(typePartie: AppDelegate.partie.type)
            gestionJoueurs.modeJeu = decode.modeJeu
            joueursTableView.reloadData()
            
            // Traitement des jeux
            let setJeux = AppDelegate.partie.jeux
            jeux = setJeux?.allObjects as? [JeuResultat]
            jeux?.sort(by: { $0.idJeu > $1.idJeu })
            jeuxTableView.reloadData()
            
            // Traitement des jeuJoueurs
            //            let setJeuJoueurs = AppDelegate.jeu.joueurs
            //            if var jeuJ = setJeuJoueurs?.allObjects as? [JeuJoueur] {
            //                jeuJ.sort(by: { $0.idJeu > $1.idJeu })
            //
            //            }
            //            jeuxTableView.reloadData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func nouveauJeuAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerID = "JeuResultatController"
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! JeuResultatController
        
        vc.gj = self.gestionJoueurs
        //        vc.isNouvelle = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func horsJeuJoueurAction(_ sender: Any) {
        // Vérification du nombre de joueurs possible avant d'autoriser une suppression. Est fonction du mode de jeu.
        if gestionJoueurs.nbJoueursEnjeu > gestionJoueurs.modeJeu!.nbJoueurs.min {
            let controller = UIAlertController(title: "Mise hors-jeu d'un joueur", message: "Quelqu'un nous abandonne ?", preferredStyle: .alert)
            // On supprime dabords les morts s'il y en a
            let Joueurs = gestionJoueurs.nbJoueursMort > 0 ? gestionJoueurs.joueursMort : gestionJoueurs.joueursEnJeu
            for joueur in Joueurs! {
                controller.addAction(UIAlertAction(title: dicoJoueurs[joueur.idJoueur], style: .destructive, handler: { _ in self.mettreHorsJeuJoueur(joueur: joueur) }))
            }
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            //        controller.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { _ in self.resetData() }))
            present(controller, animated: true, completion: nil)
        } else {
            var message = "Dans ce mode, vous n'êtes pas suffisament nombreux pour mettre hors-jeu un joueur supplémentaire !" + "\n"
            message += "\(gestionJoueurs.modeJeu!.nbJoueurs.min.minus()) < " + gestionJoueurs.modeJeu!.nom + " < \(gestionJoueurs.modeJeu!.nbJoueurs.max.plus())"
            let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func mettreHorsJeuJoueur(joueur: Joueur) {
        if let precedent = gestionJoueurs.joueursEnJeu.first(where: { $0.suivant == joueur.ordre }) {
            // Mise à jour de l'index suivant
            precedent.suivant = joueur.suivant
            joueur.enJeu = false
        } else {
            let message = "La mise à jour de ce joueur ne s'est pas réalisée correctement !"
            let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if Partie.save() {
            joueursTableView.reloadData()
        } else {
            let message = "La mise à jour de ce joueur ne s'est pas réalisée correctement !"
            let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func donneSuivanteAction(_ sender: Any) {
        if gestionJoueurs.donneurSuivant() == false {
            let message = "Il n'y a plus de donneur suivant en jeu !"
            let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        if gestionJoueurs.mortSuivant() == false {
            let message = "Il n'y a plus de mort suivant en jeu !"
            let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        if Partie.save() {
            joueursTableView.reloadData()
        } else {
            let message = "La mise à jour de ce joueur ne s'est pas réalisée correctement !"
            let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func triTableAction(_ sender: Any) {
        if defaultSettings.integer(forKey: "triJoueursPartie") == TriJoueurs.table.rawValue {
            // Changement et mémorisation de l'ordre de tri
            let nouvelOrdre = defaultSettings.integer(forKey: "tableJoueursPartieOrdre") == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
            defaultSettings.set(nouvelOrdre, forKey: "tableJoueursPartieOrdre")
            tableTriBarButton.image = defaultSettings.integer(forKey: "tableJoueursPartieOrdre") == How.asc.rawValue ?
                UIImage(named: "icons8-tri-numérique-fin") : UIImage(named: "icons8-tri-numérique-inversé-fin")
        } else {
            // Mémorisation du changement du type de tri
            defaultSettings.set(TriJoueurs.table.rawValue, forKey: "triJoueursPartie")
        }
        if let how = How(rawValue: defaultSettings.integer(forKey: "tableJoueursPartieOrdre")) {
            gestionJoueurs.tri(choix: .table, how: how)
            joueursTableView.reloadData()
        }
    }
    
    @IBAction func triSurnomAction(_ sender: Any) {
        if defaultSettings.integer(forKey: "triJoueursPartie") == TriJoueurs.surnom.rawValue {
            // Changement et mémorisation de l'ordre de tri
            let nouvelOrdre = defaultSettings.integer(forKey: "surnomJoueursPartieOrdre") == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
            defaultSettings.set(nouvelOrdre, forKey: "surnomJoueursPartieOrdre")
            surnomTriBarButton.image = defaultSettings.integer(forKey: "surnomJoueursPartieOrdre") == How.asc.rawValue ?
                UIImage(named: "icons8-tri-alphabétique-fin") : UIImage(named: "icons8-tri-alphabétique-inversé-fin")
        } else {
            // Mémorisation du changement du type de tri
            defaultSettings.set(TriJoueurs.surnom.rawValue, forKey: "triJoueursPartie")
        }
        if let how = How(rawValue: defaultSettings.integer(forKey: "surnomJoueursPartieOrdre")) {
            gestionJoueurs.tri(choix: .surnom, how: how)
            joueursTableView.reloadData()
        }
    }
    
    @IBAction func triPointsAction(_ sender: Any) {
        if defaultSettings.integer(forKey: "triJoueursPartie") == TriJoueurs.points.rawValue {
            // Changement et mémorisation de l'ordre de tri
            let nouvelOrdre = defaultSettings.integer(forKey: "pointsJoueursPartieOrdre") == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
            defaultSettings.set(nouvelOrdre, forKey: "pointsJoueursPartieOrdre")
            pointsTriBarButton.image = defaultSettings.integer(forKey: "pointsJoueursPartieOrdre") == How.asc.rawValue ?
                UIImage(named: "icons8-tri") : UIImage(named: "icons8-tri-inversé")
        } else {
            // Mémorisation du changement du type de tri
            defaultSettings.set(TriJoueurs.points.rawValue, forKey: "triJoueursPartie")
        }
        if let how = How(rawValue: defaultSettings.integer(forKey: "pointsJoueursPartieOrdre")) {
            gestionJoueurs.tri(choix: .points, how: how)
            joueursTableView.reloadData()
        }
    }
}
