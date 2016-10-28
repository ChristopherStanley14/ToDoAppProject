
//  NoteDetailViewController.swift
//  Notes
//
//  Created by Christopher Stanley on 10/18/16.
//  Copyright © 2016 Christopher Stanley. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var catagoryLabel: UILabel!
    @IBOutlet weak var catagoryPicker: UIPickerView!
    
    @IBOutlet weak var completedSwitch: UISwitch!
    
    
    var array = ["Home", "Work", "Other"]
    var catagoryPick = 0
    
    
    @IBOutlet weak var lastModifiedDate: UILabel!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    
    var note = Note()
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        catagoryPick = row
        
        if (catagoryPick == 0) {
            catagoryLabel.text = "Home"
        } else if (catagoryPick == 1) {
            catagoryLabel.text = "Work"
        } else if (catagoryPick == 2) {
            catagoryLabel.text = "Other"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTitleField.text = note.title
        noteTextView.text = note.text
        lastModifiedDate.text = note.dateString
        dueDateLabel.text = note.dueDate
        catagoryPicker.delegate = self
        catagoryPicker.dataSource = self
        completedSwitch.isOn = note.completed
        
        
        if let image = note.image {
            imageView.image = image
            addGestureRecognizer()
        } else {
            imageView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage() {
        if let image = imageView.image {
            NoteStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        note.title = noteTitleField.text!
        note.text = noteTextView.text
        note.date = Date()
        note.image = imageView.image
        note.dueDate = dueDateLabel.text!
        note.catagory = catagoryPicker.selectedRow(inComponent: 0)
        note.completed = completedSwitch.isOn
    }
    
    
    // MARK: - IBActions
    
    
    @IBAction func save(_ sender: AnyObject) {
        if sender.tag == 0 {
            note.catagory = 0
        } else if sender.tag == 1 {
            note.catagory = 1
        } else if sender.tag == 2 {
            note.catagory = 2
        }
    }
    
    
    
    
    
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (action) in
            self.showPicker(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.showPicker(.photoLibrary)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E MM/dd/yy h:mm a"
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dueDateLabel.text = strDate
    }
    
    
}





extension NoteDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            imageView.image = resizedImage
            
            imageView.isHidden = false
            if gestureRecognizer != nil {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}


