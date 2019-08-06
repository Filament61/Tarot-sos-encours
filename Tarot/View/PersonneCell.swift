//
//  PersonneCell.swift
//  Tarot
//
//  Created by Serge Gori on 13/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import UIKit

class PersonneCell: UITableViewCell {
    
    @IBOutlet weak var idxLabel: UILabel!
    @IBOutlet weak var idxImage: ImageArrondie!
    @IBOutlet weak var idJoueurLabel: UILabel!
    @IBOutlet weak var photoDeProfil: ImageArrondie!
    @IBOutlet weak var surnom: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    
    @IBOutlet weak var donneurLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var personne: Personne!
    
    var idx: Int = -1 {
        didSet {
            idxLabel.text = String(self.idx)
            idxImage.image = UIImage(named: "icons8-cerclé-" + String(self.idx) + "-2")
        }
    }
    
    func affecteIdxImage(idx: Int)  {
        switch (idx) {
        case 0:
            idxImage.image = UIImage(named: "")
            
        case 1...8:
            idxImage.image = UIImage(named: "icons8-cerclé-" + String(idx) + "-1")
            
        default:
            break;
        }
        return
    }
    
    func miseEnPlace(personne: Personne) {
        
        self.personne = personne
        
        idJoueurLabel.text = String(self.personne.idJoueur)
        photoDeProfil.image = self.personne.photo as? UIImage
        
        donneurLabel.text = String()
        etatLabel.text = String()

        if let leSurnom = self.personne.surnom {
            surnom.text = leSurnom
        }
        if let leNom = self.personne.nom {
            nom.text = leNom
        }
        if let lePrenom = self.personne.prenom {
            prenomLabel.text = lePrenom
        }
    }
    
    
    //    var animator: Any?
    //
    //    var indicatorView = IndicatorView(frame: .zero)
    //
    //    var unread = false {
    //        didSet {
    //            indicatorView.transform = unread ? CGAffineTransform.identity : CGAffineTransform.init(scaleX: 0.001, y: 0.001)
    //        }
    //    }
    //
    //    override func awakeFromNib() {
    //        setupIndicatorView()
    //    }
    //
    //    func setupIndicatorView() {
    //        indicatorView.translatesAutoresizingMaskIntoConstraints = false
    //        indicatorView.color = tintColor
    //        indicatorView.backgroundColor = .clear
    //        contentView.addSubview(indicatorView)
    //
    //        let size: CGFloat = 12
    //        indicatorView.widthAnchor.constraint(equalToConstant: size).isActive = true
    //        indicatorView.heightAnchor.constraint(equalTo: indicatorView.widthAnchor).isActive = true
    ////        indicatorView.centerXAnchor.constraint(equalTo: fromLabel.leftAnchor, constant: -16).isActive = true
    ////        indicatorView.centerYAnchor.constraint(equalTo: fromLabel.centerYAnchor).isActive = true
    //    }
    //
    //    func    setUnread(_ unread: Bool, animated: Bool) {
    //        let closure = {
    //            self.unread = unread
    //        }
    //
    //        if #available(iOS 10, *), animated {
    //            var localAnimator = self.animator as? UIViewPropertyAnimator
    //            localAnimator?.stopAnimation(true)
    //
    //            localAnimator = unread ? UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.4) : UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1.0)
    //            localAnimator?.addAnimations(closure)
    //            localAnimator?.startAnimation()
    //
    //            self.animator = localAnimator
    //        } else {
    //            closure()
    //        }
    //    }
    
}
