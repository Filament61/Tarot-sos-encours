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
    
    var jeuResultats = [JeuResultat]()
    
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
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jeuResultats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let laCell = jeuResultats[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PointsJeuCell {
            cell.miseEnPlace(jR: laCell)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func fetchPointsJeux() {
            jeuResultats = JeuResultat.all
            tableView.reloadData()
    }
    
}
