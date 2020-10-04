//
//  APIClient.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation
import Combine

struct APIClient {
    let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    
    func fetch(url: URL) -> AnyPublisher<Data, URLError> {
        session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
