//
//  Hero+CoreDataProperties.swift
//  DotaHero
//
//  Created by Septian on 9/17/20.
//  Copyright © 2020 Septian. All rights reserved.
//
//

import Foundation
import CoreData


extension Hero {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
    return NSFetchRequest<Hero>(entityName: "Hero")
  }
  
  @NSManaged public var agiGain: Float
  @NSManaged public var baseAgi: Int16
  @NSManaged public var baseArmor: Float
  @NSManaged public var baseDamageMax: Int16
  @NSManaged public var baseDamageMin: Int16
  @NSManaged public var baseInt: Int16
  @NSManaged public var baseStr: Int16
  @NSManaged public var attackType: String?
  @NSManaged public var id: Int16
  @NSManaged public var image: String?
  @NSManaged public var intGain: Float
  @NSManaged public var movementSpeed: Int16
  @NSManaged public var name: String?
  @NSManaged public var primaryAttribute: String?
  @NSManaged public var roles: [String]
  @NSManaged public var strGain: Float
  @NSManaged public var baseMana: Int16

}
