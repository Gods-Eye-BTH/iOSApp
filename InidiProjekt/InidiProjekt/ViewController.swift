//
//  ViewController.swift
//  InidiProjekt
//
//  Created by Erik Westerberg on 2018-10-05.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var movieURL:NSURL? = NSURL(string: "test")
    var jsonURL:NSURL? = NSURL(string: "test")
    var urlArray: [String] = ["https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8", "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"]
    var currentVideoIndex: Int = -1
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? VideoViewController {
            destinationViewController.movieURL = movieURL
            destinationViewController.jsonURL = jsonURL
            destinationViewController.urlArray = urlArray
            destinationViewController.currentVideo = currentVideoIndex
        }
    }
    
    @IBOutlet weak var connectionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlArray = readFromFileToArray(fileName: "connectionlist")
        
        //setup table view
        self.connectionTable.delegate = self
        self.connectionTable.dataSource = self
        self.connectionTable.rowHeight = 50
        
        jsonUrl.delegate = self
    }
    
    
    @IBOutlet weak var feedUrl: UITextField!
    @IBOutlet weak var jsonUrl: UITextField!
    @IBAction func feedConnect(_ sender: Any) {
        let url = feedUrl.text
        var json = jsonUrl.text
        
        if json! == "leave empty for localhost" || json! == "" {
            json = "http://localhost:3000/Robots"
        }
        
        movieURL = NSURL(string: url!)
        jsonURL = NSURL(string: json!)
        
        if !urlArray.contains(url!) {
            urlArray.append(url!)
        }
        
        writeArrayToFile(fileName: "connectionlist", urlArr: urlArray)
    }
    
    
    
    @IBAction func urlButtonPressed(_ sender: UIButton) {
        feedUrl.text = sender.titleLabel!.text
        currentVideoIndex = sender.tag
    }
    
    @IBAction func trashButtonPressed(_ sender: UIButton) {
        urlArray.remove(at: sender.tag)
        connectionTable.reloadData()
        writeArrayToFile(fileName: "connectionlist", urlArr: urlArray)
    }
    
    
    func textViewDidBeginEditing(jsonUrl: UITextField) {
        jsonUrl.text = ""
    }
    
    
    
    
    
    func readFromFileToArray(fileName: String) -> [String] {
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        var fileName = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        let urlArr = NSArray(contentsOf: fileName) as! [String]
        return urlArr
    }
    
    func writeArrayToFile(fileName: String, urlArr: [String]){
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        var fileName = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        (self.urlArray as NSArray).write(to: fileName, atomically: true)
    }

}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in robotTable: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let tempArray = urlArray[indexPath.row]
        let cell = connectionTable.dequeueReusableCell(withIdentifier: "connectionCell", for: indexPath) as! ConnectionCell
        cell.urlButton.setTitle(tempArray, for: UIControl.State.normal)
        cell.urlButton.addTarget(self, action: #selector(urlButtonPressed(_:)), for: .touchUpInside)
        cell.urlButton.tag = indexPath.row
        cell.trashButton.tag = indexPath.row
        
        return cell
    }
}
