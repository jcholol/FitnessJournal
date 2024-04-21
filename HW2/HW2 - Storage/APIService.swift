//
//  APIService.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/21/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func fetchFoods(completion: @escaping ([Food]?) -> Void) {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=apple") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("3KVRD8x1ttF+l/Fy0/JhBA==M8pDUbRxBESgnJup", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let foodsResponse = try JSONDecoder().decode([Food].self, from: data)
                completion(foodsResponse)
            } catch {
                print("Error decoding response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

    func searchFoods(query: String, completion: @escaping ([Food]?) -> Void) {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=\(query)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { _, _, _ in
            // Handle the response and decode the data
            // ...
        }.resume()
    }
}
