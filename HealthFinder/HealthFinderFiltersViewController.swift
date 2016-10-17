//
//  HealthFinderFiltersViewController.swift
//  HealthFinder
//
//  Created by Jacqueline Lin on 10/17/16.
//  Copyright © 2016 CS96SI. All rights reserved.
//

import UIKit

// create a delegate which can call an update on the original HealthFinderViewController (the main VC) whenever a UI action is taken in filters
protocol HealthFinderFiltersDelegate {
    func filtersWereUpdated(gender: String, age: Int)
}

class HealthFinderFiltersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var filtersSwitch: UISwitch!
    @IBOutlet var filtersView: UIView!
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    @IBOutlet var agePickerView: UIPickerView!
    var delegate:HealthFinderFiltersDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        agePickerView.delegate = self
        agePickerView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 65
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }

    @IBAction func filtersDidChange(_ sender: AnyObject) {
        delegate?.filtersWereUpdated(gender: genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)!, age: agePickerView.selectedRow(inComponent: 0)) // pass in 0 to get the first column in the picker view (there is only 1 column anyways)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filtersDidChange(pickerView)
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if filtersSwitch.isOn {
            filtersView.isHidden = false
        } else {
            filtersView.isHidden = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
