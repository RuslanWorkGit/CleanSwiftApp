//
//  CDCharacter+CoreDataProperties.swift
//  TestTaskCleanSwift
//
//  Created by Ruslan Liulka on 27.04.2025.
//
//

import Foundation
import CoreData


extension CDCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCharacter> {
        return NSFetchRequest<CDCharacter>(entityName: "CDCharacter")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var gender: String?
    @NSManaged public var image: Data?

}

extension CDCharacter : Identifiable {

}
