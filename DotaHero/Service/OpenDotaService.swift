//
//  OpenDotaService.swift
//  DotaHero
//
//  Created by Septian on 9/16/20.
//  Copyright © 2020 Septian. All rights reserved.
//

import Foundation

class OpenDotaService {
  
  static let host = "https://api.opendota.com"
  static let heroListPath = "/api/herostats"
  
  static func fetchHeroList(completion: @escaping ([Hero]) -> Void, failure: @escaping (String) -> Void) {
    
    let url = URL(string: host+heroListPath)!
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      //execute completion handler on main thread
      DispatchQueue.main.async {
        guard error == nil else {
          failure((error!.localizedDescription))
          return
        }
        
        guard let data = data else {
          failure("No data returned from Weatherbit")
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          failure("Unable to process Weatherbit response")
          return
        }
        
        guard response.statusCode == 200 else {
          failure("Failure response from Weatherbit: \(response.statusCode)")
          return
        }
        
        let decoder = JSONDecoder()
        let managedObjectContext = CoreDataStorage.shared.managedObjectContext()
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
          fatalError("Failed to retrieve managed object context Key")
        }
        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
        
        do {
          let result = try decoder.decode([Hero].self, from: data)
          completion(result)
        } catch let error {
          failure((error.localizedDescription))
        }
        
        CoreDataStorage.shared.clearStorage(forEntity: "Hero")
        CoreDataStorage.shared.saveContext()
        
      }
    }.resume()
  }
  
}
