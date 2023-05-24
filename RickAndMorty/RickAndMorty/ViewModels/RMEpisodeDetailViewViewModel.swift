//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-04-04.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endpointUrl,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let data):
                print(String(describing: data))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
