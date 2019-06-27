//
//  PointsJeuxController.swift
//  Tarot
//
//  Created by Serge Gori on 26/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class PointsJeuxController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var cellId = "PointsJeuCell"
    
    var pointsJeux = [PointsJeu]()
    
override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPointsJeux()
    }

   
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 320
            }
    
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointsJeux.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let joueurDeLaCell = pointsJeux[indexPath.row]
//        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PointsJeuCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PointsJeuCell {
            cell.miseEnPlace(pointsJeu: joueurDeLaCell)
            return cell
        }
        return UITableViewCell()
    }
    

    func fetchPointsJeux() {
        let requete: NSFetchRequest<PointsJeu> = PointsJeu.fetchRequest()
//        let tri = NSSortDescriptor(key: "nom", ascending: true)
//        requete.sortDescriptors = [tri]
        do {
            pointsJeux = PointsJeu.all
//            pointsJeux = try contexte.fetch(requete)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

}
