//
//  HeroDetailViewModel.swift
//  DotaHero
//
//  Created by Septian on 9/17/20.
//  Copyright © 2020 Septian. All rights reserved.
//

import Foundation
import CoreData

protocol HeroDetailViewModelDelegate: NSObject {
  func fetchOtherHeroSuccess()
  func fetchHeroFailedWithMessage(_ message: String)
}

class HeroDetailViewModel {
  
  var currentHero: Hero
  var otherHeroList = [Hero]()
  
  weak var delegate: HeroDetailViewModelDelegate?
  
  init(_ hero: Hero) {
    currentHero = hero
  }
  
  func fetchOtherAgilityHeroes() {
    let context = CoreDataStorage.shared.managedObjectContext()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Hero.self))
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "movementSpeed", ascending: false)]
    fetchRequest.predicate = NSPredicate(format: "id != %d", currentHero.id)
    fetchRequest.fetchLimit = 3
    do {
      let result = try context.fetch(fetchRequest)
      if let resultList = result as? [Hero]{
        self.otherHeroList = resultList
        self.delegate?.fetchOtherHeroSuccess()
      }
    } catch {
      self.delegate?.fetchHeroFailedWithMessage(error.localizedDescription)
    }
  }
  
  func fetchOtherIntelegentHeroes() {
    let context = CoreDataStorage.shared.managedObjectContext()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Hero.self))
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "baseMana", ascending: false)]
    fetchRequest.predicate = NSPredicate(format: "id != %d", currentHero.id)
    fetchRequest.fetchLimit = 3
    do {
      let result = try context.fetch(fetchRequest)
      if let resultList = result as? [Hero]{
        self.otherHeroList = resultList
        self.delegate?.fetchOtherHeroSuccess()
      }
    } catch {
      self.delegate?.fetchHeroFailedWithMessage(error.localizedDescription)
    }
  }
  
  func fetchOtherStrengthHeroes() {
    let context = CoreDataStorage.shared.managedObjectContext()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Hero.self))
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "baseDamageMax", ascending: false)]
    fetchRequest.predicate = NSPredicate(format: "id != %d", currentHero.id)
    fetchRequest.fetchLimit = 3
    do {
      let result = try context.fetch(fetchRequest)
      if let resultList = result as? [Hero]{
        self.otherHeroList = resultList
        self.delegate?.fetchOtherHeroSuccess()
      }
    } catch {
      self.delegate?.fetchHeroFailedWithMessage(error.localizedDescription)
    }
  }
  
  func fetchOtherHeroes() {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else {
        return
      }
      
      switch self.currentHero.primaryAttribute {
      case "agi":
        self.fetchOtherAgilityHeroes()
      case "int":
        self.fetchOtherIntelegentHeroes()
      case "str":
        self.fetchOtherStrengthHeroes()
      default:
        break
      }
    }
  }
}
