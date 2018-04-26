//
//  AssignmentViewController.swift
//  FaceTriggerExample
//
//  Created by Shawn Polson on 4/15/18.
//  Copyright © 2018 Sapols. All rights reserved.
//

import UIKit
import FaceTrigger

class AssignmentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerViewBrowUp: UIPickerView!
    @IBOutlet weak var pickerViewBrowDown: UIPickerView!
    @IBOutlet weak var pickerViewBlinkLeft: UIPickerView!
    @IBOutlet weak var pickerViewBlinkRight: UIPickerView!
    @IBOutlet weak var pickerViewSmile: UIPickerView!
    @IBOutlet weak var pickerViewFrown: UIPickerView!
    @IBOutlet weak var pickerViewJawLeft: UIPickerView!
    @IBOutlet weak var pickerViewJawRight: UIPickerView!
    @IBOutlet weak var pickerViewJawOpen: UIPickerView!
    @IBOutlet weak var pickerViewCheekPuff: UIPickerView!
    
    let busyBoxOptions = ["Picker View Up", "Picker View Down", "Slider Left", "Slider Right", "Stepper Increment", "Stepper Decrement", "Segment Left", "Segment Right", "Invert Segments", "Toggle Switch"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewBrowUp.delegate = self
        pickerViewBrowUp.dataSource = self
        pickerViewBrowUp.selectRow(4, inComponent:0, animated:true)
        
        pickerViewBrowDown.delegate = self
        pickerViewBrowDown.dataSource = self
        pickerViewBrowDown.selectRow(5, inComponent:0, animated:true)
        
        pickerViewBlinkLeft.delegate = self
        pickerViewBlinkLeft.dataSource = self
        pickerViewBlinkLeft.selectRow(2, inComponent:0, animated:true)
        
        pickerViewBlinkRight.delegate = self
        pickerViewBlinkRight.dataSource = self
        pickerViewBlinkRight.selectRow(3, inComponent:0, animated:true)
        
        pickerViewSmile.delegate = self
        pickerViewSmile.dataSource = self
        pickerViewSmile.selectRow(0, inComponent:0, animated:true)
        
        pickerViewFrown.delegate = self
        pickerViewFrown.dataSource = self
        pickerViewFrown.selectRow(1, inComponent:0, animated:true)
        
        pickerViewJawLeft.delegate = self
        pickerViewJawLeft.dataSource = self
        pickerViewJawLeft.selectRow(6, inComponent:0, animated:true)
        
        pickerViewJawRight.delegate = self
        pickerViewJawRight.dataSource = self
        pickerViewJawRight.selectRow(7, inComponent:0, animated:true)
        
        pickerViewJawOpen.delegate = self
        pickerViewJawOpen.dataSource = self
        pickerViewJawOpen.selectRow(8, inComponent:0, animated:true)
        
        pickerViewCheekPuff.delegate = self
        pickerViewCheekPuff.dataSource = self
        pickerViewCheekPuff.selectRow(9, inComponent:0, animated:true)

        
        NotificationCenter.default.addObserver(self, selector: #selector(pause), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unpause), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    //Gets called each time this tab opens
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return busyBoxOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return busyBoxOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //lbl.text = pickerOptions[row] //TODO: add label to show picker selection
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 10)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = busyBoxOptions[row]
        //pickerLabel?.textColor = UIColor.blue
        
        return pickerLabel!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc private func pause() {
        //faceTrigger?.pause()
    }
    
    @objc private func unpause() {
        //faceTrigger?.unpause()
    }
    
    
}

