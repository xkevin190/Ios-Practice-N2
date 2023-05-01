//
//  LocationViewModel.swift
//  TestMaking
//
//  Created by Kevin Velasco on 30/4/23.
//


import Foundation
import CoreLocation
import SwiftUI

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @Published var userLocation: UserLocation = UserLocation(postalCode: "", city: "", country: "", address: "")
    
    func requestLocationPermission () {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Reverse geocode the location
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error getting location: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            
            let postalCode = placemark.postalCode ?? "unknow"
            let city = placemark.locality ?? ""
            let country = placemark.country ?? ""
            let address = "\(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")"
            
            self.userLocation = UserLocation(postalCode: postalCode, city: city, country: country, address: address)
            
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }

}
