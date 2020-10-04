//
//  NewsListView.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.news) { news in
                NewsRow(news: news)
            }
            .onAppear {
                viewModel.appear()
            }
            .navigationTitle("お知らせ")
        }
        
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
