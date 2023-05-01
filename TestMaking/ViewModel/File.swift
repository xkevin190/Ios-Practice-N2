//
//  File.swift
//  TestMaking
//
//  Created by Kevin Velasco on 28/4/23.
//

import Foundation
import CoreLocation
import SwiftUI

class ItemsViewModel: ObservableObject {
    
    
    
    
    func getLocationFromPhoto(photo: UIImage) -> CLLocationCoordinate2D? {
        guard let imageData = photo.jpegData(compressionQuality: 1.0) else { return nil }
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [CFString: Any] else { return nil }
        guard let gpsData = imageProperties[kCGImagePropertyGPSDictionary] as? [CFString: Any] else { return nil }
        
        let latitudeRef = gpsData[kCGImagePropertyGPSLatitudeRef] as? String ?? "N"
        let latitude = gpsData[kCGImagePropertyGPSLatitude] as? Double ?? 0.0
        let longitudeRef = gpsData[kCGImagePropertyGPSLongitudeRef] as? String ?? "E"
        let longitude = gpsData[kCGImagePropertyGPSLongitude] as? Double ?? 0.0
        
        let location = CLLocationCoordinate2D(latitude: latitude * (latitudeRef == "N" ? 1 : -1), longitude: longitude * (longitudeRef == "E" ? 1 : -1))
        return location
    }

    
}
