//
//  NewsMediaLinkDetector.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation

struct NewsMediaLinkDetector {
    static func detect(newsDescription: String) -> [MediaLink] {
        let descriptionText = newsDescription.replacingOccurrences(of: "<br />", with: "\n")

        return detectZoomLiveLink(text: descriptionText) +
            detectZoomRecordLink(text: descriptionText) +
            detectYoutubeLink(text: descriptionText)
    }
    
    private static func detectZoomLiveLink(text: String) -> [MediaLink] {
        guard let url = text.match0("https://(([^.\\s]+\\.)*)zoom.us/j/(.+)").flatMap({ URL(string: $0) }) else {
            return []
        }

        let id = text.match("ミーティングID: ([0-9 ]+)")
        let passcord = text.match("パスコード: (.+)")

        return [
            .zoomLive(
                url: url,
                id: id,
                passcord: passcord
            )
        ]
    }

    private static func detectZoomRecordLink(text: String) -> [MediaLink] {
        guard let url = text.match0("https://zoom.us/rec/share/(.+)").flatMap({ URL(string: $0) }) else {
            return []
        }

        let password = text.match("アクセスパスワード: (.+)")

        return [
            .zoomRecord(url: url, password: password)
        ]
    }
    
    private static func detectYoutubeLink(text: String) -> [MediaLink] {
        guard let matchResult = text.matches0("https://(www\\.)?youtu\\.?be(\\.com)?/(.+)") else {
            return []
        }

        return matchResult.compactMap {
            guard let url = URL(string: $0[0]) else {
                return nil
            }

            return MediaLink.youtube(url: url)
        }
        
    }
}
