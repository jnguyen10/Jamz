//
//  ViewController.swift
//  Jamz
//
//  Created by Jimmy Nguyen on 1/28/16.
//  Copyright © 2016 Jimmy Nguyen. All rights reserved.
//

import UIKit
import Soundcloud
import Jukebox

class ViewController: UIViewController, JukeboxDelegate {
    
    var jukebox = Jukebox()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        
        // set variables to be passed into UserSearchHistory object
        let search_item = searchTextField.text!
        var artist: [String] = []
        var song_title: [String] = []
        var song_uri: [NSURL] = []
        
        // create the search query for Soundcloud
        let queries: [SearchQueryOptions] = [
            .QueryString(search_item)
        ]
        
        // perform the search from Soundcloud Track class
        Track.search(queries, completion: { (data) in
            if let search_data = data.response.result {
                for each in search_data {
                    // append artist name to an array of STRINGS
                    artist.append(String(each.createdBy.username))
                    
                    // append title name to an array of STRINGS
                    song_title.append(String(each.title))
                    
                    // unwrap and append all stream URIs to an array of NSURL
                    if let streamURI = each.streamURL {
                        song_uri.append(streamURI)
                    }
                }
            }
            
            // insdie the completion handler, create the USH object with the stored parameters
            let user_search = UserSearchHistory(item: search_item, artist: artist, title: song_title, song_uri: song_uri)
            
            // make query to save object into the database
            user_search.save()
            
            // perform a segue while passing the USH object
            self.performSegueWithIdentifier("PlayMusicFromSearchSegue", sender: user_search)
            

            
        })
        
        // reset the text field
        self.jukebox.stop()
        searchTextField.text = ""
    }
    
    @IBAction func userHistoryButtonPressed(sender: UIButton) {
        self.jukebox.stop()
    }
    @IBOutlet weak var gifView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load SC application credentials
        Soundcloud.clientIdentifier = "3a53fd6f7782b7d905659d90cc6523db"
        Soundcloud.clientSecret = "046102a59aedb7d0adf2b8f24622d4ae"
        Soundcloud.redirectURI = "jamzSC://callback"
        
        Track.track(179647213, completion: { data in
            if let streamURL = data.response.result?.streamURL {
                self.jukebox = Jukebox(delegate: self, items: [
                    JukeboxItem(URL: streamURL)
                    ])
                
                self.jukebox.play()
            }
        
        })
        
        
        // Create webView to play GIF on main page
        let filePath = NSBundle.mainBundle().pathForResource("kygo", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        gifView.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        gifView.userInteractionEnabled = false;
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Prepare the segue to pass data to the play music controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayMusicFromSearchSegue" {
            let controller = segue.destinationViewController as! PlayerViewController
            
            controller.requestToPlay = sender as? UserSearchHistory
            
        }
    }
    
    func jukeboxDidLoadItem(jukebox: Jukebox, item: JukeboxItem) {
        
    }
    
    func jukeboxPlaybackProgressDidChange(jukebox: Jukebox) {
        
    }
    
    func jukeboxStateDidChange(jukebox: Jukebox) {
        
    }


}

