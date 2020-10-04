//
//  NewsViewModel.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var news = [News]()

    private var cancellable: AnyCancellable!

    func appear() {
        cancellable = APIClient()
            .fetch(url: URL(string: "https://ocwi-mock.titech.app/ocwi/index.php?module=Ocwi&action=Rss&type=1&id=VEm6iuiECp7oA")!)
            .tryMap { try RSSParser.parse($0) }
            .map { CourseNewsConverter.convert($0) }
            .map { NewsTranslator.translate(entity: $0) }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case let .failure(error):
                        print(error)
                    }
                },
                receiveValue: { news in
                    self.news = news
                }
            )
    }
}
