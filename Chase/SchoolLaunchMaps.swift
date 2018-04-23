//
//  SchoolLaunchMaps.swift
//  Chase
//
//  Created by Shingade on 4/22/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import MapKit

class SchoolLaunchMaps: NSObject {
    static func launchInMaps(addressLoc: CLLocationCoordinate2D, addName: String?) {
        // Conver CLPlacemark to MKPlacemark
        let mkPlacemark = MKPlacemark.init(coordinate: addressLoc)
        // create MapItems
        let map:MKMapItem = MKMapItem.init(placemark: mkPlacemark)
        if let addName = addName {
            map.name = addName
        }
        // open in mapviewer
        map.openInMaps()
    }
}
