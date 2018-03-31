//
//  droppablePin.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 2/18/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class droppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
     init(coordinate: CLLocationCoordinate2D, identifier: String) {
        
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}
