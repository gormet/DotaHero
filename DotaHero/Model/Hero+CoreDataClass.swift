//
//  Hero+CoreDataClass.swift
//  DotaHero
//
//  Created by Septian on 9/17/20.
//  Copyright © 2020 Septian. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Hero)
public class Hero: NSManagedObject, Codable {
  
  enum CodingKeys: String, CodingKey {
    case id
    case name = "localized_name"
    case primaryAttribute = "primary_attr"
    case image = "img"
    case attackType = "attack_type"
    case roles
    case baseInt = "base_int"
    case baseStr = "base_str"
    case baseAgi = "base_agi"
    case intGain = "int_gain"
    case agiGain = "agi_gain"
    case strGain = "str_gain"
    case baseDamageMin = "base_attack_min"
    case baseDamageMax = "base_attack_max"
    case movementSpeed = "move_speed"
    case baseArmor = "base_armor"
    case baseMana = "base_mana"
  }
  
  required convenience public init(from decoder: Decoder) throws {
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
      let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
      let entity = NSEntityDescription.entity(forEntityName: "Hero", in: managedObjectContext) else {
        fatalError("Failed to decode User")
    }
    
    self.init(entity: entity, insertInto: managedObjectContext)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int16.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    primaryAttribute = try container.decode(String.self, forKey: .primaryAttribute)
    image = try container.decode(String.self, forKey: .image)
    attackType = try container.decode(String.self, forKey: .attackType)
    roles = try container.decode([String].self, forKey: .roles)
    baseInt = try container.decode(Int16.self, forKey: .baseInt)
    baseStr = try container.decode(Int16.self, forKey: .baseStr)
    baseAgi = try container.decode(Int16.self, forKey: .baseAgi)
    intGain = try container.decode(Float.self, forKey: .intGain)
    agiGain = try container.decode(Float.self, forKey: .agiGain)
    strGain = try container.decode(Float.self, forKey: .strGain)
    baseDamageMin = try container.decode(Int16.self, forKey: .baseDamageMin)
    baseDamageMax = try container.decode(Int16.self, forKey: .baseDamageMax)
    movementSpeed = try container.decode(Int16.self, forKey: .movementSpeed)
    baseArmor = try container.decode(Float.self, forKey: .baseArmor)
    baseMana = try container.decode(Int16.self, forKey: .baseMana)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(primaryAttribute, forKey: .primaryAttribute)
    try container.encode(image, forKey: .image)
    try container.encode(attackType, forKey: .attackType)
    try container.encode(baseInt, forKey: .baseInt)
    try container.encode(baseStr, forKey: .baseStr)
    try container.encode(baseAgi, forKey: .baseAgi)
    try container.encode(intGain, forKey: .intGain)
    try container.encode(agiGain, forKey: .agiGain)
    try container.encode(strGain, forKey: .strGain)
    try container.encode(roles, forKey: .roles)
    try container.encode(baseDamageMin, forKey: .baseDamageMin)
    try container.encode(baseDamageMax, forKey: .baseDamageMax)
    try container.encode(movementSpeed, forKey: .movementSpeed)
    try container.encode(baseArmor, forKey: .baseArmor)
    try container.encode(baseMana, forKey: .baseMana)
  }
  
}
