import SwiftUI
import Combine

class PlayerData: ObservableObject {
    @Published var playerResponse: PlayerResponse? = nil
    
    init() {
        // Apply the receive(on:) operator to ensure updates are on the main thread
        $playerResponse
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    private var cancellables: Set<AnyCancellable> = []
}
