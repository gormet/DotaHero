//
//  HeroListViewModel.swift
//  DotaHero
//
//  Created by Septian on 9/16/20.
//  Copyright © 2020 Septian. All rights reserved.
//

import Foundation
import CoreData

protocol HeroListViewModelDelegate: NSObject {
  func fetchHeroSuccess()
  func fetchHeroFailedWithMessage(_ message: String)
}

class HeroListViewModel {
  
  var heroList = [Hero]()
  weak var delegate: HeroListViewModelDelegate?
  
  init(delegate: HeroListViewModelDelegate) {
    self.delegate = delegate
  }
  
  func fetchDataFromAPI() {
    OpenDotaService.fetchHeroList(completion: { [weak self] list in
      guard let self = self else {
        return
      }
      self.heroList = list
      self.delegate?.fetchHeroSuccess()
    }) { [weak self] message in
      self?.delegate?.fetchHeroFailedWithMessage(message)
    }
  }
  
  func fetchDataFromLocal() {
    
    let context = CoreDataStorage.shared.managedObjectContext()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Hero.self))
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
    do {
      let result = try context.fetch(fetchRequest)
      if let resultList = result as? [Hero]{
        self.heroList = resultList
        self.delegate?.fetchHeroSuccess()
      }
    } catch {
      self.delegate?.fetchHeroFailedWithMessage(error.localizedDescription)
    }
  }
  
  func getAllHeroNames() -> [String] {
    let names = heroList.compactMap{ $0.name }
    return names
  }
  
  
}
