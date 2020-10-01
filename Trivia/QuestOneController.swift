//
//  QuestOneController.swift
//  Trivia
//
//  Created by Sham Sundar on 01/10/20.
//  Copyright © 2020 sham. All rights reserved.
//

import UIKit

class QuestOneController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var userName = ""
    var firstAnswer = ""
    @IBOutlet var optionsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userName)
        optionsTV.delegate = self
        optionsTV.dataSource = self
    }
    
    @IBAction func goToquestionTwo(_ sender: Any) {
        if firstAnswer.count > 0 {
            performSegue(withIdentifier: "questTwo", sender: nil)
        }else{
            alert()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questTwo" {
            let questTwoVC = segue.destination as! QuestTwoController
            questTwoVC.userName = userName
            questTwoVC.firstAnswer = firstAnswer
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Sachin Tendulkar"
                break
            case 1:
                cell.textLabel?.text = "Virat Kohli"
                break
            case 2:
                cell.textLabel?.text = "Adam GilChrist"
                break
            case 3:
                cell.textLabel?.text = "Jacques Kallis"
                break
            default:
                break
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch indexPath.row {
            case 0:
                self.firstAnswer = "Sachin Tendulkar"
                break
            case 1:
                self.firstAnswer = "Virat Kohli"
                break
            case 2:
                self.firstAnswer = "Adam GilChrist"
                break
            case 3:
                self.firstAnswer = "Jacques Kallis"
                break
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func alert()  {
        let alert = UIAlertController(title: "Error!", message: "Select Atleast one to continue", preferredStyle: UIAlertController.Style.alert)
        let okbtn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okbtn)
        self.present(alert, animated: true, completion: nil)
    }
}
