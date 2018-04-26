//
//  ViewController.swift
//  FaceTriggerExample
//
//  Created by Shawn Polson on 4/15/18.
//  Copyright © 2018 Sapols. All rights reserved.
//

import UIKit
import FaceTrigger

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var faceTrigger: FaceTrigger?
    var assignmentVC: AssignmentViewController!
    var browUpSelection: String!
    var browDownSelection: String!
    var winkLeftSelection: String!
    var winkRightSelection: String!
    var smileSelection: String!
    var frownSelection: String!
    var jawLeftSelection: String!
    var jawRightSelection: String!
    var jawOpenSelection: String!
    var cheekPuffSelection: String!

    @IBOutlet var previewContainer: UIView!
    //@IBOutlet var logTextView: UITextView!
    @IBOutlet var switchToggle: UISwitch!
    @IBOutlet weak var invertToggle: UISwitch!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperTextField: UITextField!
    
    let picker1Options = ["Option1", "Option2", "Option3", "Option4", "Option5"]
    let picker2Options = ["Choice1", "Choice2", "Choice3", "Choice4", "Choice5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        //logTextView.text = nil
        
        switchToggle.onTintColor = UIColor.cyan
        switchToggle.setOn(false, animated: false)
        
        invertToggle.setOn(false, animated: false)
        
        stepper.value = 0.0
        stepper.wraps = false
        stepper.autorepeat = true
        stepper.minimumValue = -1000.0
        stepper.maximumValue = 1000.0
        stepperTextField.text = String(Int(stepper.value))
        
        slider1.minimumValue = 0
        slider1.maximumValue = 100
        slider1.setValue(50, animated: true)
        
        slider2.minimumValue = 0
        slider2.maximumValue = 100
        slider2.setValue(50, animated: true)
        
        let barViewControllers = self.tabBarController?.viewControllers
        assignmentVC = barViewControllers![0] as! AssignmentViewController // the gesture assignment tab
        
        NotificationCenter.default.addObserver(self, selector: #selector(pause), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unpause), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker1Options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker1Options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //lbl.text = pickerOptions[row] //TODO: add label to show picker selection
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        faceTrigger = FaceTrigger(hostView: previewContainer, delegate: self)
        faceTrigger?.start()
    }
    
    //Gets called each time this tab opens
    //Store the user's selections from the Assign Gestures tab
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        browUpSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewBrowUp.selectedRow(inComponent: 0)]
        browDownSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewBrowDown.selectedRow(inComponent: 0)]
        winkLeftSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewBlinkLeft.selectedRow(inComponent: 0)]
        winkRightSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewBlinkRight.selectedRow(inComponent: 0)]
        smileSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewSmile.selectedRow(inComponent: 0)]
        frownSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewFrown.selectedRow(inComponent: 0)]
        jawLeftSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewJawLeft.selectedRow(inComponent: 0)]
        jawRightSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewJawRight.selectedRow(inComponent: 0)]
        jawOpenSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewJawOpen.selectedRow(inComponent: 0)]
        cheekPuffSelection = assignmentVC.busyBoxOptions[assignmentVC.pickerViewCheekPuff.selectedRow(inComponent: 0)]
    }
    
    @objc private func pause() {
        faceTrigger?.pause()
    }
    
    @objc private func unpause() {
        faceTrigger?.unpause()
    }
    
    // If the switch is toggled on, toggle it off (and vice versa)
    private func flipSwitchToggle() {
        DispatchQueue.main.async {
            let on = self.switchToggle.isOn
            if (on) {
                self.switchToggle.setOn(false, animated: true)
            }
            else {
                self.switchToggle.setOn(true, animated: true)
            }
        }
    }
    
    // If the invert is toggled on, toggle it off (and vice versa)
    private func flipInvertToggle() {
        DispatchQueue.main.async {
            let on = self.invertToggle.isOn
            if (on) {
                self.invertToggle.setOn(false, animated: true)
            }
            else {
                self.invertToggle.setOn(true, animated: true)
            }
        }
    }
    
    // Set the selected segment index to "left"
    private func selectSegmentLeft(inverted: Bool) {
        DispatchQueue.main.async {
            let left = 0
            let right = 1
            
            if (inverted) {
                self.segmentedControl.selectedSegmentIndex = right
            } else {
                self.segmentedControl.selectedSegmentIndex = left
            }
        }
    }
    
    // Set the selected segment index to "right"
    private func selectSegmentRight(inverted: Bool) {
        DispatchQueue.main.async {
            let left = 0
            let right = 1
            
            if (inverted) {
                self.segmentedControl.selectedSegmentIndex = left
            } else {
                self.segmentedControl.selectedSegmentIndex = right
            }
        }
    }
    
    // Increment the stepper value
    private func incrementStepperAndTextField() {
        DispatchQueue.main.async {
            let newStepperValue = Int(self.stepper.value) + 1
            self.stepper.value = Double(newStepperValue)
            
            self.stepperTextField.text = String(newStepperValue)
        }
    }
    
    // Decrement the stepper value
    private func decrementStepperAndTextField() {
        DispatchQueue.main.async {
            let newStepperValue = Int(self.stepper.value) - 1
            self.stepper.value = Double(newStepperValue)
            
            self.stepperTextField.text = String(newStepperValue)
        }
    }
    
    // Increment the first slider's value
    private func incrementFirstSlider(num: Int) {
        DispatchQueue.main.async {
            let newValue = self.slider1.value + Float(num)
            self.slider1.setValue(newValue, animated: true)
        }
    }
    
    // Decrement the first slider's value
    private func decrementFirstSlider(num: Int) {
        DispatchQueue.main.async {
            let newValue = self.slider1.value - Float(num)
            self.slider1.setValue(newValue, animated: true)
        }
    }
    
    // Increment the second slider's value
    private func incrementSecondSlider(num: Int) {
        DispatchQueue.main.async {
            let newValue = self.slider2.value + Float(num)
            self.slider2.setValue(newValue, animated: true)
        }
    }
    
    // Decrement the first slider's value
    private func decrementSecondSlider(num: Int) {
        DispatchQueue.main.async {
            let newValue = self.slider2.value - Float(num)
            self.slider2.setValue(newValue, animated: true)
        }
    }
    
    // Decrement the first picker view's row
    private func decrementFirstPickerView() {
        DispatchQueue.main.async {
            let selectedRow = self.pickerView1.selectedRow(inComponent: 0)
            if (!(selectedRow <= 0)) {
                let nextRow = selectedRow - 1
                self.pickerView1.selectRow(nextRow, inComponent: 0, animated: true)
            }
        }
    }
    
    // Increment the first picker view's row
    private func incrementFirstPickerView() {
        DispatchQueue.main.async {
            let selectedRow = self.pickerView1.selectedRow(inComponent: 0)
            if (!(selectedRow > self.picker1Options.count)) {
                let nextRow = selectedRow + 1
                self.pickerView1.selectRow(nextRow, inComponent: 0, animated: true)
            }
        }
    }
    
    // Decrement the second picker view's row
    private func decrementSecondPickerView() {
        DispatchQueue.main.async {
            let selectedRow = self.pickerView2.selectedRow(inComponent: 0)
            if (!(selectedRow <= 0)) {
                let nextRow = selectedRow - 1
                self.pickerView2.selectRow(nextRow, inComponent: 0, animated: true)
            }
        }
    }
    
    // Increment the second picker view's row
    private func incrementSecondPickerView() {
        DispatchQueue.main.async {
            let selectedRow = self.pickerView2.selectedRow(inComponent: 0)
            if (!(selectedRow > self.picker2Options.count)) {
                let nextRow = selectedRow + 1
                self.pickerView2.selectRow(nextRow, inComponent: 0, animated: true)
            }
        }
    }
    
    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        stepperTextField.text = Int(stepper.value).description
    }
    
    func doSelectedAction(whichAction: String) {
        if (whichAction == "Picker View Up")  {
            decrementFirstPickerView()
            decrementSecondPickerView()
        }
        else if (whichAction == "Picker View Down")  {
            incrementFirstPickerView()
            incrementSecondPickerView()
        }
        else if (whichAction == "Slider Left") {
            decrementFirstSlider(num: 5)
            decrementSecondSlider(num: 5)
        }
        else if (whichAction == "Slider Right") {
            incrementFirstSlider(num: 5)
            incrementSecondSlider(num: 5)
        }
        else if (whichAction == "Stepper Increment") {
            incrementStepperAndTextField()
        }
        else if (whichAction == "Stepper Decrement") {
            decrementStepperAndTextField()
        }
        else if (whichAction == "Segment Left") {
            selectSegmentLeft(inverted: invertToggle.isOn)
        }
        else if (whichAction == "Segment Right") {
            selectSegmentRight(inverted: invertToggle.isOn)
        }
        else if (whichAction == "Invert Segments") {
            flipInvertToggle()
        }
        else if (whichAction == "Toggle Switch") {
            flipSwitchToggle()
        }
    }
    
    // Try to continually increment a slider
    //    private func continuallyIncrementSlider(increment: Bool) {
    //        DispatchQueue.main.async {
    //            while (increment) {
    //                let newValue = self.slider1.value + Float(2)
    //                self.slider1.setValue(newValue, animated: true)
    //                sleep(1)
    //            }
    //        }
    //    }
    
    //    private func updateLog(_ eventText: String) {
    //
    //        DispatchQueue.main.async {
    //            let currentText = self.logTextView.text ?? ""
    //            self.logTextView.text = "\(eventText)\n\n\(currentText)"
    //        }
    //    }
    
    //    @IBAction func clearLogAction() {
    //        logTextView.text = nil
    //    }
    
}

