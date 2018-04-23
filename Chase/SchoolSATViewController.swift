//
//  SchoolSATViewController.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit

class SchoolSATViewController: UIViewController {
    var schoolCollegeDataModel:SchoolDetails! {
        didSet {
            if let school = schoolCollegeDataModel {
                OperationQueue.main.addOperation {
                    self.navigationItem.title = school.Name
                }
            }
        }
    }
    var satScores:SchoolSATScores!
    
    @IBOutlet weak var satReading: UILabel!
    @IBOutlet weak var satMath: UILabel!
    @IBOutlet weak var satWriting: UILabel!
    @IBOutlet weak var satAppeared: UILabel!
    
    override func viewDidLoad() {
    }
    
    func setupLabels() {
        if let satScores = satScores {
            self.satAppeared.text = String.init(satScores.studentTaken)
            self.satMath.text = String.init(satScores.math)
            self.satReading.text = String.init(satScores.reading)
            self.satWriting.text = String.init(satScores.writing)
        }
    }
}
