//
//  IFrameService.swift
//  YouTubeTap
//
//  Created by Kutarba Arthur on 16.03.2022.
//

import Foundation
import UIKit

class IFrameService {
    func loadiFrames(query: String, size: CGSize) async -> [String]? {
        guard let html = await loadHTML(query: query),
              let videoLinks = getVideoLinks(html: html) else { return nil }
        let iFrames = videoLinks.map {
            "<iframe width=\"\(size.width)\" height=\"\(size.height)\" src=\"https://www.youtube.com/embed/\($0)?&playsinline=1\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>"
        }
        return iFrames
    }
}

private extension IFrameService {
    func loadHTML(query: String) async -> String? {
        guard let url = getURL(query: query) else {
            assertionFailure("url nil")
            return nil
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        guard let (data, _) = try? await session.data(for: request),
              var html = String(data: data, encoding: .ascii) else { return nil }
        [#"\x3d"#, #"\x22"#].forEach {
            html = html.replacingOccurrences(of: $0, with: "")
        }
        return html
    }
    
    func getURL(query: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "youtube.com"
        urlComponents.path = "/results"
        urlComponents.queryItems = [URLQueryItem(name: "search_query", value: query)]
        return urlComponents.url
    }
    
    func getVideoLinks(html: String) -> [String]? {
        let pattern = #"watch[a-zA-Z0-9\-? ]*,"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            assertionFailure("regex nil")
            return nil
        }
        let nsRange = NSRange(location: 0, length: html.count)
        let matches = regex.matches(in: html, options: [], range: nsRange)
        let ranges = matches.compactMap { Range($0.range, in: html) }
        let matchingTexts = ranges.map { html[$0] }
        return matchingTexts.map {
            $0
                .replacingOccurrences(of: "watch?v", with: "")
                .replacingOccurrences(of: ",", with: "")
        }
    }
}
