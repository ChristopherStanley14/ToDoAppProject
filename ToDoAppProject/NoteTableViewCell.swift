//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Christopher Stanley on 10/18/16.
//  Copyright © 2016 Christopher Stanley. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteTitleLable: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
    
    weak var note: Note!
    
    var isCompleted: Bool = false
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ note: Note) {
        isCompleted = note.completed
        self.note  = note
        noteTitleLable.text = note.title
        noteTextLabel.text = note.text
        noteDateLabel.text = note.dueDate
        
        
    }
    
    

}
