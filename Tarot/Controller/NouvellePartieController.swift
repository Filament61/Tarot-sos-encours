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
    
    @IBOutlet weak var nouvellePartieButtonBar: UIBarButtonItem!
    @IBOutlet weak var modeJeuSegment: UISegmentedControl!
    @IBOutlet weak var nbMortsSegment: UISegmentedControl!
    

    @IBOutlet weak var idPartieLabel: UILabel!
    @IBOutlet weak var horodateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listeJoueurs: UILabel!
    @IBOutlet weak var nbJoueursImage: UIImageView!
    
    var cellId = "PersonneCell"
    
    var personnes = [Personne]()
    var cellTab = [PersonneCell]()
    var cells =  [PersonneCell]()

//    var modeJeu: ModeJeu?
    var donneur: Int = 0
    var morts: [Int] = []
    
//    var partie: Partie?
    var nbJoueurs: Int = 0 //{
//        didSet {
//            // Animation des choix de mode de jeu et du nombre de mort
//            animerOptions()
//            // Animation des cellules indiquant le donneur et le ou les mort(s)
//            animerCell()
//            // Animation de l'autorisation de départ de la partie
//            self.nouvellePartieButtonBar.isEnabled = GestionJoueurs.isCorrectNbJoueurs(nbJoueurs: self.nbJoueurs)
//        }
//    }
    
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
        animerOptions()
        dicoJoueursMaJ()
        fetchJoueurs()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personnes.count
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70 // ATTENTION SI LA LISTE EST TROP LONGUE --> MAUVAISE GESTION DES INDEX
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let joueurDeLaCell = personnes[indexPath.row]
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
        let tri = NSSortDescriptor(key: "idJoueur", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            personnes = try viewContext.fetch(requete)
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
                cell.donneurLabel.text = ""
                cell.etatLabel.text = ""
                print("Index existant : \(pointeur)")
                // Mise à jour des cellules déjà sélectionnées
                var item = pointeur
                while item < self.cellTab.count {
                    self.cellTab[item].idx = item.plus()
                    self.cellTab[item].suivant = item != self.cellTab.count.minus() ? item.plus() : 1
                    item += 1
                    print("Réindexation : \(item)")
                }
                // Nouvelle cellule sélectionnée
            } else {
                if let dernier = self.cellTab.last {
                dernier.suivant = self.cellTab.count + 1
                }
                self.cellTab.append(cell)
                cell.idx = self.cellTab.count
                cell.suivant = 1
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
            self.nbJoueurs = self.cellTab.count
            // Mise à jour de l'image du nombre de joueurs
            self.nbJoueursImage.image = UIImage(named: "icons8-cerclé-" + String(self.cellTab.count) + "-1")
            
            // Animation de l'autorisation de départ de la partie
            self.nouvellePartieButtonBar.isEnabled = GestionJoueurs.isCorrectNbJoueurs(nbJoueurs: self.nbJoueurs)
            // Animation des choix de mode de jeu et du nombre de mort
            self.animerOptions()
            // Animation des cellules indiquant le donneur et le ou les mort(s)
            self.animerCell()

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
        self.personnes.sort(by: { (first: Personne, second: Personne) -> Bool in
            return UIContentSizeCategory(rawValue: first.surnom!) > UIContentSizeCategory(rawValue: second.surnom!)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "PartieSegue" {
            //            let qui = self.preneur.idx
            let PartieController = segue.destination as! PartieController
            //            PartieController.preneur = preneur.idx - 1
            PartieController.isNouvelle = true
        }
    }
    
    func miseEnPlace() {
        // Intitialisation de la nouvelle partie avec la donnée par défaut
        defaultSettings.set(defaultSettings.integer(forKey: triJoueursDefaut), forKey: triJoueursPartie)

        let format = DateFormatter()
        format.dateFormat = "dd/MM/YYYY HH:mm"
        horodateLabel.text = format.string(from: now)
        
        idPartieLabel.text = String(idPartie)
        
        nbJoueursImage.image = UIImage(named: "icons8-cerclé-0-1")
    }
    
    @IBAction func choixModeAction(_ sender: Any) {
        // Animation du segment de choix du nombre de morts
        guard let modeJeu = ModeJeu(rawValue: modeJeuSegment.selectedSegmentIndex) else { return }
        nbMortsSegment.selectedSegmentIndex = modeJeu.nbMorts[nbJoueurs] ?? UISegmentedControl.noSegment
        animerCell()
    }
    
    @IBAction func choixNbMortsAction(_ sender: Any) {
        // Animation du segment de choix du mode de jeu
        let nb = ModeJeu.modeChoix(nbMorts: nbMortsSegment.selectedSegmentIndex)
        modeJeuSegment.selectedSegmentIndex = nb[nbJoueurs].map { $0.rawValue } ?? UISegmentedControl.noSegment
        animerCell()
    }
    
    func animerCell() {
        morts.removeAll()
        for joueur in self.cellTab {
            if GestionJoueurs.isCorrectNbJoueurs(nbJoueurs: nbJoueurs) && joueur.idx == nbJoueurs {
                joueur.donneurLabel.text = "Donneur"
                donneur = joueur.idx
            } else {
                joueur.donneurLabel.text = String()
            }
            
            joueur.etatLabel.text = String()
            if nbMortsSegment.selectedSegmentIndex != 0 {
                if nbMortsSegment.selectedSegmentIndex == 1 && joueur.idx == nbJoueurs {
                    joueur.etatLabel.text = "Mort"
                }
                if nbMortsSegment.selectedSegmentIndex == 2 && joueur.idx == nbJoueurs {
                    joueur.etatLabel.text = "Mort (-1)"
                }
                if nbMortsSegment.selectedSegmentIndex == 2 && joueur.idx == nbJoueurs.minus() {
                    joueur.etatLabel.text = "Mort (-2)"
                }
                morts.append(joueur.idx)
            }
        }
    }
    
    
    func animerOptions() {
        
        switch nbJoueurs {
        case Int.min..<GestionJoueurs.nbMiniJoueurs:
//            modeJeuSegment.isEnabled = false
//            modeJeuSegment.selectedSegmentIndex = UISegmentedControl.noSegment
            
            nbMortsSegment.isEnabled = false
            nbMortsSegment.selectedSegmentIndex = UISegmentedControl.noSegment

        case GestionJoueurs.nbMiniJoueurs:
//            modeJeuSegment.isEnabled = true
//            modeJeuSegment.selectedSegmentIndex = ModeJeu.simple.rawValue
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.simple.rawValue)
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.duo.rawValue)
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.equipe.rawValue)
            
            nbMortsSegment.isEnabled = true
            nbMortsSegment.selectedSegmentIndex = 0
            nbMortsSegment.setEnabled(true, forSegmentAt: 0)
            nbMortsSegment.setEnabled(false, forSegmentAt: 1)
            nbMortsSegment.setEnabled(false, forSegmentAt: 2)

        case 4:
//            modeJeuSegment.isEnabled = true
//            modeJeuSegment.selectedSegmentIndex = ModeJeu.simple.rawValue
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.simple.rawValue)
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.duo.rawValue)
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.equipe.rawValue)

            nbMortsSegment.isEnabled = true
            nbMortsSegment.selectedSegmentIndex = 0
            nbMortsSegment.setEnabled(true, forSegmentAt: 0)
            nbMortsSegment.setEnabled(true, forSegmentAt: 1)
            nbMortsSegment.setEnabled(false, forSegmentAt: 2)

        case 5:
