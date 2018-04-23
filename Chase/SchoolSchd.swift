//
//  SchoolSchd.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

class SchoolSchd: NSObject, Unboxable {
    var CurrentGrades:String = ""
    var FinalGrades:String = ""
    var StartTime:Date = Date.init()
    var EndTime:Date = Date.init()
    
    // unboxing for json
    required  init(unboxer: Unboxer) {
        if let cGrades:String = unboxer.unbox(key: "grades2018") {
            self.CurrentGrades = cGrades
        }
        if let fGrades:String = unboxer.unbox(key: "finalgrades") {
            self.FinalGrades = fGrades
        }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmx"
        if let startTime:Date = unboxer.unbox(key: "start_time", formatter: dateFormatter) {
            self.StartTime = startTime
        }
        if let endtTime:Date = unboxer.unbox(key: "end_time", formatter: dateFormatter) {
            self.EndTime = endtTime
        }
    }
}
