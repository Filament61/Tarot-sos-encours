//
//  Personnes.swift
//  Tarot
//
//  Created by Serge Gori on 18/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
import CoreData

class PersonnesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellId = "PersonneCell"
    
    var entreprises = [joueursTab]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchEntreprises()
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return joueursTab.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joueursTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? UITableViewCell
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
}
