//
//  MapViewModel.swift
//  Resort
//
//  Created by Luca Gramaglia on 21/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import MapKit

class ActivityMapViewModel: NSObject {

    public let id: Int
    public let url: URL?
    public let coordinate: CLLocationCoordinate2D
    public let image: UIImage
    public let activityDescription: String
    
    init(id: Int, url: URL?, coordinate: CLLocationCoordinate2D, image: UIImage, activityDescription: String) {
        self.coordinate = coordinate
        self.image = image
        self.activityDescription = activityDescription
        self.id = id
        self.url = url
    }
}

// MARK: - MKAnnotation

extension ActivityMapViewModel: MKAnnotation {
  
    public var title: String? {
        return activityDescription
    }
}
