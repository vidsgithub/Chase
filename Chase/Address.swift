//
//  Address.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

struct Location {
    let latitude:Double
    let longitude:Double
}

class Address: NSObject, Unboxable {
    var add:String = ""
    var Block:String = ""
    var Street:String = ""
    var City:String = ""
    var Zip:String = ""
    var Phone:String = ""
    var Fax:String = ""
    var Email:[String] = [String]()
    var WebSite:String = ""
    var loc:Location?
    
    // if more time then i can convert to Address object
    func convertToAddresObj(address:String) {
        // 100 Luten Avenue, Staten Island NY 10312 (40.528152, -74.193431)
        // reading the first space
    }
    
    required  init(unboxer: Unboxer) {
        do {
//            let add:String = try unboxer.unbox(key: "location")
//            @ToDo: convertToAddresObj(address:add)
            self.add = try unboxer.unbox(key: "location")
            if let latitude:Double = unboxer.unbox(key: "latitude"), let longitude:Double = unboxer.unbox(key: "longitude") {
                self.loc = Location.init(latitude: latitude, longitude: longitude)
            }
        } catch let error {
            print("Error unboxing Address: \(error.localizedDescription)")
        }
    }
}
