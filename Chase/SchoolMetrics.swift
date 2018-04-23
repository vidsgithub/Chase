//
//  SchoolMetrics.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

class SchoolMetrics: NSObject, Unboxable {
    var GraduationRate:Float = 0.0
    var AttendenceRate:Float = 0.0
    var StudentDemographicRatio:Float = 0.0
    var CollageAcceptanceRate:Float = 0.0
    var StudentSafety:Float = 0.0
    
    // unboxing for json
    required  init(unboxer: Unboxer) {
        if let gRate:Float = unboxer.unbox(key: "graduation_rate") {
            self.GraduationRate = gRate
        }
        if let aRate:Float = unboxer.unbox(key: "attendance_rate") {
            self.AttendenceRate = aRate
        }
        if let dRate:Float = unboxer.unbox(key: "pct_stu_enough_variety") {
            self.StudentDemographicRatio = dRate
        }
        if let cRate:Float = unboxer.unbox(key: "college_career_rate") {
            self.CollageAcceptanceRate = cRate
        }
        if let sRate:Float = unboxer.unbox(key: "pct_stu_safe") {
            self.StudentSafety = sRate
        }
    }
}
