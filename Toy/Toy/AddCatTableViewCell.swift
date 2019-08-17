//
//  AddCatTableViewCell.swift
//  Toy
//
//  Created by Yesheng Chen on 8/16/19.
//  Copyright © 2019 Yesheng Chen. All rights reserved.
//

import UIKit
var age : Int = -1
var name : String = ""
var type : String = ""
class AddCatTableViewCell: UITableViewCell, UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate {
    var addCatViewController : AddCatViewController? 
    
    @IBOutlet weak var TextView: UITextView!
    
    @IBOutlet weak var PickerView: UIPickerView!
    func canSubmit() -> Bool {
        return age != -1 && name != "" && type != ""
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        PickerView.delegate = self
        PickerView.dataSource = self
        TextView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Picker View Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        age = row
        // reload the second section in table view
        addCatViewController?.TableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        if (canSubmit()){
            addCatViewController?.DoneButton.isEnabled = true
        }
    }
    
    //MARK: - Text View Methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.textColor == UIColor.gray){
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (textView.tag == 0){
            name = textView.text
        }else {
            type = textView.text
        }
        if (canSubmit()){
            addCatViewController?.DoneButton.isEnabled = true
        }else {
            addCatViewController?.DoneButton.isEnabled = false
    }
    }
    
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == ""){
            if (textView.tag == 0){
                textView.text = "Name"
            }else {
                textView.text = "Type"
            }
            textView.textColor = UIColor.gray
        }
    }
    
    
    
    
}
