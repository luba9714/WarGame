//
//  ViewController.swift
//  WarGame
//
//  Created by Luba Gluhov on 08/06/2023.
//
import CoreLocation

import UIKit

class ViewController: UIViewController, InsertNameDelegate ,CLLocationManagerDelegate {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var east: UIImageView!
    @IBOutlet weak var west: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var insertNameBtn: UIButton!
    var locationInfo: String?
    let locationManager = CLLocationManager()
    var longitude: Double = 0.0
    var userLocation: CLLocation?
    @IBAction func InsertNameClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popupViewController = storyboard.instantiateViewController (withIdentifier: "InsertNameViewController") as! InsertNameViewController
        popupViewController.delegate = self
        present(popupViewController, animated: true, completion: nil)
        
        
    }
    var name = UserDefaults.standard.string(forKey:"StoredTextKey")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"back2.png")!)
        locationManager.delegate = self
        if(name != nil){
            UserName.text=name
            east.isHidden=false;
            west.isHidden=false;
            startBtn.isHidden=false;
            insertNameBtn.isHidden=true
            location()
        }else{
            east.isHidden=true;
            west.isHidden=true;
            startBtn.isHidden=true;
            insertNameBtn.isHidden=false
        }
    }
    func location(){
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            //locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            // Or requestAlwaysAuthorization()
            break
        case .restricted, .denied:
            break
            // Handle denial or restriction of location services
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            locationManager.requestWhenInUseAuthorization()
            break
        }

    }
    
    func didEnterText(_ text: Any) {
        if(text as! Bool == true){
            location()
            name = UserDefaults.standard.string(forKey: "StoredTextKey");
            UserName.text = (name ?? "")
            east.isHidden=false;
            west.isHidden=false;
            startBtn.isHidden=false;
            insertNameBtn.isHidden=true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Start" {
            if let destinationVC = segue.destination as? GameViewController {
                destinationVC.message = locationInfo
            }
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        longitude = location.coordinate.longitude
        if longitude > 34.817549168324334 {
            west.alpha=0.3
            locationInfo = "east"
        } else {
            east.alpha=0.3
            locationInfo = "west"
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
        }
    }
}





