//
//  ParametresController.swift
//  Tarot
//
//  Created by Serge Gori on 13/08/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class TriJoueursCell: UITableViewCell {
}

class AffJoueursCell: UITableViewCell {
    @IBAction func donneAffJoueursSwitch(_ sender: Any) {
        defaultSettings.set((sender as AnyObject).isOn, forKey: donneAffJoueurs)
    }
    @IBAction func pointsAffJoueursSwitch(_ sender: Any) {
        defaultSettings.set((sender as AnyObject).isOn, forKey: pointsAffJoueurs)
    }
    @IBAction func jeuDernierAffJoueursSwitch(_ sender: Any) {
        defaultSettings.set((sender as AnyObject).isOn, forKey: jeuDernierAffJoueurs)
}
    @IBAction func jeuxAffJoueursSwitch(_ sender: Any) {
        defaultSettings.set((sender as AnyObject).isOn, forKey: jeuxAffJoueurs)
    }
}

class ParametresController:  UITableViewController {
    @IBOutlet weak var donneAffJoueursSwitch: UISwitch!
    @IBOutlet weak var pointsAffJoueursSwitch: UISwitch!
    @IBOutlet weak var jeuDernierAffJoueursSwitch: UISwitch!
    @IBOutlet weak var jeuxAffJoueursSwitch: UISwitch!
    
    @IBOutlet weak var donne: TriJoueursCell!
    @IBOutlet weak var surnom: TriJoueursCell!
    @IBOutlet weak var points: TriJoueursCell!
    
    @IBOutlet weak var donneAffJoueursCell: AffJoueursCell!
    @IBOutlet weak var pointsAffJoueursCell: AffJoueursCell!
    @IBOutlet weak var jeuDernierAffJoueursCell: AffJoueursCell!
    @IBOutlet weak var jeuxAffJoueursCell: AffJoueursCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            let accessoryType = defaultSettings.integer(forKey: triJoueursDefaut) != indexPath.row ? UITableViewCell.AccessoryType.none : UITableViewCell.AccessoryType.checkmark
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
            switch indexPath.row {
            case 0:
                cell = donneAffJoueursCell
                donneAffJoueursSwitch.isOn = defaultSettings.bool(forKey: donneAffJoueurs)
            case 1:
                cell = pointsAffJoueursCell
                pointsAffJoueursSwitch.isOn = defaultSettings.bool(forKey: pointsAffJoueurs)
            case 2:
                cell = jeuDernierAffJoueursCell
                jeuDernierAffJoueursSwitch.isOn = defaultSettings.bool(forKey: jeuDernierAffJoueurs)
            case 3:
                cell = jeuxAffJoueursCell
                jeuxAffJoueursSwitch.isOn = defaultSettings.bool(forKey: jeuxAffJoueurs)
            default: break
            }
        default: break
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 1: return 4
        default: return Int()
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            defaultSettings.set(indexPath.row, forKey: triJoueursDefaut)
            for row in 0..<3 {
                let indexPath = IndexPath(row: row, section: indexPath.section)
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark

//        case 1:
//            switch indexPath.row {
//            case 0:
//                defaultSettings.set(defaultSettings.bool(forKey: "donneAffJoueurs"), forKey: "donneAffJoueurs")
//            case 1:
//                defaultSettings.set(defaultSettings.bool(forKey: "pointsAffJoueurs"), forKey: "pointsAffJoueurs")
//            case 2:
//                defaultSettings.set(defaultSettings.bool(forKey: "jeuDernierAffJoueurs"), forKey: "jeuDernierAffJoueurs")
//            case 3:
//                defaultSettings.set(defaultSettings.bool(forKey: "jeuxAffJoueurs"), forKey: "jeuxAffJoueurs")
//            default: break
//            }
        default: break

        }

    }
    
    
    
}
