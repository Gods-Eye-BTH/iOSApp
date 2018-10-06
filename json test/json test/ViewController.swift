//
//  ViewController.swift
//  json test
//
//  Created by Erik Westerberg on 2018-10-01.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct MyGitHub: Codable {
        
        let name: String?
        let location: String?
        let followers: Int?
        let avatarUrl: URL?
        let repos: Int?
        
        private enum CodingKeys: String, CodingKey {
            case name
            case location
            case followers
            case repos = "public_repos"
            case avatarUrl = "avatar_url"
            
        }
    }
    
    func jsonTest() {
        guard let gitUrl = URL(string: "https://api.github.com/users/shashikant86") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(MyGitHub.self, from: data)
                print(gitData.name)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func button1(_ sender: UIButton) {
        jsonTest()
    }
    



}

