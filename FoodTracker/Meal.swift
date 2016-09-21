//
//  Meal.swift
//  FoodTracker
//
//  Created by Colin Horsford on 9/18/16.
//  Copyright © 2016 Paerdegat. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    // MARK: Properties
    
    var name:  String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    
    //You mark these constants with the static keyword, which means they apply to the class instead of an instance of the class. Outside of the Meal class, you’ll access the path using the syntax Meal.ArchiveURL.path!.
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Types
    
    struct PropertyKey {
        
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
        
    }
    
    // MARK: Initialization
    
    //An initializer written like this is known as a failable initializer, which means that it’s possible for the initializer to return nil after initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecorder: NSCoder) {
        //The required keyword means this initializer must be implemented on every subclass of the class that defines this initializer.
        
        let name = aDecorder.decodeObjectForKey(PropertyKey.nameKey) as! String
        //The decodeObjectForKey(_:) method unarchives the stored information stored about an object.
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecorder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let rating = aDecorder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
}
