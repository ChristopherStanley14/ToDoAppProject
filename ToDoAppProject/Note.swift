//
//  Note.swift
//  Notes
//
//  Created by Christopher Stanley on 10/18/16.
//  Copyright © 2016 Christopher Stanley. All rights reserved.
//

import UIKit
import Foundation

class Note: NSObject, NSCoding {
    
    var title = ""
    var text = ""
    var date = Date()
    var dueDate = ""
    var completed = false
    var image: UIImage?
    var catagory: Int = 0
    var priority: Double = 0.0
    
    let titleKey = "title"
    let textKey = "text"
    let dateKey = "date"
    let dueDateKey = "dueDate"
    let completedKey = "completed"
    let imageKey = "image"
    let catagoryKey = "catagory"
    let priorityKey = "priority"
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy h:mm a"
        return dateFormatter.string(from: date)
    }
    
    
    
    
    
    override init() {
        super.init()
    }
    
    init(title: String, text: String, completed: Bool = false) {
        self.title = title
        self.text = text
        self.completed = completed
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
        self.text = aDecoder.decodeObject(forKey: textKey) as! String
        self.date = aDecoder.decodeObject(forKey: dateKey) as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
        self.dueDate = aDecoder.decodeObject(forKey: dueDateKey) as! String
        self.completed = aDecoder.decodeBool(forKey: completedKey)
        self.catagory = aDecoder.decodeInteger(forKey: catagoryKey)
        self.priority = aDecoder.decodeDouble(forKey: priorityKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(dueDate, forKey: dueDateKey)
        aCoder.encode(completed, forKey: completedKey)
        aCoder.encode(catagory, forKey: catagoryKey)
        aCoder.encode(priority, forKey: priorityKey)
    }
    
}


