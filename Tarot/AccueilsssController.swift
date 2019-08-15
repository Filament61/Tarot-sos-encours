//
//  ViewController.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit
//import SwipeCellKit


class AccueilsssController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        triJoueursDefaut = defaultSettings.integer(forKey: "triJoueursDefaut")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup before display the view.
        
   }
    

    
//    var jou = joueursTab.count
    
    //@IBAction func pushTest(_ sender: UIButton) {
    //    let vc = UIStoryboard.init(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "ScoreJeuController") as UIViewController
    //self.navigationController?.popToViewController(vc, animated: false) //navigationController?.pushViewController(ScoreJeuController, animated: true)
        
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DernierePartieSegue" {
            let PartieController = segue.destination as! PartieController
            PartieController.isNouvelle = false
        }
//        if segue.identifier == "Segue" {
//            //            let qui = self.preneur.idx
//            let JeuResultatController = segue.destination as! JeuResultatController
//            //            JeuResultatController.preneur = preneur.ordre - 1
//            JeuResultatController.cellTab = cellTab
//        }
    }

}

