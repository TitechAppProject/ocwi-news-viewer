//
//  NewsRow.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import SwiftUI

struct NewsRow: View {
    let news: News
    var body: some View {
        VStack {
            if let info = news.info {
                Text("[\(info)] \(news.courseName)")
            } else {
                Text(news.courseName)
            }
            
            if let date = news.date {
                Text(dateText(date))
            }
            if let firstMediaLink = news.mediaLinks.first {
                switch firstMediaLink {
                case let .zoomLive(url, id, passcord):
                    VStack {
                        Text(url.absoluteString)
                        Text(id ?? "未検出")
                        Text(passcord ?? "未検出")
                    }
                case let .zoomRecord(url, password):
                    VStack {
                        Text(url.absoluteString)
                        Text(password ?? "未検出")
                    }
                }
            }
        }
    }
    
    private func dateText(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

        return dateFormatter.string(from: date)
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(
            news: News(
                id: UUID().uuidString,
                courseName: "電磁気学",
                info: "課題アップデート",
                description: "",
                mediaLinks: [
                    .zoomLive(
                        url: URL(string: "https://zoom.us/j/aaa")!,
                        id: "111 111 111",
                        passcord: "pass"
                    )
                ],
                date: Date(timeIntervalSince1970: 0
                )
            )
        )
    }
}
