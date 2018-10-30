//
//  globalVariables.swift
//  InidiProjekt
//
//  Created by Erik Westerberg on 2018-10-05.
//  Copyright © 2018 Erik Westerberg. All rights reserved.
//

import Foundation

var isConnected = false
var movieURL:NSURL? = NSURL(string: "test")


func readFromFile(fileName: String) -> String  {
    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
    
    var readString = ""
    do {
        readString = try String(contentsOf: fileURL)
    } catch {
        print("failed to read file")
    }
    
    return readString
}



func writeToFile(fileName: String, stringToWrite: String) {
    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
    
    print(fileURL.path)
    
    let writeString = stringToWrite
    do {
        try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
    } catch let error as NSError {
        print("failed to write to URL")
    }
}

func writeStringArrayToFile(filename: String, stringArray: [String]) {
    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = DocumentDirURL.appendingPathComponent(filename).appendingPathExtension("txt")
    (stringArray as NSArray).write(to: fileURL, atomically: true)
}







