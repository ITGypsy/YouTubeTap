//
//  SearchResultsView.swift
//  YouTubeTap
//
//  Created by Kutarba Arthur on 16.03.2022.
//

import SwiftUI

struct SearchResultsView: View {
    @StateObject private var viewModel = SearchResultsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                let iFrameSize = SizeFormatter().iFrameSize
                LazyVStack(alignment: .center, spacing: 0) {
                    ForEach(viewModel.iFrames, id: \.self) {
                        iFrameView(iFrame: $0)
                            .frame(
                                width: iFrameSize.width,
                                height: iFrameSize.height
                            )
                    }
                }
            }
            .navigationTitle(viewModel.query)
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $viewModel.query)
        .onSubmit(of: .search, { updateResults() })
        .onAppear { updateResults() }
    }
    
    private func updateResults() {
        Task { await viewModel.updateResults() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}
