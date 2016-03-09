//
//  Database.swift
//  Jamz
//
//  Created by Jimmy Nguyen on 1/28/16.
//  Copyright © 2016 Jimmy Nguyen. All rights reserved.
//

import Foundation

class Database {
    // get the full path to the Documents folder
    static func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    // get the full path to file of project
    static func dataFilePath(schema: String) -> String {
        return "\(Database.documentsDirectory())/\(schema)"
    }
    
    static func save(arrayOfObjects: [AnyObject], toSchema: String, forKey: String) {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(arrayOfObjects, forKey: "\(forKey)")
        archiver.finishEncoding()
        data.writeToFile(Database.dataFilePath(toSchema), atomically: true)
    }
    
}