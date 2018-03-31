//
//  Constants.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 1/20/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import Foundation
import UIKit

//tab bar icons names
let DRINK = "Drink"
let SEE = "seeicon"
let EAT = "EatingOut"
let HOTEL = "hotelbed"
let TRANSPORT = "transport"

//var mainTabVC : UITabBarController? 

var MANTBHGHT : CGFloat = 0.0
var TABSVC = [TableVC ]()

//Colors
var TColors :  [UIColor] = [
UIColor(red:0.99, green:0.89, blue:0.65, alpha:1.0),
UIColor(red:1.00, green:0.76, blue:0.61, alpha:1.0),
UIColor(red:0.98, green:0.89, blue:0.99, alpha:1.0),
UIColor(red:0.84, green:0.90, blue:0.90, alpha:1.0),// Yellow
UIColor(red:1.00, green:0.81, blue:0.29, alpha:1.0), // Blue
UIColor(red:0.91, green:0.94, blue:0.95, alpha:1.0) // Semi white

]
struct cellData {
    
    let cell  : Int!
    let text  : String!
    let image : UIImage!
}

var arrayOfCellData = [cellData]()
