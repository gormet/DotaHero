//
//  CodingUserInfoKey+Util.swift
//  CodableCoredata
//
//  Created by Nithin Kumar on 01/04/2020.
//  Copyright © 2020 Nithin Kumar. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
