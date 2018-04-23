//
//  SchoolDetails.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

class SchoolDetails: NSObject, Unboxable {
    var ID:String = ""
    var Name:String = ""
    var Summary:String = ""
    var apClasses:[String] = [String]()
    var languageClasses:[String] = [String]()
    var Neighborhood:String = ""
    var Add:Address!
    var TotalStudents:Int = 0
    var Schd:SchoolSchd!
    var Activities:SchoolActivities!
    var Metrics:SchoolMetrics!
    var GradeReq:SchoolGradeRequirements!
    
    // unboxing for json
    required  init(unboxer: Unboxer) {
        do {
            self.ID = try unboxer.unbox(key: "dbn")
            self.Name = try unboxer.unbox(key: "school_name")
            self.Summary = try unboxer.unbox(key: "overview_paragraph")
            if let apClass:String = unboxer.unbox(key: "advancedplacement_courses") {
                self.apClasses = apClass.components(separatedBy: ",")
            }
            if let langClass:String = unboxer.unbox(key: "languageClasses") {
                self.languageClasses = langClass.components(separatedBy: ",")
            }
            self.Neighborhood = try unboxer.unbox(key: "neighborhood")
            
            self.Add = Address.init(unboxer: unboxer)
            self.Schd = SchoolSchd.init(unboxer: unboxer)
            self.Activities = SchoolActivities.init(unboxer: unboxer)
            self.Metrics = SchoolMetrics.init(unboxer: unboxer)
            self.GradeReq = SchoolGradeRequirements.init(unboxer: unboxer)
            
        } catch let error {
            if let pathError = error as? UnboxError {
                print("Error unboxing SchoolDetails \(pathError.description)")
            }
        }
    }
}
