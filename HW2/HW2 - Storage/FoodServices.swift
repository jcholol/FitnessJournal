//
//  FoodServices.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/20/24.
//

import Foundation

class FoodServices {
    func fetchNutritionData(for query: String, completion: @escaping ([Food]?) -> Void) {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=\(query)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("3KVRD8x1ttF+l/Fy0/JhBA==M8pDUbRxBESgnJup", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching nutrition data: \(error)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                print("Server responded with an error")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received from the server")
                completion(nil)
                return
            }
            
            do {
                let nutritionData = try JSONDecoder().decode([Food].self, from: data)
                completion(nutritionData)
            } catch {
                print("Error decoding nutrition data: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchSuggestedFoods(for query: String, completion: @escaping ([Food]?) -> Void) {
        print("this working?")
        guard let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=\(query)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("3KVRD8x1ttF+l/Fy0/JhBA==M8pDUbRxBESgnJup", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching suggested foods: \(error)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                print("Server responded with an error")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received from the server")
                completion(nil)
                return
            }
            
            do {
                let suggestedFoods = try JSONDecoder().decode([Food].self, from: data)
                completion(suggestedFoods)
            } catch {
                print("Error decoding suggested foods: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