extension ViewController: FaceTriggerDelegate {
    
    //----onGesture Events----------------------------------------------
    
    func onSmile() {
        doSelectedAction(whichAction: smileSelection)
    }
    
    func onFrown() {
        doSelectedAction(whichAction: frownSelection)
    }
    
    func onBlinkLeft() {
        doSelectedAction(whichAction: winkLeftSelection)
    }
    
    func onBlinkRight() {
        doSelectedAction(whichAction: winkRightSelection)
    }

    func onBrowDown() {
        doSelectedAction(whichAction: browDownSelection)
    }
    
    func onBrowUp() {
        doSelectedAction(whichAction: browUpSelection)
    }
    
    func onCheekPuff() {
        doSelectedAction(whichAction: cheekPuffSelection)
    }
    
    func onJawOpen() {
        doSelectedAction(whichAction: jawOpenSelection)
    }
    
    func onJawLeft() {
        doSelectedAction(whichAction: jawLeftSelection)
    }
    
    func onJawRight() {
        doSelectedAction(whichAction: jawRightSelection)
    }
    
    //    func onMouthPucker() {
    //        //updateLog("mouth pucker")
    //    }
    
    //    func onBlink() {
    //        updateLog("blink")
    //    }
    
    //    func onSquint() {
    //        updateLog("squint")
    //    }
    
