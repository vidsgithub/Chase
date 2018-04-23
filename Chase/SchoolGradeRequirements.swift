//
//  SchoolGradeRequirements.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

class SchoolGradeRequirements: NSObject, Unboxable {
    var Subject:String = ""
    var min:Float = 0.0
    var max:Float = 0.0
    
    func splitMarks(item:String) {
        var sp = item.split(separator: "(")
        if sp.count > 0 {
            self.Subject = String(sp[0].trimmingCharacters(in: CharacterSet.whitespaces))

            if sp.count > 1 {
                sp[1].removeLast()      // remove right bracket
                let sp1 = String(sp[1]).components(separatedBy: "-")
                if sp1.count > 0 {
                    if let min = Float(sp1[0]) {
                        self.min = min
                    }
                    if let max = Float(sp1[1]) {
                        self.max = max
                    }
                }
            }
        }
    }
    
    func convertToGradesObj(str:String, range: Range<String.Index>) {
       // if let range = str.range(of: "Course Grades:") {
            let newStr = (str[range.upperBound..<str.endIndex]).trimmingCharacters(in: CharacterSet.whitespaces)
            let splitStr = newStr.components(separatedBy: ",")
            for item in splitStr {
                splitMarks(item: item.trimmingCharacters(in: CharacterSet.whitespaces))
            }
            if splitStr.count == 0 {
                splitMarks(item: newStr)
            }
        //}
    }
    
    // unboxing for json
    required  init(unboxer: Unboxer) {
        super.init()
        if let req1:String = unboxer.unbox(key: "requirement1_1") {
            if let range = req1.range(of: "Course Grades:") {
                self.convertToGradesObj(str: req1, range: range)
            } else if let range = req1.range(of: "Standardized Test Scores:") {
                self.convertToGradesObj(str: req1, range: range)
            }
        }
    }
}
