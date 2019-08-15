//
//  ParametresController.swift
//  Tarot
//
//  Created by Serge Gori on 13/08/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class cellTriJoueurs: UITableViewCell {
    
}

class ParametresController:  UITableViewController {
    @IBOutlet weak var donne: cellTriJoueurs!
    @IBOutlet weak var surnom: cellTriJoueurs!
    @IBOutlet weak var points: cellTriJoueurs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            let accessoryType = triJoueursDefaut != indexPath.row ? UITableViewCell.AccessoryType.none : UITableViewCell.AccessoryType.checkmark
            switch indexPath.row {
            case 0:
                cell = donne
            case 1:
                cell = surnom
            case 2:
                cell = points
            default:
                break
            }
            cell.accessoryType = accessoryType
            
        case 1:
            break
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            triJoueursDefaut = indexPath.row
            defaultSettings.set(triJoueursDefaut, forKey: "triJoueursDefaut")
            for row in 0..<3 {
                let indexPath = IndexPath(row: row, section: indexPath.section)
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
    }
    
    
    
}
