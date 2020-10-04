//
//  News.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation

struct News: Identifiable {
    let id: String
    let courseName: String
    let info: String?
    let description: String
    let mediaLinks: [MediaLink]
    let date: Date?
}

extension MediaLink: Identifiable {
    var id: String {
        UUID().uuidString
    }
}