//            modeJeuSegment.isEnabled = true
//            modeJeuSegment.selectedSegmentIndex = ModeJeu.duo.rawValue
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.simple.rawValue)
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.duo.rawValue)
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.equipe.rawValue)
            
            nbMortsSegment.isEnabled = true
            nbMortsSegment.selectedSegmentIndex = 0
            nbMortsSegment.setEnabled(true, forSegmentAt: 0)
            nbMortsSegment.setEnabled(true, forSegmentAt: 1)
            nbMortsSegment.setEnabled(true, forSegmentAt: 2)

        case 6:
//            modeJeuSegment.isEnabled = true
//            modeJeuSegment.selectedSegmentIndex = ModeJeu.duo.rawValue
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.simple.rawValue)
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.duo.rawValue)
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.equipe.rawValue)
            
            nbMortsSegment.isEnabled = true
            nbMortsSegment.selectedSegmentIndex = 1
            nbMortsSegment.setEnabled(true, forSegmentAt: 0)
            nbMortsSegment.setEnabled(true, forSegmentAt: 1)
            nbMortsSegment.setEnabled(true, forSegmentAt: 2)

        case 7:
//            modeJeuSegment.isEnabled = true
//            modeJeuSegment.selectedSegmentIndex = ModeJeu.duo.rawValue
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.simple.rawValue)
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.duo.rawValue)
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.equipe.rawValue)
            
            nbMortsSegment.isEnabled = true
            nbMortsSegment.selectedSegmentIndex = 2
            nbMortsSegment.setEnabled(false, forSegmentAt: 0)
            nbMortsSegment.setEnabled(true, forSegmentAt: 1)
            nbMortsSegment.setEnabled(true, forSegmentAt: 2)

        case GestionJoueurs.nbMaxiJoueurs:
