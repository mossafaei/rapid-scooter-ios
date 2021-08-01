//
//  MainViewController.swift
//  Rapid
//
//  Created by Apple on 10/29/19.
//  Copyright © 2019 ___MostafaSafaeipour___. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
class MainViewController: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var SavarShoButton: UIButton!
    @IBOutlet weak var IssueButton: UIButton!
    @IBOutlet weak var SetMyLocationButton: UIButton!
    @IBOutlet weak var BuyCreditButton: UIButton!
    
    @IBOutlet weak var RapidPopUpView: RapidPopUp!
    
    var mapview:GMSMapView!
    var locationArr:CLLocation!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 35.69439, longitude: 51.42151, zoom: 3.0)
        mapview = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapview.mapStyle = try? GMSMapStyle(contentsOfFileURL: Bundle.main.url(forResource: "Style", withExtension: "json")!)
        mapview.isMyLocationEnabled = true
        
        RapidPopUpView.exitButtonGray.addTarget(self, action: #selector(self.exitButtonClick(sender:)), for: .touchUpInside)
        view.addSubview(mapview)
        view.sendSubviewToBack(mapview)
    }
    
    @objc func exitButtonClick(sender :UIButton){
        SavarShoButton.isHidden = false
        IssueButton.isHidden = false
        SetMyLocationButton.isHidden = false
        BuyCreditButton.isHidden = false
        
        RapidPopUpView.isHidden = true
    }
    
    func imageForPin(battery:Int) -> String{
        if battery > 60 {
            return "highPin"
        }else if battery > 40 && battery <= 60 {
            return "mediumPin"
        }
        return "lowPin"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let utilityQueue = DispatchQueue.global(qos :.utility)
        Alamofire.request("https://rapidscooter.ir/api/getScooterList.php").responseJSON(queue:utilityQueue){response in
            do{
                let json = try JSON(data: response.data!)
                for (_,subJson):(String,JSON) in json["scooter"]{
                    let position = CLLocationCoordinate2D(latitude: subJson[0].doubleValue, longitude: subJson[1].doubleValue)
                    let marker = GMSMarker(position: position)
                    marker.icon = UIImage(named: self.imageForPin(battery: subJson[2].intValue))
                    marker.map = self.mapview
                }
            }catch{
                debugPrint("Error")
            }
            
        }
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func SetMyLocationAction(_ sender: Any) {
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        autoreleasepool(){
            let camera = GMSCameraPosition.camera(withLatitude: (locationArr?.coordinate.latitude ?? -33.86)!, longitude: (locationArr?.coordinate.longitude ?? 151.2)!, zoom: 15.0)
            mapview.animate(to: camera)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationArr = locations.last
        autoreleasepool(){
            let camera = GMSCameraPosition.camera(withLatitude: (locationArr.coordinate.latitude), longitude: (locationArr.coordinate.longitude), zoom: 15.0)
            mapview.animate(to: camera)
        }
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    func showScooterView(responseString:String){
        SavarShoButton.isHidden = true
        IssueButton.isHidden = true
        SetMyLocationButton.isHidden = true
        BuyCreditButton.isHidden = true
        
        RapidPopUpView.isHidden = false
        print(responseString)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PresentModallyQrCodeReader"){
            let vc = segue.destination as! BarcodeReaderViewController
            vc.mainView = self
        }
    }
 

}
