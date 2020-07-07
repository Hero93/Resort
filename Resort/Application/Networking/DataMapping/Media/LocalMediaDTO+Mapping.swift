//
//  LocalMediaDTO.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import CoreLocation

struct LocalMediaDTO: Codable {
    let id: Int
    let title: String
    let url: String
    let type: Int
    let latitude: String?
    let longitude: String?
    var subActivities: [LocalMediaDTO]?
}

extension LocalMediaDTO {
    struct Coordinate {
        let latitude: String
        let longitude: String
    }
    
    static func getCLLocationCoordinate2D(from coordinate: Coordinate) -> CLLocationCoordinate2D? {
        guard let latitude = Double(coordinate.latitude),
            let longitude = Double(coordinate.longitude) else {
                return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension LocalMediaDTO {
    
    func toDomain() -> Activity {
        
        var subActivities: [Activity]? = nil
        var cllocationCoordinate: CLLocationCoordinate2D?
        
        if let dtoSubActivities = self.subActivities {

            subActivities = dtoSubActivities.map { subActivityDTO -> Activity in

                var cllocationCoordinate: CLLocationCoordinate2D?
                if let latitudeString = subActivityDTO.latitude,
                    let longitudeString = subActivityDTO.longitude {
                    let coordinate = LocalMediaDTO.Coordinate(latitude: latitudeString, longitude: longitudeString)
                    cllocationCoordinate = LocalMediaDTO.getCLLocationCoordinate2D(from: coordinate)
                }

                return Activity(id: subActivityDTO.id,
                                title: subActivityDTO.title,
                                type: ActivityType(rawValue: subActivityDTO.type) ?? .unknowned,
                                url: URL(string: subActivityDTO.url)!,
                                coordinate: cllocationCoordinate,
                                subActivities: nil)
            }
        }

        if let latitudeString = latitude,
            let longitudeString = longitude {
            let coordinate = LocalMediaDTO.Coordinate(latitude: latitudeString, longitude: longitudeString)
            cllocationCoordinate = LocalMediaDTO.getCLLocationCoordinate2D(from: coordinate)
        }
        
        return Activity(id: id,
                        title: title,
                        type: ActivityType(rawValue: type) ?? .unknowned,
                        url: URL(string: url)!,
                        coordinate: cllocationCoordinate,
                        subActivities: subActivities)
        
    }
}
