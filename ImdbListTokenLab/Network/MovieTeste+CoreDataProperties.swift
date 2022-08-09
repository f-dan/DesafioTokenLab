//
//  MovieTeste+CoreDataProperties.swift
//  
//
//  Created by Victor de Paula on 07/08/22.
//
//

import Foundation
import CoreData


extension MovieTeste {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieTeste> {
        return NSFetchRequest<MovieTeste>(entityName: "MovieTeste")
    }

    @NSManaged public var teste: String?

}
