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
    @IBOutlet weak var triBarButton: UIBarButtonItem!
    
    let joueurCell = "JoueurCell"
    let jeuJoueurCell = "JeuJoueurCell"
    let jeuCell = "JeuCell"
    
    /// Numéro de l'index du premier jeu de la partie
    var offsetJeu = Int()
    //    var joueurs = [Joueur]()
    var jeux: [JeuResultat]? {
        didSet {
            if let idx = jeux?.last?.idJeu, let idxEnCours = jeux?.first?.idJeu {
                offsetJeu = Int(idx)
                self.title = "Jeu n°\(Int(idxEnCours) - offsetJeu + 2)"
                print("offset = \(offsetJeu)")
            }
        }
    }
    
    var jeuJoueurs: [JeuJoueur]?
    
//    var cells =  [PersonneCell]()
    
    var oldCell: JoueurCell?
    var oldIndexPath = IndexPath()

    var jeu: JeuResultat?
    
    let idPartie = NSManagedObject.nextAvailble("idPartie", forEntityName: "Partie")
    let now = Date()
    
    let joueursTableViewHeightForRow: CGFloat = 54
    let jeuJoueursTableViewHeightForRow: CGFloat = 20
    let jeuxTableViewHeightForRow: CGFloat = 26

    // Est initialisée par le controlleur appelant
    var isNouvelle = true
    
    @IBOutlet weak var hauteurTableJoueurContrainte: NSLayoutConstraint!
    //    var donneur: varCirculaire?
    
    lazy var gestionJoueurs = GestionJoueurs(joueurs: [Joueur](), NouvellePartie: isNouvelle)
    
    var timer: Timer?
    var timeLeft = 31
    @objc func onTimerFires() {
        timeLeft -= 1
        print("\(timeLeft) second left")
        //                timeLabel.text = "\(timeLeft) seconds left"
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            UIScreen.main.brightness = CGFloat(0.00000)
        }
    }

    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joueursTableView.delegate = self
        joueursTableView.dataSource = self
        jeuxTableView.delegate = self
        jeuxTableView.dataSource = self
        dicoJoueursMaJ()
        fetchParties()
        miseEnPlace()
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchParties()
        miseEnPlace()
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    func miseEnPlace() {
        // Réglage de la hauteur de la contrainte ajoutée au tableau des joueurs
        self.hauteurTableJoueurContrainte.constant = self.joueursTableView.contentSize.height
        
        // Si affichage des informations de la dernière mène dans les cellules des joueurs
        if defaultSettings.bool(forKey: jeuDernierAffJoueurs) {
            if let idJeu = jeux?.first?.idJeu {
                jeuJoueurs = fetchJeuJoueurs(idJeu: [Int(idJeu)])
                jeuxTableView.selectRow(at: [0,0], animated: true, scrollPosition: UITableView.ScrollPosition.top)
            }
        }
        
        // Mise à jour des icones de tri
        tableTriBarButton.image = defaultSettings.integer(forKey: "tableJoueursPartieOrdre") == How.asc.rawValue ?
            UIImage(named: "icons8-tri-numérique-fin") : UIImage(named: "icons8-tri-numérique-inversé-fin")
        surnomTriBarButton.image = defaultSettings.integer(forKey: "surnomJoueursPartieOrdre") == How.asc.rawValue ?
            UIImage(named: "icons8-tri-alphabétique-fin") : UIImage(named: "icons8-tri-alphabétique-inversé-fin")
        pointsTriBarButton.image = defaultSettings.integer(forKey: "pointsJoueursPartieOrdre") == How.asc.rawValue ?
            UIImage(named: "icons8-tri") : UIImage(named: "icons8-tri-inversé")
        if let tri = TriJoueurs(rawValue: defaultSettings.integer(forKey: triJoueursPartie)), let how = How(rawValue: defaultSettings.integer(forKey: tri.udHow)) {
            triBarButton.image = tri.image(how: how)
        }
    }
    

    // MARK: - Table view data source -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == joueursTableView {
            return gestionJoueurs.joueursPartie.count
        }
        if tableView == jeuxTableView {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == joueursTableView {
            return jeuJoueurs == nil ? 1 : 2
        }
        if tableView == jeuxTableView {
            return jeux?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == joueursTableView {
            if indexPath.row == 0 {
                return joueursTableViewHeightForRow
            }
            if indexPath.row == 1 {
                return jeuJoueursTableViewHeightForRow //31
            }
        }
        if tableView == jeuxTableView {
            return jeuxTableViewHeightForRow
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == joueursTableView {
            if indexPath.row == 0 {
                return joueursTableViewHeightForRow
            }
            if indexPath.row == 1 {
                return jeuJoueursTableViewHeightForRow //31
            }
        }
        if tableView == jeuxTableView {
            return jeuxTableViewHeightForRow
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == joueursTableView && section == 0 {
            return "Joueurs"
        }
        if tableView == jeuxTableView && section == 0 {
            return "Jeux"
        }
        return String()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == joueursTableView {
            if indexPath.row == 0 {
                let joueurDeLaCell = gestionJoueurs.joueursPartie[indexPath.section]
                if let cell = tableView.dequeueReusableCell(withIdentifier: joueurCell) as? JoueurCell {
                    let jeuJoueur = jeuJoueurs?.first(where: { $0.idJoueur == joueurDeLaCell.idJoueur })
                    cell.miseEnPlace(joueur: joueurDeLaCell, jeuJoueur: jeuJoueur)
                    //                cell.isHighlighted = joueurDeLaCell.donneur == true
                    return cell
                }
            }
            if indexPath.row == 1 {
                let joueurDeLaCell = gestionJoueurs.joueursPartie[indexPath.section]
                if let cell = tableView.dequeueReusableCell(withIdentifier: jeuJoueurCell) as? JeuJoueurCell {
                    if let row = jeuxTableView.indexPathForSelectedRow?.row, let jeu = jeux?[row] {
                        if let jeuJoueurs = fetchJeuJoueurs(idJeu: [Int(jeu.idJeu)]) as [JeuJoueur]? {
                            if let jeuJoueur = jeuJoueurs.first(where: { $0.idJoueur == joueurDeLaCell.idJoueur }) {
                                cell.miseEnPlace(jeuJoueur: jeuJoueur, jeu: jeu, offset: offsetJeu)
                            //                cell.isHighlighted = joueurDeLaCell.donneur == true
                            return cell
                            }
                        }
                    }
                }
            }
        }
        if tableView == jeuxTableView {
            if let jeuDeLaCell = jeux?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: jeuCell) as? JeuCell {
                cell.miseEnPlace(jeu: jeuDeLaCell, offset: offsetJeu)
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
//    func tab
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var reponse: Bool = false
        if tableView == joueursTableView {
//            let cell = joueursTableView.cellForRow(at: indexPath)
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
            guard let cell = tableView.cellForRow(at: indexPath) as? JoueurCell else { return }
            if let joueur = (gestionJoueurs.joueursEnMene.first(where: { $0.idJoueur == cell.tag }) ) {
                if let oldCell = self.oldCell, oldCell != cell {
                    oldCell.contratLabel.isEnabled = false
                    oldCell.contratLabel.text = String()
                }
                if let contrat = gestionJoueurs.contrat {
                    gestionJoueurs.contrat = contrat.suivant()
                } else {
                    gestionJoueurs.contrat = Contrat.petite
                }
                self.gestionJoueurs.preneur = joueur
                cell.contratLabel.text = self.gestionJoueurs.contrat?.nom
                cell.contratLabel.isEnabled = true
                print("\(self.gestionJoueurs.contrat?.nom ?? "") sélectionnée")
                //            self.choixContrat(contrat: Contrat.petite, cell: cell)
                oldCell = cell
                oldIndexPath = indexPath
            } else {
                if oldIndexPath != IndexPath(), oldIndexPath != indexPath {
                tableView.selectRow(at: oldIndexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
                }
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        if tableView == jeuxTableView && indexPath.section == 0 {
            guard let cell = tableView.cellForRow(at: indexPath) as? JeuCell else { return }
            if defaultSettings.bool(forKey: jeuxAffJoueurs) {//&& majJeuJoueurs(idJeu: cell.tag) {
                defaultSettings.set(true, forKey: jeuxAffJoueursEnCours)
                defaultSettings.set(cell.tag, forKey: jeuxcellAffJoueursEnCours)
                joueursTableView.reloadData()
            } else if defaultSettings.bool(forKey: jeuDernierAffJoueurs) {
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.selectRow(at: [0, 0], animated: true, scrollPosition: UITableView.ScrollPosition.top)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    func majJeuJoueurs(idJeu: Int) -> Bool {
        guard let jeuJoueurs = fetchJeuJoueurs(idJeu: [Int(idJeu)]) as [JeuJoueur]? else { return false }
        for row in 0..<gestionJoueurs.nbJoueursPartie {
            if let cell = joueursTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? JoueurCell {
                if let jeuJoueur = jeuJoueurs.first(where: { $0.idJoueur == Int16(cell.tag) }) {
                    let pts = FloatString(float: jeuJoueur.points)
                    cell.jeuEtatLabel.text = EtatJoueur(rawValue: jeuJoueur.etat)?.nom
                    cell.jeuPointsLabel.text = pts.string
                }
            }
        }
        return true
    }
    
    func viewExit() {
        print("Contrat : \(self.gestionJoueurs.contrat?.nom ?? "Aucun") sélectionné")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerID = "JeuResultatController"
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! JeuResultatController
        vc.gj = self.gestionJoueurs
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table View Controller -
    
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
            
            let swipeActionsConfiguration = UISwipeActionsConfiguration(actions: [contre, sans, garde, petite])
            swipeActionsConfiguration.performsFirstActionWithFullSwipe = false
            return swipeActionsConfiguration
        }
        

        if tableView == jeuxTableView {
            return UISwipeActionsConfiguration()
        }
        return UISwipeActionsConfiguration()
    }
    
    func choixContrat(contrat: Contrat, cell: JoueurCell) {
        if self.gestionJoueurs.modeJeu == ModeJeu.duo {
            if let _ = self.gestionJoueurs.preneur {
                self.gestionJoueurs.partenaire = self.gestionJoueurs.joueursPartie.first(where: { $0.idJoueur == cell.tag })
                self.viewExit()
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
            self.viewExit()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? JoueurCell else { return nil }
        
        let choixAction = UIContextualAction(style: .normal, title:  "Partenaire", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.gestionJoueurs.partenaire = self.gestionJoueurs.joueursPartie.first(where: { $0.idJoueur == cell.tag })
            self.viewExit()
            
            success(true)
        })
        
        choixAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [choixAction])
    }
    
    
    @IBAction func Tri(_ sender: UIBarButtonItem) {
        //        self.joueurs.sort(by: { (first: Joueur, second: Joueur) -> Bool in
        //            return UIContentSizeCategory(rawValue: String(first.ordre)) > UIContentSizeCategory(rawValue: String(second.ordre))
        //        })
    }
    @IBAction func test(_ sender: Any) {
        donneSuivanteAction(sender)
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
    
    func fetchJeuJoueurs(idJeu: [Int]) -> [JeuJoueur] {
        do {
            let jeuResultat = JeuResultat.jeuResultat(idJeux: idJeu).last
            let setJeuJoueurs = jeuResultat!.joueurs //as? [JeuJoueur]
            jeuJoueurs = setJeuJoueurs!.allObjects as? [JeuJoueur]
            return jeuJoueurs!
        }
    }
    
    func fetchParties() {
        let parties = Partie.all(OrdreAscendant: true)
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
    }
    
    // MARK: - Actions : jeu
    
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
            let controller = UIAlertController(title: "Mise hors-jeu d'un joueur", message: "Quelqu'un nous abandonne ?", preferredStyle: .actionSheet)
            // On supprime dabords les morts s'il y en a
            let Joueurs = gestionJoueurs.nbJoueursMort > 0 ? gestionJoueurs.joueursMort : gestionJoueurs.joueursEnJeu
            for joueur in Joueurs! {
                controller.addAction(UIAlertAction(title: dicoJoueurs[joueur.idJoueur], style: .destructive, handler: { _ in mettreHorsJeuJoueur(joueur: joueur) }))
            }
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(controller, animated: true, completion: nil)
        } else {
            var message = "Dans ce mode, vous n'êtes pas suffisament nombreux pour mettre hors-jeu un joueur supplémentaire !" + "\n"
            message += "\(gestionJoueurs.modeJeu!.nbJoueurs.min.minus()) < " + gestionJoueurs.modeJeu!.nom + " < \(gestionJoueurs.modeJeu!.nbJoueurs.max.plus())"
            let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        /// Mise hors-jeu d'un joueur avec mise à jour des index de chainage et sauvegarde.
        ///
        /// - parameter joueur: Joueur à mettre hors-jeu.
        func mettreHorsJeuJoueur(joueur: Joueur) {
            // Recherche du joueur précédent pour mise à jour des index.
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
            // Sauvegarde des modifications.
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
        // Sauvegarde des modifications
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
    
    // MARK: - Actions : tris
    
    @IBAction func triTableAction(_ sender: Any) {
        if defaultSettings.integer(forKey: triJoueursPartie) == TriJoueurs.table.rawValue {
            // Changement et mémorisation de l'ordre de tri
            let nouvelOrdre = defaultSettings.integer(forKey: tableJoueursPartieOrdre) == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
            defaultSettings.set(nouvelOrdre, forKey: tableJoueursPartieOrdre)
            tableTriBarButton.image = defaultSettings.integer(forKey: tableJoueursPartieOrdre) == How.asc.rawValue ?
                UIImage(named: "icons8-tri-numérique-fin") : UIImage(named: "icons8-tri-numérique-inversé-fin")
        } else {
            // Mémorisation du changement du type de tri
            defaultSettings.set(TriJoueurs.table.rawValue, forKey: triJoueursPartie)
        }
        if let how = How(rawValue: defaultSettings.integer(forKey: tableJoueursPartieOrdre)) {
            gestionJoueurs.tri(choix: .table, how: how)
            joueursTableView.reloadData()
        }
    }
    
    
    @IBAction func triSurnomAction(_ sender: Any) {
        if defaultSettings.integer(forKey: triJoueursPartie) == TriJoueurs.surnom.rawValue {
            // Changement et mémorisation de l'ordre de tri
            let nouvelOrdre = defaultSettings.integer(forKey: surnomJoueursPartieOrdre) == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
            defaultSettings.set(nouvelOrdre, forKey: surnomJoueursPartieOrdre)
            surnomTriBarButton.image = defaultSettings.integer(forKey: surnomJoueursPartieOrdre) == How.asc.rawValue ?
                UIImage(named: "icons8-tri-alphabétique-fin") : UIImage(named: "icons8-tri-alphabétique-inversé-fin")
        } else {
            // Mémorisation du changement du type de tri
            defaultSettings.set(TriJoueurs.surnom.rawValue, forKey: triJoueursPartie)
        }
        if let how = How(rawValue: defaultSettings.integer(forKey: surnomJoueursPartieOrdre)) {
            gestionJoueurs.tri(choix: .surnom, how: how)
            joueursTableView.reloadData()
        }
    }
    
    
    @IBAction func triPointsAction(_ sender: Any) {
        if defaultSettings.integer(forKey: triJoueursPartie) == TriJoueurs.points.rawValue {
            // Changement et mémorisation de l'ordre de tri
            let nouvelOrdre = defaultSettings.integer(forKey: pointsJoueursPartieOrdre) == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
            defaultSettings.set(nouvelOrdre, forKey: pointsJoueursPartieOrdre)
            pointsTriBarButton.image = defaultSettings.integer(forKey: pointsJoueursPartieOrdre) == How.asc.rawValue ?
                UIImage(named: "icons8-tri") : UIImage(named: "icons8-tri-inversé")
        } else {
            // Mémorisation du changement du type de tri
            defaultSettings.set(TriJoueurs.points.rawValue, forKey: triJoueursPartie)
        }
        if let how = How(rawValue: defaultSettings.integer(forKey: pointsJoueursPartieOrdre)) {
            gestionJoueurs.tri(choix: .points, how: how)
            joueursTableView.reloadData()
        }
    }
    
    
    @IBAction func triAction(_ sender: Any) {
        if let tri = TriJoueurs(rawValue: defaultSettings.integer(forKey: triJoueursPartie)) {
            let how: How = defaultSettings.integer(forKey: tri.udHow) == How.asc.rawValue ? How(rawValue: How.desc.rawValue)! : How(rawValue: How.asc.rawValue)!
            defaultSettings.set(how.rawValue, forKey: tri.udHow)
            gestionJoueurs.tri(choix: tri, how: how)
            triBarButton.image = tri.image(how: how)
            joueursTableView.reloadData()
        }
    }
    
    @IBAction func optionsAction(_ sender: Any) {
        let controller = UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Options de tri", style: .default, handler: { _ in self.triOptions() }))
//        controller.addAction(UIAlertAction(title: "Tri par surnoms", style: .default, handler: { _ in  self.triSurnomsChoix() }))
//        controller.addAction(UIAlertAction(title: "Tri par table", style: .default, handler: { _ in self.triPointsChoix() }))
//        controller.addAction(UIAlertAction(title: "", style: .default, handler: { _ in self.triPointsChoix()  }))
        present(controller, animated: true, completion: nil)

    }
    
    func triOptions() {
        let controller = UIAlertController(title: "Options de tri", message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Tri par points", style: .default, handler: { _ in triPointsChoix() }))
        controller.addAction(UIAlertAction(title: "Tri par surnoms", style: .default, handler: { _ in  triSurnomsChoix() }))
        controller.addAction(UIAlertAction(title: "Tri par table", style: .default, handler: { _ in triTableChoix() }))
        present(controller, animated: true, completion: nil)
        
        
        func triTableChoix() {
            triBarButton.image = defaultSettings.integer(forKey: tableJoueursPartieOrdre) == How.asc.rawValue ?
                UIImage(named: "icons8-tri-numérique-fin") : UIImage(named: "icons8-tri-numérique-inversé-fin")
            if defaultSettings.integer(forKey: triJoueursPartie) == TriJoueurs.table.rawValue {
                // Changement et mémorisation de l'ordre de tri
                let nouvelOrdre = defaultSettings.integer(forKey: tableJoueursPartieOrdre) == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
                defaultSettings.set(nouvelOrdre, forKey: tableJoueursPartieOrdre)
            } else {
                // Mémorisation du changement du type de tri
                defaultSettings.set(TriJoueurs.table.rawValue, forKey: triJoueursPartie)
            }
            if let how = How(rawValue: defaultSettings.integer(forKey: tableJoueursPartieOrdre)) {
                gestionJoueurs.tri(choix: .table, how: how)
                joueursTableView.reloadData()
            }
        }
        
        func triSurnomsChoix() {
            triBarButton.image = defaultSettings.integer(forKey: surnomJoueursPartieOrdre) == How.asc.rawValue ?
                UIImage(named: "icons8-tri-alphabétique-fin") : UIImage(named: "icons8-tri-alphabétique-inversé-fin")
            if defaultSettings.integer(forKey: triJoueursPartie) == TriJoueurs.surnom.rawValue {
                // Changement et mémorisation de l'ordre de tri
                let nouvelOrdre = defaultSettings.integer(forKey: surnomJoueursPartieOrdre) == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
                defaultSettings.set(nouvelOrdre, forKey: surnomJoueursPartieOrdre)
            } else {
                // Mémorisation du changement du type de tri
                defaultSettings.set(TriJoueurs.surnom.rawValue, forKey: triJoueursPartie)
            }
            if let how = How(rawValue: defaultSettings.integer(forKey: surnomJoueursPartieOrdre)) {
                gestionJoueurs.tri(choix: .surnom, how: how)
                joueursTableView.reloadData()
            }
        }
        
        func triPointsChoix() {
            triBarButton.image = defaultSettings.integer(forKey: pointsJoueursPartieOrdre) == How.asc.rawValue ?
                UIImage(named: "icons8-tri") : UIImage(named: "icons8-tri-inversé")
            if defaultSettings.integer(forKey: triJoueursPartie) == TriJoueurs.points.rawValue {
                // Changement et mémorisation de l'ordre de tri
                let nouvelOrdre = defaultSettings.integer(forKey: pointsJoueursPartieOrdre) == How.asc.rawValue ? How.desc.rawValue : How.asc.rawValue
                defaultSettings.set(nouvelOrdre, forKey: pointsJoueursPartieOrdre)
            } else {
                // Mémorisation du changement du type de tri
                defaultSettings.set(TriJoueurs.points.rawValue, forKey: triJoueursPartie)
            }
            if let how = How(rawValue: defaultSettings.integer(forKey: pointsJoueursPartieOrdre)) {
                gestionJoueurs.tri(choix: .points, how: how)
                joueursTableView.reloadData()
            }
        }
    }
    
    @IBAction func tapScreen(_ sender: Any) {
//        if let toto = toto {
            timeLeft = 31
//        } else {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
//            timeLeft = 11
//        }
        UIScreen.main.brightness = CGFloat(defaultSettings.float(forKey: brightnessMemApp))
    }
}
