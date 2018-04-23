//
//  SchoolInfoCollectionViewCell.swift
//  Chase
//
//  Created by Shingade on 4/20/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import MapKit

class SchoolInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var schoolSchd: UILabel!
    @IBOutlet weak var schoolMetrics: UILabel!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var loc:Location?
    
    func addTapGestureOnImage() {
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onLaunchLoc))
        tapGesture.numberOfTapsRequired = 1
        self.imageView.addGestureRecognizer(tapGesture)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGestureOnImage()
    }
    
    @objc func onLaunchLoc(_ sender: UITapGestureRecognizer) {
        if let locCoords = loc {
            let addLoc = CLLocationCoordinate2D.init(latitude: locCoords.latitude, longitude: locCoords.longitude)
            SchoolLaunchMaps.launchInMaps(addressLoc: addLoc, addName: self.collegeName.text)
        }
    }
    
    func updateWithImage(img:UIImage?) {
        if let goodImg = img {
            self.activityIndicator.stopAnimating()
            imageView.image = goodImg
        } else {
            self.activityIndicator.startAnimating()
            imageView.image = nil
        }
    }
}
