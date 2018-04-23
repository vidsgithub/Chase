//
//  ViewController.swift
//  Chase
//
//  Created by Shingade on 4/19/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var schoolModel:[SchoolDetails] = [SchoolDetails]()
    var searchSchoolModel:[SchoolDetails]?
    var isSearching = false
    
    // fetch School Details
    func fetchSchoolData() {
        API.shared.fetchSchoolInfo(
           onSuccess: { (schoolData) in
                self.schoolModel = schoolData
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
            },
           onFailure: { (error) in
            if let err = error {
                print(err)
            }
        })
    }
    
    func filterContentforSearchText(searchText:String) {
        if self.schoolModel.count <= 0 {
            if searchSchoolModel == nil {
                return
            }
        }
        
        self.searchSchoolModel = self.schoolModel.filter({ (schoolModel:SchoolDetails) -> Bool in
            return schoolModel.Name.lowercased().contains(searchText.lowercased())
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSchoolData()
        
        // search delegate
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "schoolDetails"?:
            // get current selected cell
            if let selectedCell = self.collectionView.indexPathsForSelectedItems?.first {
                let schoolDataModel = self.schoolModel[selectedCell.row]
                API.shared.fetchSatScores(forSchoolID: schoolDataModel.ID, onSuccess: { (satScores) in
                    let targetVC = segue.destination as? SchoolSATViewController
                    targetVC?.schoolCollegeDataModel = schoolDataModel
                    targetVC?.satScores = satScores
                    OperationQueue.main.addOperation {
                        targetVC?.setupLabels()
                    }
                }) { (error) in
                    print("Error in fetching SAT scores")
                }
            }
        default:
            precondition(false, "Error in segue selection")
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if self.isSearching {
            if let filterData = self.searchSchoolModel {
                count = filterData.count
            }
        } else {
            count = self.schoolModel.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SchoolInfoCollectionViewCell", for: indexPath)
        var schoolData:SchoolDetails?
        if self.isSearching {
            if let filterData = self.searchSchoolModel {
                schoolData = filterData[indexPath.row]
            }
        } else {
            schoolData = schoolModel[indexPath.row]
        }
        
        if let schoolCell = cell as? SchoolInfoCollectionViewCell {
            if let schoolData = schoolData {
                schoolCell.address.text = schoolData.Add.add
                schoolCell.schoolSchd.text = "StartTime: \(schoolData.Schd.StartTime) - EndTime: \(schoolData.Schd.EndTime)"
                schoolCell.collegeName.text = schoolData.Name
                schoolCell.schoolMetrics.text = "AT: \(schoolData.Metrics.AttendenceRate), GR:\(schoolData.Metrics.GraduationRate), DR:\(schoolData.Metrics.StudentDemographicRatio), ST: \(schoolData.Metrics.StudentSafety)"
                if let add = schoolData.Add {
                    schoolCell.loc = add.loc
                }
            }
        }
        
        return cell
    }
    
    func mapSnapper(loc:Location) -> MKMapSnapshotter? {
        var mapShotter:MKMapSnapshotter? = nil
        let mapSnapOptions:MKMapSnapshotOptions = MKMapSnapshotOptions()
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees.init(loc.latitude), longitude: CLLocationDegrees.init(loc.longitude))
        let region = MKCoordinateRegionMakeWithDistance(location, 300, 300)
        mapSnapOptions.region = region
        mapSnapOptions.scale = UIScreen.main.scale
        mapSnapOptions.size = CGSize(width: 200.0, height: 200.0)
        mapSnapOptions.showsPointsOfInterest = true
        mapShotter = MKMapSnapshotter.init(options: mapSnapOptions)
        
        return mapShotter
    }
    
    // lazy rendering for images
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let itemAtCurrCell = self.schoolModel[indexPath.row]
        if let itemAdd = itemAtCurrCell.Add, let locCoords = itemAdd.loc {
            let snapShotter = self.mapSnapper(loc: locCoords)
            snapShotter?.start(completionHandler: { (snapshot, error) in
                guard let img = snapshot?.image else { return }
                // get the current cell
                if let cell = collectionView.cellForItem(at: indexPath) as? SchoolInfoCollectionViewCell {
                    cell.updateWithImage(img: img)
                }
            })
        }
    }
}

extension ViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearching = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchSchoolModel = self.schoolModel.filter({ (text:SchoolDetails) -> Bool in
            return text.Name.trimmingCharacters(in: CharacterSet.whitespaces).lowercased().contains(searchText.trimmingCharacters(in: .whitespaces).lowercased())
        })
        
        if let filterData = searchSchoolModel, filterData.count > 0 {
            self.isSearching = true
        }
        else {
            self.isSearching = false
        }
        self.collectionView.reloadData()
        
    }
}


