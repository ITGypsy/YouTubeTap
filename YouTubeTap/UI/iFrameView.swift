//
//  iFrameView.swift
//  YouTubeTap
//
//  Created by Kutarba Arthur on 16.03.2022.
//

import SwiftUI
import WebKit

struct iFrameView: UIViewRepresentable {
    let iFrame: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let iFrame = iFrame else { return }
        uiView.loadHTMLString(iFrame, baseURL: nil)
    }
}
