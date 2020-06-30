//
//  ActivityDTO.swift
//  Resort
//
//  Created by Luca LG. Gramaglia on 16/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import CoreLocation

struct ActivityDTO: Codable {
    let id: Int
    let title: String
    let url: String
    let type: Int
    let latitude: String?
    let longitude: String?
    var subActivities: [ActivityDTO]?
}

struct ActivityDTOMapper {
    
    static func map(_ dto: ActivityDTO) -> Activity {
        
        var subActivities: [Activity]? = nil
        var cllocationCoordinate: CLLocationCoordinate2D?

        if let dtoSubActivities = dto.subActivities {
                    
            subActivities = dtoSubActivities.map { subActivityDTO -> Activity in
                                
                var cllocationCoordinate: CLLocationCoordinate2D?
                if let latitudeString = subActivityDTO.latitude,
                    let longitudeString = subActivityDTO.longitude {
                    let coordinate = ActivityDTO.Coordinate(latitude: latitudeString, longitude: longitudeString)
                    cllocationCoordinate = ActivityDTO.getCLLocationCoordinate2D(from: coordinate)
                }
                                
                return Activity(id: subActivityDTO.id,
                                title: subActivityDTO.title,
                                type: ActivityType(rawValue: subActivityDTO.type) ?? .unknowned,
                                url: URL(string: subActivityDTO.url)!,
                                coordinate: cllocationCoordinate,
                                subActivities: nil)
            }
        }
        
        if let latitudeString = dto.latitude,
            let longitudeString = dto.longitude {
            let coordinate = ActivityDTO.Coordinate(latitude: latitudeString, longitude: longitudeString)
            cllocationCoordinate = ActivityDTO.getCLLocationCoordinate2D(from: coordinate)
        }
        
        return Activity(id: dto.id,
                        title: dto.title,
                        type: ActivityType(rawValue: dto.type) ?? .unknowned,
                        url: URL(string: dto.url)!,
                        coordinate: cllocationCoordinate,
                        subActivities: subActivities)
    }
}

extension ActivityDTO {
    
    struct Coordinate {
        let latitude: String
        let longitude: String
    }
    
    static func getCLLocationCoordinate2D(from coordinate: Coordinate) -> CLLocationCoordinate2D?{
        guard let latitude = Double(coordinate.latitude),
            let longitude = Double(coordinate.longitude) else {
                return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
