//
//  RSS.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation

struct RSS: Codable {
    let title: String
    let link: URL
    let description: String
    let items: [RSSItem]
}

struct RSSItem: Codable {
    let title: String
    let link: URL
    let author: String?
    let description: String
    let pubDate: Date?
}
