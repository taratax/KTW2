//
//  mapVC.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 2/5/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import AlamofireImage


class mapVC: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var pullUpViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pullUpView: UIView!
   
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    @IBOutlet weak var locBtn: UIButton!
    
    
    @IBOutlet weak var pullUpConstr: NSLayoutConstraint!
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 200
    
    var spinner: UIActivityIndicatorView?
    var progressLbl: UILabel?
    var flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    
    var imageUrlArray = [String]()
    var imageArray = [UIImage]()
    
    var address = ""
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // enables us to use mapview in this VC
        mapViewOutlet.delegate = self
        locationManager.delegate = self
       
        
        configureLocationServices()
        addDoubleTap()
//        registerForPreviewing(with: self, sourceView: collectionView!)
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.bounces = false
        collectionView?.alwaysBounceVertical = true
        collectionView?.alwaysBounceHorizontal = true
        collectionView?.isScrollEnabled = true
       
        
        sNvBtn()
        pullUpView.addSubview(collectionView!)
        
    }
    
    func addDoubleTap() {
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapViewOutlet.addGestureRecognizer(doubleTap)
    }
    
    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
        
    }
    
    func animateViewUp() {
        
        if pullUpViewHeightConstraint.constant == 300 { return }
        rstNvbtn()
        pullUpViewHeightConstraint.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
          
        }
    }
    
    @objc func animateViewDown() {
        self.callCancelAllSessions()
        sNvBtn()
        pullUpViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addSpinner() {
       spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (pullUpView.frame.size.width / 2 - ((spinner?.frame.size.width)! / 2) ), y: pullUpView.frame.size.height / 2 )
        spinner?.activityIndicatorViewStyle = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        spinner?.startAnimating()
        
        collectionView?.addSubview(spinner!)
    }
    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }
    
    func removeProgressLbl () {
        if progressLbl != nil {
            progressLbl?.removeFromSuperview()
        }
    }

    func addProgressLbl() {
        
        progressLbl = UILabel()
        progressLbl?.frame = CGRect(x: (pullUpView.frame.size.width / 2) - 120, y: 175, width: 240, height: 40 )
        progressLbl?.font = UIFont(name: "Avenir Next", size: 15)
        progressLbl?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        progressLbl?.textAlignment = .center

        
        collectionView?.addSubview(progressLbl!)
    }
   
    func rstNvbtn () {
         pullUpConstr.constant = pullUpConstr.constant - MANTBHGHT
    }
    
    func sNvBtn () {
        pullUpConstr.constant = pullUpConstr.constant + MANTBHGHT
    }
    
    
    @IBAction func centerMapButtonWasPressed(_ sender: Any) {
        
       
        
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
            
        }
    }
    
    
}

extension mapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
   
    func centerMapOnUserLocation() {
//        guard let coordinate = locationManager.location?.coordinate else { return }
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2, regionRadius * 2 )
//        mapViewOutlet.setRegion(coordinateRegion, animated: true)
        getCoordinate()
    }
    
    func getCoordinate()  {
        print("In getCoordinate() in MapVC: \(address)")

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let coordinate = placemarks.first?.location?.coordinate
            
                else {
                    // handle no location found
                    return
            }
            print("location : \(coordinate)")
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, self.regionRadius * 2, self.regionRadius * 2 )
            self.mapViewOutlet.setRegion(coordinateRegion, animated: true)
            self.removePin()
            self.mapViewOutlet.addAnnotation(droppablePin(coordinate: coordinate, identifier: "droppablePin"))
            
            
            // Use your location
        }
//      return location
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        removePin()
        removeSpinner()
        removeProgressLbl()
        callCancelAllSessions()
        
        imageArray.removeAll()
        imageUrlArray.removeAll()
        
        collectionView?.reloadData()
        
        animateViewUp()
        addSwipe()
        addSpinner()
        addProgressLbl()
        
        
        //drop pin on the map
      let touchPoint = sender.location(in: mapViewOutlet)
        
        let touchCoordinate = mapViewOutlet.convert(touchPoint, toCoordinateFrom: mapViewOutlet)
       
        let annotation = droppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapViewOutlet.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadius * 2, regionRadius * 2 )
        mapViewOutlet.setRegion(coordinateRegion, animated: true)
        
//        flickrUrl(forApiKey: APIKEY, withAnnotation: annotation, andNumberOfPhotos: 40)
        
        retrieveUrls(forAnnotation: annotation) { (finished) in
            if finished {
                
                print("HA HA : \(self.imageUrlArray.count)")
                self.retrieveImages(handler: { (finished) in
                    if finished {
                        
                        self.removeSpinner()
                        
                        self.removeProgressLbl()
                        
                        self.collectionView?.reloadData()
                
                    }
                })
            }
        }
    }
    
    func removePin() {
        for annotation in mapViewOutlet.annotations {
            mapViewOutlet.removeAnnotation(annotation)
        }
    }
 
    func retrieveUrls(forAnnotation annotation: droppablePin, handler: @escaping (_ status: Bool) -> () ) {
//         imageUrlArray = []
        Alamofire.request(DataService.instance.flickrUrl(forApiKey: DataService.instance.APIKEY, withAnnotation: annotation, andNumberOfPhotos: DataService.instance.NUMBERPHOTOS)).responseJSON { (response) in
            
            guard let json = response.result.value as? Dictionary<String,AnyObject> else { return }
            let photosDict = json["photos"] as! Dictionary<String,AnyObject>
            let photosDictArray = photosDict["photo"] as! [Dictionary<String,AnyObject>]
            
            for photo in photosDictArray {

                let postUrl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_h_d.jpg"
                self.imageUrlArray.append(postUrl)
            }
            handler(true)
            
            
        }
        
    }
    
}

extension mapVC: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
    
    func retrieveImages(handler: @escaping (_ status:  Bool) -> ()) {
//         imageArray = []
        for url in imageUrlArray {
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else { return }
                self.imageArray.append(image)
                self.progressLbl?.text = "\(self.imageArray.count)/\(DataService.instance.NUMBERPHOTOS) IMAGES DOWNLOADED"
                
                if self.imageArray.count == self.imageUrlArray.count {
                    handler(true)
                }
                
            })
        }
    }
    
    func callCancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ $0.cancel() })
            downloadData.forEach( { $0.cancel() } )
            
        }
    }
    
}

extension mapVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        let imageView = UIImageView(image: imageArray[indexPath.row])
       
        cell.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.sizeToFit()
        
//        cell.viewWithTag(1)?.removeFromSuperview()
//        let labl = UILabel(frame: cell.bounds)
//        labl.text = "\(indexPath.row)"
//        labl.tag = 1
//        cell.addSubview(labl)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 5
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return imageArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return }
        popVC.initData(forImage: imageArray[indexPath.row])
        present(popVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
    let image = imageArray[indexPath.row]
        print("HI Im being called HERE!!")
    return image.size
    }
    
    

    
    
}
extension mapVC: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location), let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else { return nil }
        popVC.initData(forImage: imageArray[indexPath.row])
        previewingContext.sourceRect = cell.contentView.frame
        return popVC
        
        
        
     }
}
