//
//  NewsDetailView.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import SwiftUI

struct NewsDetailView: View {
    let news: News
    var body: some View {
        Text(news.description)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(
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
