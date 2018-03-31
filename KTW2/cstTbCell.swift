//
//  cstTbCell.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 1/20/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import UIKit
@IBDesignable

class cstTbCell: UITableViewCell {

    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var maintxtField: UITextField!
    
    @IBOutlet weak var mainLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setupParallax()
    }
    
    func setupParallax() {
        print("We are int setupParallax!!!")
        let min = CGFloat(-10)
        let max = CGFloat(10)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        
        mainImgView.addMotionEffect(motionEffectGroup)
        
        print(xMotion, yMotion)
    }

    func confCell(tab _tab: Int ,row: Int ) {
        if (_tab == 0 ) {
            mainImgView.image
                = UIImage(named: DataService.instance.seeTabPic[row] )
            mainLbl.text = DataService.instance.seeTitle[row]
        } else if ( _tab == 1 ) {
            mainImgView.image
                = UIImage(named: DataService.instance.hotelTabPic[row] )
            mainLbl.text = DataService.instance.hotelTitle[row]
        } else if (_tab == 2  ) {
            mainImgView.image
                = UIImage(named: DataService.instance.eatTabPic[row] )
            mainLbl.text = DataService.instance.eatTitle[row]
            
        } else if (_tab == 3 ) {
            mainImgView.image
                = UIImage(named: DataService.instance.drinkTabPic[row] )
            mainLbl.text = DataService.instance.drinkTitle[row]
            
        } else if ( _tab == 4 ) {
            mainImgView.image
                = UIImage(named: DataService.instance.transTabPic[row] )
            mainLbl.text = DataService.instance.transTitle[row]
            
        }
        mainLbl.backgroundColor = TColors[0]
        mainLbl.textColor = TColors[5]
        maintxtField.backgroundColor = TColors[0]
        self.backgroundColor = TColors[0]
        
//        mainImgView.layer.cornerRadius = 0.5
    }
    
}