//            modeJeuSegment.isEnabled = true
//            modeJeuSegment.selectedSegmentIndex = ModeJeu.equipe.rawValue
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.simple.rawValue)
//            modeJeuSegment.setEnabled(false, forSegmentAt: ModeJeu.duo.rawValue)
//            modeJeuSegment.setEnabled(true, forSegmentAt: ModeJeu.equipe.rawValue)
            
            nbMortsSegment.isEnabled = true
            nbMortsSegment.selectedSegmentIndex = 2
            nbMortsSegment.setEnabled(false, forSegmentAt: 0)
            nbMortsSegment.setEnabled(false, forSegmentAt: 1)
            nbMortsSegment.setEnabled(true, forSegmentAt: 2)

        case GestionJoueurs.nbMaxiJoueurs...Int.max:
//            modeJeuSegment.isEnabled = false
//            modeJeuSegment.selectedSegmentIndex = UISegmentedControl.noSegment
            
            nbMortsSegment.isEnabled = false
            nbMortsSegment.selectedSegmentIndex = UISegmentedControl.noSegment
            
        default: break
            
        }
 
        /// Correspond à l'index maximal sélectionnable sur le segment du mode de jeu.
        var modeJeuSelectedSegmentIndex: Int? {
            var mode = 0
            repeat {
                let intervale = ModeJeu[mode].nbdefaut
                if isInInterval(nbJoueurs, from: intervale.min, to: intervale.max) {
                    return mode
                }
                mode += 1
            } while mode < 2
            return nil
        }
        
        modeJeuSegment.isEnabled = GestionJoueurs.isCorrectNbJoueurs(nbJoueurs: nbJoueurs)
        modeJeuSegment.selectedSegmentIndex = GestionJoueurs.isCorrectNbJoueurs(nbJoueurs: nbJoueurs) ?
                                              modeJeuSelectedSegmentIndex! : UISegmentedControl.noSegment
        modeJeuSegment.setEnabled(isInInterval(nbJoueurs, from: ModeJeu.simple.nbJoueurs.min, to: ModeJeu.simple.nbJoueurs.max),
                                  forSegmentAt: ModeJeu.simple.rawValue)
        modeJeuSegment.setEnabled(isInInterval(nbJoueurs, from: ModeJeu.duo.nbJoueurs.min, to: ModeJeu.duo.nbJoueurs.max),
                                  forSegmentAt: ModeJeu.duo.rawValue)
        modeJeuSegment.setEnabled(isInInterval(nbJoueurs, from: ModeJeu.equipe.nbJoueurs.min, to: ModeJeu.equipe.nbJoueurs.max),
                                  forSegmentAt: ModeJeu.equipe.rawValue)

//    nbMortsSegment.isEnabled = false
//    nbMortsSegment.selectedSegmentIndex = UISegmentedControl.noSegment

    }
    

    
    
    @IBAction func nouvellePartieActionButtonBar(_ sender: UIBarButtonItem) {
        
        guard self.modeJeuSegment.selectedSegmentIndex != UISegmentedControl.noSegment,
            let modeJeu = ModeJeu(rawValue: modeJeuSegment.selectedSegmentIndex)
            else { return }

        let _ = AppDelegate.partie.insert(Participants: cellTab, idPartie: idPartie, hD: now, idxDonneur: donneur, idxMort: morts, modeJeu: modeJeu)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerID = "PartieViewController"
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! PartieController
//        vc.isNouvelle = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


