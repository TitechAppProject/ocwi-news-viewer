//
//  RSSParser.swift
//  OCWiNewsViewer
//
//  Created by nanashiki on 2020/10/04.
//

import Foundation
import Kanna

enum RSSParserError: Error {
    case parseXMLFailed
    case channelNotFound
}


struct RSSParser {
    static func parse(_ input: Data) throws -> RSS {
        guard let doc = { () -> XMLDocument? in
            do {
                return try XML(xml: input, encoding: String.Encoding.utf8)
            } catch {
                print(error)
                return nil
            }
        }() else {
            throw RSSParserError.parseXMLFailed
        }

        guard
            let channel = doc.css("channel").first,
            let channelTitle = channel.css("title").first?.text,
            let channelURL = channel.css("link").first?.text.flatMap({ URL(string: $0.convertSpecialCharacters()) }),
            let channelDescription = channel.css("description").first?.text
        else {
            throw RSSParserError.channelNotFound
        }

        let pubDateFormatter = DateFormatter()
        pubDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        pubDateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"

        let items: [RSSItem] = channel.css("item").compactMap { item in
            guard
                let title = item.css("title").first?.text?.convertSpecialCharacters(),
                let link = item.css("link").first?.text.flatMap({ URL(string: $0.convertSpecialCharacters()) }),
                let description = item.css("description").first?.text?.convertSpecialCharacters()
            else {
                return nil
            }

            let pubDate = item.css("pubDate").first?.text.flatMap { pubDateFormatter.date(from: $0) }
            let author = item.css("author").first?.text

            return RSSItem(
                title: title,
                link: link,
                author: author,
                description: description,
                pubDate: pubDate
            )
        }

        return RSS(
            title: channelTitle,
            link: channelURL,
            description: channelDescription,
            items: items
        )
    }
}

extension String {
    fileprivate func convertSpecialCharacters() -> String {
        var newString = self
        let charDictionary = [
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&quot;": "\"",
            "&apos;": "'",
        ]
        for (escapedChar, unescapedChar) in charDictionary {
            newString = newString.replacingOccurrences(of: escapedChar, with: unescapedChar, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
}
