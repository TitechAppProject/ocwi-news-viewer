//
//  NewsMediaLinkDetector.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation

// TODO: 英語の場合
struct NewsMediaLinkDetector {
    static func detect(newsDescription: String) -> [MediaLink] {
        var result: [MediaLink] = []

        let descriptionText = newsDescription.replacingOccurrences(of: "<br />", with: "\n")

        if let zoomLiveLink = detectZoomLiveLink(text: descriptionText) {
            result += [zoomLiveLink]
        }

        if let zoomRecordLink = detectZoomRecordLink(text: descriptionText) {
            result += [zoomRecordLink]
        }

        return result
    }

    private static func detectZoomLiveLink(text: String) -> MediaLink? {
        guard let url = text.match0("https://zoom.us/j/([0-9]+)\\?pwd=(.+)").flatMap({ URL(string: $0) }) else {
            return nil
        }

        let id = text.match("ミーティングID: ([0-9 ]+)")
        let passcord = text.match("パスコード: (.+)")

        return .zoomLive(
            url: url,
            id: id,
            passcord: passcord
        )
    }

    private static func detectZoomRecordLink(text: String) -> MediaLink? {
        guard let url = text.match0("https://zoom.us/rec/share/(.+)").flatMap({ URL(string: $0) }) else {
            return nil
        }

        let password = text.match("アクセスパスワード: (.+)")

        return .zoomRecord(
            url: url,
            password: password
        )
    }
}
