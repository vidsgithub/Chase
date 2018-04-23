//
//  SchoolActivities.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

class SchoolActivities: NSObject, Unboxable {
    var ExtraCurricularActivites:[String] = [String]()
    var schoolSports:[String] = [String]()
    var boysSports:[String] = [String]()
    var girlsSports:[String] = [String]()
    var coedSports:[String] = [String]()
    
    // unboxing for json
    required  init(unboxer: Unboxer) {
        if let extraAct:String = unboxer.unbox(key: "extracurricular_activities") {
            self.ExtraCurricularActivites = extraAct.components(separatedBy: ",")
        }
        if let schoolSports:String = unboxer.unbox(key: "school_sports") {
            self.schoolSports = schoolSports.components(separatedBy: ",")
        }
        if let boysSports:String = unboxer.unbox(key: "psal_sports_boys") {
            self.boysSports = boysSports.components(separatedBy: ",")
        }
        if let girlsSports:String = unboxer.unbox(key: "psal_sports_girls") {
            self.girlsSports = girlsSports.components(separatedBy: ",")
        }
        if let coedSports:String = unboxer.unbox(key: "psal_sports_coed") {
            self.coedSports = coedSports.components(separatedBy: ",")
        }
    }
}
