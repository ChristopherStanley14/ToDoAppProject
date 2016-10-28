//
//  NoteStore.swift
//  Notes
//
//  Created by Christopher Stanley on 10/19/16.
//  Copyright © 2016 Christopher Stanley. All rights reserved.
//

import UIKit

class NoteStore {
    static let shared = NoteStore()
    
    fileprivate var notes: [[Note]]!
    var note = Note()
    
    var selectedImage: UIImage?
    
    init() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            notes = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [[Note]]
        } else {
            notes = [[], [], []]
            notes[0].append(Note(title: "Note 1", text: "note1"))
            notes[1].append(Note(title: "Note 2", text: "note2"))
            notes[2].append(Note(title: "Note 3", text: "note3"))
            save()
            
        }
        
        sort()
        
        
    }
    
    
    
    // MARK: - Public functions
    
    func getNote(_ index: Int, catagory: Int) -> Note {
      
        return notes[catagory][index]
    }
    
    func addNote(_ note: Note, catagory: Int) {
        notes[catagory].insert(note, at: 0)
    }
    
    func addCompletedNote(_ note: Note, catagory: Int) {
        notes[catagory].insert(note, at: 0)
    }
    
    func updateNote(_ note: Note, index: Int, catagory: Int) {
        notes[catagory][index] = note
    }
    
    func deleteNote(_ index: Int, catagory: Int) {
        notes[catagory].remove(at: index)
    }
    
    func getCount(catagory: Int) -> Int? {
        return notes[catagory].count
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(notes, toFile: archiveFilePath())
    }
    
    func sort() {
        //        notes.sort { (note1, note2) -> Bool in
        //            return note1.date.compare(note2.date) == .orderedDescending
        //        }
        
        for i in 0..<notes.count {
            notes[i].sort(by: { (note1, note2) -> Bool in
                return note1.priority < note2.priority
            })
        }
    }
    
    // MARK: - Private Functinos
    fileprivate func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("NoteStore.plist")
        return path
    }
    
    
    
    
    
}
