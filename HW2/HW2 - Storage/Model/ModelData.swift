//
//  ModelData.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/20/24.
//

import Combine
import Foundation

class ModelData: ObservableObject {
    @Published var foods: [Food] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchFoods()
    }
    
    private func fetchFoods() {
        APIService.shared.fetchFoods { [weak self] foods in
            guard let self = self, let foods = foods else {
                return
            }
            
            self.foods = foods
        }
    }
}
