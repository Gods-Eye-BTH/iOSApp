//
//  ViewController.swift
//  video stream
//
//  Created by Erik Westerberg on 2018-10-03.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieURL:NSURL? = NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")
        
        
        if let url = movieURL {
            self.avPlayer = AVPlayer(url: url as URL)
            self.avPlayerViewController.player = self.avPlayer
        }
        
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        //trigger the video to play
        self.present(self.avPlayerViewController, animated: true, completion: {() -> Void in self.avPlayerViewController.player?.play()})
    }
    
}

