//
//  PopVC.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 2/18/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var popImgView: UIImageView!
    
    var passedImage: UIImage!
    
    
    func initData(forImage image: UIImage) {
        self.passedImage = image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImgView.image = passedImage
        addDoubleTap()

        // Do any additional setup after loading the view.
    }

   
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
         doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    
   @objc func screenWasDoubleTapped() {
        dismiss(animated: true, completion: nil)
    }

}
