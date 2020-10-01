//
//  QuestTwoController.swift
//  Trivia
//
//  Created by Sham Sundar on 01/10/20.
//  Copyright © 2020 sham. All rights reserved.
//

import UIKit

class QuestTwoController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var userName = ""
    var firstAnswer = ""
    var secondAnswer = ""
    var selectedOptions = [Int: String]()
    
    @IBOutlet var multiSelectOptionsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userName)
        print(firstAnswer)
        multiSelectOptionsTV.delegate = self
        multiSelectOptionsTV.dataSource = self
        multiSelectOptionsTV.allowsMultipleSelection = true
    }
    @IBAction func nextSummary(_ sender: Any) {
        if secondAnswer.count > 0 {
            performSegue(withIdentifier: "goToSummary", sender: nil)
        }else{
            alert()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSummary" {
            let summaryVC = segue.destination as! SummaryController
            summaryVC.userName = userName
            summaryVC.firstAnswer = firstAnswer
            summaryVC.secondAnswer = secondAnswer
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "White"
                break
            case 1:
                cell.textLabel?.text = "Yellow"
                break
            case 2:
                cell.textLabel?.text = "Orange"
                break
            case 3:
                cell.textLabel?.text = "Green"
                break
            default:
                break
        }
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.addOptions(rowNumber: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectedOptions.removeValue(forKey: indexPath.row)
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        self.removeOptions()
    }
    
    func addOptions(rowNumber: Int) {
        if self.selectedOptions.count == 0 {
            self.secondAnswer = ""
        }else{
            self.secondAnswer += ", "
        }
        switch rowNumber {
            case 0:
                self.secondAnswer += "White"
                self.selectedOptions[0] = "White"
                break
            case 1:
                self.secondAnswer += "Yellow"
                self.selectedOptions[1] = "Yellow"
                break
            case 2:
                self.secondAnswer += "Orange"
                self.selectedOptions[2] = "Orange"
                break
            case 3:
                self.secondAnswer += "Green"
                self.selectedOptions[3] = "Green"
                break
            default:
                break
        }
    }
    
    func removeOptions() {
        self.secondAnswer = ""
        for (keyName,valueName) in self.selectedOptions {
            print("\(keyName) : \(valueName)")
            if self.secondAnswer.count > 0 {
                self.secondAnswer += ", "
            }
            self.secondAnswer += valueName
        }
    }
    
    func alert()  {
        let alert = UIAlertController(title: "Error!", message: "Select Atleast one to continue", preferredStyle: UIAlertController.Style.alert)
        let okbtn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okbtn)
        self.present(alert, animated: true, completion: nil)
    }
}
