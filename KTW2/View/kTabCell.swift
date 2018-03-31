//
//  kTabCell.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 1/20/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import UIKit

class kTabCell: UITableViewCell {

    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myLbl: UILabel!
    
    @IBOutlet weak var myTxtView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupParallax()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupParallax() {
        print("We are int setupParallax!!!")
        let min = CGFloat(-100)
        let max = CGFloat(100)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        
        myImageView.addMotionEffect(motionEffectGroup)
        
        print(xMotion, yMotion)
    }

}
