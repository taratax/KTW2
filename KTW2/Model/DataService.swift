//
//  DataService.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 3/25/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import Foundation
class DataService {

static let instance = DataService()
    
let APIKEY = "be5d2ad3013962831c7cf6ad25941737"
let NUMBERPHOTOS = 15

//https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=64147ab7d6588a0822243b78336b26b9&lat=50.2649&lon=19.0238&radius=1&radius_units=mi&per_page=40&format=json&nojsoncallback=1

func flickrUrl(forApiKey key: String, withAnnotation annotation: droppablePin, andNumberOfPhotos number: Int ) -> String  {
    
    let url =  "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIKEY)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=0.5&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1"
    print(url)
    return url
}


var seeTabPic  = ["park_kosciuszko_002_small","katowice_kathedralwe_outside_001",
                  "spodek_outside_002"]
var seeTitle = ["Park","Cathedral","Saucer"]

var hotelTabPic = ["hotel_diament_out_001","Hotel-senator_001","Novotel_out_001"]
var hotelTitle = ["Diament","Senator","Novotel"]

var eatTabPic = ["Lenarte_outsie_001","hurry_curry_outside_001","Golden-Donkey_out_001"]
var eatTitle = ["Lenarte","Hurry Curry","Golden Donkey"]

var drinkTabPic = ["upojeni_out_001","rajzefiber_inside_002","maly_kredens_in_001"]
var drinkTitle = ["Upojeni","Rajzefiber","Kredens"]
var drinkAdresses = ["Świętego Jana 10, 40-001 Katowice","3 Maja 23, Katowice, Poland","9, świętego Jacka, Katowice, Poland"]

var transTabPic = ["Transport_001","taxi_001","Pkp_001"]
var transTitle = ["Buses","Taxi","Railway"]
}
