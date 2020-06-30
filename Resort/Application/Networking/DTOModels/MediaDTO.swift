//
//  MediaDTO.swift
//  Resort
//
//  Created by Luca Gramaglia on 17/06/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit
import MapKit

struct MediaDTO: Codable {
    let id: Int
    let sourceURL: String
    let caption: Caption
    let mediacategory: [Int]
    let acf: AcfUnion

    enum CodingKeys: String, CodingKey {
        case id
        case sourceURL = "source_url"
        case caption
        case mediacategory
        case acf
    }
}

enum AcfUnion: Codable {
    case acfClass(AcfClass)
    case anythingArray([JSONAny])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(AcfClass.self) {
            self = .acfClass(x)
            return
        }
        throw DecodingError.typeMismatch(AcfUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AcfUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .acfClass(let x):
            try container.encode(x)
        case .anythingArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AcfClass
struct AcfClass: Codable {
    let lat, lon: String
}

// MARK: - Caption

struct Caption: Codable {
    let rendered: String
}

struct Acf : Codable {
    let lat : String?
    let lon : String?

    enum CodingKeys: String, CodingKey {

        case lat = "lat"
        case lon = "lon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
    }
}

struct MediaDTOMapper {
    static func map(_ dto: MediaDTO) -> Activity {

        var coordinate: CLLocationCoordinate2D? = nil
        
        switch dto.acf {
        case .acfClass(let acfClass):
            
            if let latitude = Double(acfClass.lat),
                let longitude = Double(acfClass.lon) {
                coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
            
        default:
            break
        }
        
        return Activity(id: dto.id,
                        title: dto.caption.rendered.htmlAttributedString(font: .systemFont(ofSize: 10)).string,
                        type: ActivityType(rawValue: dto.mediacategory.first ?? -1) ?? .unknowned,
                        url: URL(string: dto.sourceURL),
                        coordinate: coordinate,
                        subActivities: nil)
    }
}
