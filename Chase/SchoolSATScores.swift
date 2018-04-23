//
//  SchoolSATScores.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

class SchoolSATScores: NSObject, Unboxable {
    var ID:String = ""
    var studentTaken:Int = 0
    var reading:Int = 0
    var math:Int = 0
    var writing:Int = 0
    
    // unboxing for json
    required  init(unboxer: Unboxer) {
        do {
            self.ID = try unboxer.unbox(key: "dbn")
            if let taken:Int = unboxer.unbox(key: "num_of_sat_test_takers") {
                self.studentTaken = taken
            }
            if let reading:Int = unboxer.unbox(key: "sat_critical_reading_avg_score") {
                self.reading = reading
            }
            if let math:Int = unboxer.unbox(key: "sat_math_avg_score") {
                self.math = math
            }
            if let writing:Int = unboxer.unbox(key: "sat_writing_avg_score") {
                self.writing = writing
            }
        } catch let error {
            if let pathError = error as? UnboxError {
                print("Error unboxing SchoolSATScores: \(pathError.description)")
            }
        }
    }
}
