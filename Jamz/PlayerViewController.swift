//
//  PlayerViewController.swift
//  Jamz
//
//  Created by Jimmy Nguyen on 1/28/16.
//  Copyright © 2016 Jimmy Nguyen. All rights reserved.
//

import UIKit
import Jukebox


class PlayerViewController: UIViewController, JukeboxDelegate {
    
    var requestToPlay: UserSearchHistory?
    var jukebox = Jukebox()
    var playPausePressed = false
    
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if requestToPlay != nil {
            
            self.jukebox = Jukebox(delegate: self, items: [
                JukeboxItem(URL: requestToPlay!.song_uri[0] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[1] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[2] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[3] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[4] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[5] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[6] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[7] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[8] as! NSURL),
                JukeboxItem(URL: requestToPlay!.song_uri[9] as! NSURL)
                ])
            
            searchLabel.text = "Playing Tunes by \(requestToPlay!.item)"
            artistLabel.text = requestToPlay!.artist[0] as? String
            titleLabel.text = requestToPlay!.title[0] as? String
            print("########## song uri count", requestToPlay?.song_uri.count)
            
            
//            print(requestToPlay!.item)
//            print("-------------")
//            print(requestToPlay!.artist)
//            print("-------------")
//            print(requestToPlay!.title)
//            print("-------------")
//            print(requestToPlay!.song_uri)
//            print("-------------")
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func stopBtnPressed(sender: UIButton) {
        // Reset play/pause button to play after song has been stopped
        // Stop button resets the playlist to the first song in the array
        
        let play = UIImage(named: "playBtn.png")
        jukebox.stop()
        artistLabel.text = requestToPlay!.artist[0] as? String
        titleLabel.text = requestToPlay!.title[0] as? String
        playPauseBtnOutlet.setImage(play, forState: .Normal)
        playPausePressed = false
    }

    
    @IBOutlet weak var playPauseBtnOutlet: UIButton!
    @IBAction func playPauseBtnPressed(sender: UIButton) {
        // play/pause button changes button image based on boolean
        
        let play = UIImage(named: "playBtn.png")
        let pause = UIImage(named: "pauseBtn.png")
        if !playPausePressed {
            playPauseBtnOutlet.setImage(pause, forState: .Normal)
            jukebox.play()
            playPausePressed = true
        } else {
            playPauseBtnOutlet.setImage(play, forState: .Normal)
            jukebox.pause()
            playPausePressed = false
        }
    
        
        
    }
    
    @IBAction func nextBtnPressed(sender: UIButton) {
        // next button produces a random song in the jukebox array by index
        // artist and title changes concurrently with the song
        // play/pause button is changed to paused because next button auto-plays the next track
        
        let rand = arc4random_uniform(10)
        let pause = UIImage(named: "pauseBtn.png")
        
        jukebox.playAtIndex(Int(rand))
        artistLabel.text = requestToPlay!.artist[Int(rand)] as? String
        titleLabel.text = requestToPlay!.title[Int(rand)] as? String
        
        playPauseBtnOutlet.setImage(pause, forState: .Normal)
        playPausePressed = true
        
    }
    
    
    func jukeboxStateDidChange(jukebox: Jukebox) {
        
    }
    
    func jukeboxPlaybackProgressDidChange(jukebox: Jukebox) {
        
    }
    
    func jukeboxDidLoadItem(jukebox: Jukebox, item: JukeboxItem) {
        
    }
    

    
}
