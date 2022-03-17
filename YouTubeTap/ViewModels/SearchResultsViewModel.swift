//
//  SearchResultsViewModel.swift
//  YouTubeTap
//
//  Created by Kutarba Arthur on 16.03.2022.
//

import Foundation
import SwiftUI

@MainActor class SearchResultsViewModel: ObservableObject {
    @Published var iFrames: [String] = []
    var query = ""
    
    func updateResults() async {
        iFrames = await IFrameService().loadiFrames(
            query: query,
            size: SizeFormatter().iFrameSizePixels
        ) ?? []
    }
}
