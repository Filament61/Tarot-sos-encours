//
//  AjoutPersonneControler.swift
//  Tarot
//
//  Created by Serge Gori on 19/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class AjoutPersonneController: UIViewController {
    
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
    
    let idJoueur = NSManagedObject.nextAvailble("idJoueur", forEntityName: "Personne")
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
    
    
    
    
    @IBAction func ajouterPersonneAction(_ sender: UIButton) {
        view.endEditing(true)
        
        
        guard surnomTextField.hasText else { return }
        
        let nouvellePersonne = Personne(context: viewContext)
        
        if prenomTextField.text != nil {
            nouvellePersonne.prenom = prenomTextField.text!
        }
        if nomTextField.text != nil {
            nouvellePersonne.nom = nomTextField.text!
        }
        if surnomTextField.text != nil {
            nouvellePersonne.surnom = surnomTextField.text!
        }
        nouvellePersonne.photo = imageDeProfil.image
        
        nouvellePersonne.idJoueur = Int16(idJoueur)
        nouvellePersonne.horodate = now
        
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}
