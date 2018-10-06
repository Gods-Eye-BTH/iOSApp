//
//  ViewController.swift
//  Video test
//
//  Created by Erik Westerberg on 2018-09-30.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    // För att spela en lokal video
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let path = Bundle.main.path(forResource: "Film 2017-10-30 kl. 19.42", ofType: "mov") else { return }
        
        let videoURL = URL(fileURLWithPath: path)
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    // --------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

