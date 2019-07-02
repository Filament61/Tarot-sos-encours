//
//  AjoutPersonneControler.swift
//  Tarot
//
//  Created by Serge Gori on 19/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class AjoutJoueurController: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var contrainteDuBas: NSLayoutConstraint!

    @IBOutlet weak var ajouterPersonneBouton: UIButton!
    
    @IBOutlet weak var idJoueurLabel: UILabel!
    @IBOutlet weak var horodateLabel: UILabel!
    
    @IBOutlet weak var surnomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var imageDeProfil: ImageArrondie!
    
    var imagePicker: UIImagePickerController?
    
    let idJoueur = NSManagedObject.nextAvailble("idJoueur", forEntityName: "Joueur", inContext: AppDelegate.viewContext)
    let now = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        miseEnPlaceImagePicker()
        miseEnPlaceLabel()
        miseEnPlaceTextField()
        miseEnPlaceNotification()
//        fetchEntreprises()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        largeurContrainte.constant = view.frame.width
//        scroll.contentSize = CGSize(width: largeurContrainte.constant, height: scroll.frame.height)
    }
    
    
    
    
    @IBAction func ajouterJoueurAction(_ sender: UIButton) {
        view.endEditing(true)
        let nouveauJoueur = Joueur(context: contexte)
        if prenomTextField.text != nil {
            nouveauJoueur.prenom = prenomTextField.text!
        }
        if nomTextField.text != nil {
            nouveauJoueur.nom = nomTextField.text!
        }
        if surnomTextField.text != nil {
            nouveauJoueur.surnom = surnomTextField.text!
        }
        nouveauJoueur.photo = imageDeProfil.image
        
        nouveauJoueur.idJoueur = Int16(idJoueur)
        nouveauJoueur.horodate = now
        
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}
