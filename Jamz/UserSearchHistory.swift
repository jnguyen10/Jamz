//
//  UserSearchHistory.swift
//  Jamz
//
//  Created by Jimmy Nguyen on 1/28/16.
//  Copyright © 2016 Jimmy Nguyen. All rights reserved.
//

import Foundation


class UserSearchHistory: NSObject, NSCoding {
    //variable declaration
    static var key = "Search"
    static var schema = "JamzHistory"
    var item: String
    var artist: NSArray
    var title: NSArray
    var song_uri: NSArray
    var createdAt: NSDate
    //init method for new obj instances
    init (item: String, artist: NSArray, title: NSArray, song_uri: NSArray){
        self.item = item
        self.artist = artist
        self.title = title
        self.song_uri = song_uri
        createdAt = NSDate()
    }
    
    // MARK: - NSCoding Protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(item, forKey: "item")
        aCoder.encodeObject(artist, forKey: "artist")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(song_uri, forKey: "song_uri")
        aCoder.encodeObject(createdAt, forKey:  "createdAt")
    }
    
    // used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        item = aDecoder.decodeObjectForKey("item") as! String
        artist = aDecoder.decodeObjectForKey("artist") as! NSArray
        title = aDecoder.decodeObjectForKey("title") as! NSArray
        song_uri = aDecoder.decodeObjectForKey("song_uri") as! NSArray
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    
    
    static func all() -> [UserSearchHistory] {
        var searches = [UserSearchHistory]()
        let path = Database.dataFilePath(UserSearchHistory.schema)
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                searches = unarchiver.decodeObjectForKey(UserSearchHistory.key) as! [UserSearchHistory]
                unarchiver.finishDecoding()
            }
        }
        
        return searches
    }
    
    func save() {
        var searchesFromStorage = UserSearchHistory.all()
        var exists = false
        
        for var i = 0; i < searchesFromStorage.count; ++i {
            if searchesFromStorage[i].item == self.item {
                searchesFromStorage[i] = self
                exists = true
            }
        }
        
        if !exists {
            searchesFromStorage.append(self)
        }
        
        Database.save(searchesFromStorage, toSchema: UserSearchHistory.schema, forKey: UserSearchHistory.key)
        
    }
    
    func destroy() {
        var searchesFromStorage = UserSearchHistory.all()
        
        for var i = 0; i < searchesFromStorage.count; ++i {
            if searchesFromStorage[i].createdAt == self.createdAt {
                searchesFromStorage.removeAtIndex(i)
            }
        }
        
        Database.save(searchesFromStorage, toSchema: UserSearchHistory.schema, forKey: UserSearchHistory.key)
        
    }
    
    
    
    
}