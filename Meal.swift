//
//  Meal.swift
//  Foodtracker
//
//  Created by Hemita Pathak on 07/06/16.
//  Copyright © 2016 InformationWorks. All rights reserved.
//

import UIKit

class meal : NSObject, NSCoding {
    
    //MARK : Properties
    
    var name : String
    var photo : UIImage?
    var ratings : Int
    
    //MARK : Types
    
    struct propertyKey {
        
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingsKey = "ratings"
        
        
    }

    
    //MARK : Initialization
    
    init?(name : String , photo : UIImage? , ratings : Int) {
        
    //Intitialization stored properties
        
     self.name = name
     self.photo = photo
     self.ratings = ratings
        
     super.init()
        
    //Initialization should fail if there is no name or rating is negative.
        
        if name.isEmpty || ratings < 0 {
            
            return nil
        }
        
    }
    
    //MARK : Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    
    //MARK : NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
      aCoder.encodeObject(name, forKey: propertyKey.nameKey)
      aCoder.encodeObject(photo, forKey: propertyKey.photoKey)
      aCoder.encodeObject(ratings, forKey: propertyKey.ratingsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
       
        let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as! String
        
        //Photo is optional property of meal so use conditonal cast.
        let photo = aDecoder.decodeObjectForKey(propertyKey.photoKey) as? UIImage
        
        let ratings = aDecoder.decodeObjectForKey(propertyKey.ratingsKey) as! Int
        
        //Must call designated intilizers.
        
        self.init(name : name , photo: photo , ratings: ratings)
    }
}
    
    


