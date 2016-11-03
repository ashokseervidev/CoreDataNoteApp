//
//  Note+CoreDataProperties.swift
//  NoteApp
//
//  Created by Ashok on 10/31/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var title: String?
    @NSManaged public var subTitle: String?

}
