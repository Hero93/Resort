//
//  Activity.swift
//  Resort
//
//  Created by Luca Gramaglia on 15/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import MapKit

struct Activity: Identifiable, Equatable  {
    let id: Int
    let title: String
    let type: ActivityType
    let url: URL?
    let coordinate: CLLocationCoordinate2D?
    var subActivities: [Activity]?
}

extension CLLocationCoordinate2D: Equatable {
    static public func ==(left: CLLocationCoordinate2D, right: CLLocationCoordinate2D) -> Bool {
        return left.latitude == right.latitude && left.longitude == right.longitude
    }
}

enum ActivityType: Int {
    case dayProgram = 1
    case bar = 14
    case restaurant = 15
    case miniclub = 2
    case unknowned = -1
    case photo = 21
    case video = 20
    
    var icon: UIImage {
        switch self {
        case .dayProgram:
            return UIImage(named: "program")!
        case .restaurant:
            return UIImage(named: "reataurants")!
        case .bar:
            return UIImage(named: "bar")!
        case .miniclub:
            return UIImage(named: "miniclub")!
        case .unknowned, .video, .photo:
            return UIImage(named: "program")!
        }
    }
    
    var mapIcon: UIImage {
        switch self {
        case .dayProgram:
            return UIImage(named: "program_map_icon")!
        case .restaurant:
            return UIImage(named: "restaurnat_map_icon")!
        case .bar:
            return UIImage(named: "bar_map_icon")!
        case .miniclub:
            return UIImage(named: "club_map_icon")!
        case .unknowned, .video, .photo:
            return UIImage(named: "program_map_icon")!
        }
    }
}
