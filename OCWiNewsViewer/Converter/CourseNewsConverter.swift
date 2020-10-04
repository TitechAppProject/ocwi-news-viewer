//
//  CourseNewsConverter.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation

struct CourseNewsConverter {
    static func convert(_ input: RSS) -> [CourseNews] {
        input.items.map { item in
            let splitTitle = item.title.components(separatedBy: "】")
            let courseName: String
            let info: String?
            if splitTitle.count > 1 {
                courseName = splitTitle[1]
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                info = splitTitle[0]
                    .replacingOccurrences(of: "【", with: "")
                    .replacingOccurrences(of: "TOKYO TECH OCW-i ", with: "")
                    .replacingOccurrences(of: "のお知らせメール", with: "")
                    .replacingOccurrences(of: "メール", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                courseName = item.title
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                info = nil
            }
            return CourseNews(
                courseName: courseName,
                info: info,
                link: item.link,
                description: item.description,
                mediaLinks: NewsMediaLinkDetector.detect(newsDescription: item.description),
                pubDate: item.pubDate
            )
        }
    }
}
