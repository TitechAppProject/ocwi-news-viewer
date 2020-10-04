//
//  CourseNews.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation

struct CourseNews: Codable {
    let courseName: String
    let info: String?
    let link: URL
    let description: String
    let mediaLinks: [MediaLink]
    let pubDate: Date?
}

enum MediaLink: Codable {
    case zoomLive(url: URL, id: String?, passcord: String?)
    case zoomRecord(url: URL, password: String?)

    enum CodingKeys: CodingKey {
        case zoomLive
        case zoomRecord
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: container.codingPath, debugDescription: ""))
        }
        switch key {
        case .zoomLive:
            var nestedContainer = try container.nestedUnkeyedContainer(forKey: .zoomLive)
            let url = try nestedContainer.decode(URL.self)
            let id = try nestedContainer.decode(String?.self)
            let passcord = try nestedContainer.decode(String?.self)
            self = .zoomLive(url: url, id: id, passcord: passcord)
        case .zoomRecord:
            var nestedContainer = try container.nestedUnkeyedContainer(forKey: .zoomRecord)
            let url = try nestedContainer.decode(URL.self)
            let password = try nestedContainer.decode(String?.self)
            self = .zoomRecord(url: url, password: password)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .zoomLive(url, id, passcord):
            var nestedContainer = container.nestedUnkeyedContainer(forKey: .zoomLive)
            try nestedContainer.encode(url)
            try nestedContainer.encode(id)
            try nestedContainer.encode(passcord)
        case let .zoomRecord(url, password):
            var nestedContainer = container.nestedUnkeyedContainer(forKey: .zoomRecord)
            try nestedContainer.encode(url)
            try nestedContainer.encode(password)
        }
    }
}