    //----onDidChange Events--------------------------------------------
    
    // smile
//    func onSmileDidChange(smiling: Bool) {
//        updateLog("onSmileDidChange \(smiling)")
//    }
    
    // frown
//        func onFrownDidChange(frowning: Bool) {
//            updateLog("onFrownDidChange \(frowning)")
//        }
    
    // blink left
//    func onBlinkLeftDidChange(blinkingLeft: Bool) {
//        updateLog("onBlinkLeftDidChange \(blinkingLeft)")
//    }
    
    //blink right
//    func onBlinkRightDidChange(blinkingRight: Bool) {
//        //updateLog("onBlinkRightDidChange \(blinkingRight)")
//        continuallyIncrementSlider(increment: blinkingRight)
//    }
    
    // blink
//    func onBlinkDidChange(blinking: Bool) {
//        updateLog("onBlinkDidChange \(blinking)")
//    }
    
    // brow down
//    func onBrowDownDidChange(browDown: Bool) {
//        updateLog("onBrowDownDidChange \(browDown)")
//    }
    
    // brow up
//    func onBrowUpDidChange(browUp: Bool) {
//        updateLog("onBrowUpDidChange \(browUp)")
//    }
    
    // cheek puff
//    func onCheekPuffDidChange(cheekPuffing: Bool) {
//        updateLog("onCheekPuffDidChange \(cheekPuffing)")
//    }
    
    // mouth pucker
//    func onMouthPuckerDidChange(mouthPuckering: Bool) {
//        updateLog("onMouthPuckerDidChange \(mouthPuckering)")
//    }
    
    // jaw open
//    func onJawOpenDidChange(jawOpening: Bool) {
//        updateLog("onJawOpenDidChange \(jawOpening)")
//    }
    
    // jaw left
//    func onJawLeftDidChange(jawLefting: Bool) {
//        updateLog("onJawLeftDidChange \(jawLefting)")
//    }
    
    // jaw right
//    func onJawRightDidChange(jawRighting: Bool) {
//        updateLog("onJawRightDidChange \(jawRighting)")
//    }

    // squint
//    func onSquintDidChange(squinting: Bool) {
//        updateLog("onSquintDidChange \(squinting)")
//    }
    
}
