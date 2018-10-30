//
//  VideoViewController.swift
//  InidiProjekt
//
//  Created by Erik Westerberg on 2018-10-12.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
//import Alamofire

struct Robot: Codable {
    let id: Int?
    let name: String?
    var x: Int?
    var y: Int?
    let width: Int?
    let heigth: Int?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case x
        case y
        case width
        case heigth
    }
}



struct MovementRequest: Codable {
    var id: Int?
    var direction: String?
}



class VideoViewController: UIViewController {

    var movieURL:NSURL? = NSURL(string: "test")
    var jsonURL:NSURL? = NSURL(string: "test")
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var robots = [Robot(id: 10, name: "test", x: 5, y: 6, width: 15, heigth: 51)]
    var jsonTimer: Timer!
    var userMadeChanges = false
    var selectedRobotId = -1 //om det ska användas i array, glöm inte - 1
    var urlArray: [String] = ["test"]
    var currentVideo: Int = -1
    
    @IBOutlet weak var videoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup table view
        self.robotTable.delegate = self
        self.robotTable.dataSource = self
        self.robotTable.rowHeight = 100
        getRobots()
        
        //setup player
        setupPlayer()
        
        
        
        //to update json every x seconds
        jsonTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateJson), userInfo: nil, repeats: true)
        }
    
    
    func setupPlayer() {
        player = AVPlayer(url: movieURL as! URL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    
    
    
    @IBOutlet weak var robotTable: UITableView!
  
    @IBAction func updateJsonButton(_ sender: UIButton) {
        getRobots()
        robotTable.reloadData()
    }
    
    @objc func updateJson() {
        if !userMadeChanges {
            getRobots()
        }
        robotTable.reloadData()
        userMadeChanges = false
    }
    
    
    
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBAction func playPause(_ sender: Any) {
        if (player.rate != 0 && player.error == nil) {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play.png"), for: .normal)
        } else {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
        }
        robotTable.reloadData()
    }
    

    
    func getRobots() {
        var stringURL = self.jsonURL!.absoluteString!
        let url = URL(string: stringURL)
        URLSession.shared.dataTask(with: url!) { [unowned self] (data, response, error) in
            guard let data = data else { return }
            do {
                self.robots = try JSONDecoder().decode([Robot].self, from: data)
                DispatchQueue.main.async {
                    print(self.robots.count)
                }
                
            } catch {
                print("Error is : \n\(error)")
            }
            }.resume()
    }
    
    func changePosition(robotId: Int, xOffset: Int, yOffset: Int ) {
        userMadeChanges = true
        var robotArrayIndex = -1
        
        for i in 0..<robots.count {
            if robots[i].id == robotId {
                robotArrayIndex = i
                break
            }
        }
        if robotArrayIndex != -1 {
            robots[robotArrayIndex].x = robots[robotArrayIndex].x! + xOffset
            robots[robotArrayIndex].y = robots[robotArrayIndex].y! + yOffset
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let buttonId = sender.tag
        var direction = ""
        
        switch buttonId {
        case 0:
            changePosition(robotId: selectedRobotId, xOffset: 0, yOffset: 1)
            direction = "up"
        case 1:
            changePosition(robotId: selectedRobotId, xOffset: 0, yOffset: -1)
            direction = "down"
        case 2:
            changePosition(robotId: selectedRobotId, xOffset: -1, yOffset: 0)
            direction = "left"
        case 3:
            changePosition(robotId: selectedRobotId, xOffset: 1, yOffset: 0)
            direction = "right"
        default:
            print("invalid tag id")
            return
        }
        
        // Struct to request robot to move
        let moveDirection = MovementRequest(id: buttonId, direction: direction)
        
        robotTable.reloadData()
    }
    
   
    @IBAction func idButtonPressed(_ sender: UIButton) {
        if selectedRobotId != sender.tag {
            selectedRobotId = sender.tag
        } else {
            selectedRobotId = -1
        }
    }
}



extension VideoViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in robotTable: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return robots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let robotArray = robots[indexPath.row]
        let cell = robotTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RobotCell
        cell.nameLabel.text = robotArray.name
        cell.xLabel.text = "x: \(robotArray.x!)"
        cell.yLabel.text = "y: \(robotArray.y!)"
        cell.widthLabel.text = "width: \(robotArray.width!)"
        cell.heigthLabel.text = "heigth: \(robotArray.heigth!)"
        cell.idButton.setTitle(String("ID: \(robotArray.id!)"), for: UIControl.State.normal)
        
        cell.idButton.tag = robotArray.id!
        cell.idButton.addTarget(self, action: #selector(idButtonPressed(_:)), for: .touchUpInside)
        
        if cell.idButton.tag == selectedRobotId {
            cell.idButton.backgroundColor = UIColor.yellow
        } else {
            cell.idButton.backgroundColor = UIColor.white
        }
        
        return cell;
    }
}
