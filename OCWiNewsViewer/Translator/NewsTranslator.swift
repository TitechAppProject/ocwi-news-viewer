//
//  NewsTranslator.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation

struct NewsTranslator {
    static func translate(entity: [CourseNews]) -> [News] {
        entity.map {
            News(
                id: UUID().uuidString, // TODO://
                courseName: $0.courseName,
                info: $0.info,
                description: $0.description
                    .replacingOccurrences(of: "<br />", with: "")
                    .replacingOccurrences(of: "\n", with: ""),
                mediaLinks: $0.mediaLinks,
                date: $0.pubDate ?? Date() // FIXME:
            )
        }
    }
}
