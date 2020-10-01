//
//  ViewController.swift
//  Trivia
//
//  Created by Sham Sundar on 01/10/20.
//  Copyright © 2020 sham. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var user = ""
    var games = [String]()
    
    @IBOutlet var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToHistory(_ sender: Any) {
        historyClicked()
    }
    
    @IBAction func goToQuestOne(_ sender: Any) {
        user = nameTF.text!
        if(user.count > 0){
            performSegue(withIdentifier: "toQuestionOne", sender: nil)
        }else{
            alert(msg: "Name is empty")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestionOne" {
            let questOneVC = segue.destination as! QuestOneController
            questOneVC.userName = user
        }
        if segue.identifier == "toHistory" {
            let historyVC = segue.destination as! HistoryController
            historyVC.games = games
        }
    }
    
    @objc func getData() {
        games.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trivia")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    var summary = ""
                    if let id = result.value(forKey: "id") as? UUID {
                        print(id)
                    }
                    if let datetime = result.value(forKey: "datetime") as? String {
                        print(datetime)
                        summary = "Game : " + datetime
                    }
                    
                    if let name = result.value(forKey: "name") as? String {
                        print(name)
                        summary += "\n\nName :" + name
                    }
                    
                    if let firstAnswer = result.value(forKey: "cricketer") as? String {
                        print(firstAnswer)
                        summary += "\n\nWho is the best cricketer in the world? \nAnswer:" + firstAnswer
                    }
                    
                    if let secondAnswer = result.value(forKey: "colors") as? String {
                        print(secondAnswer)
                        summary += "\n\nWhat are the colors in the national flag? \nAnswer:" + secondAnswer
                    }
                    games.append(summary)
                    print(summary)
                }
                performSegue(withIdentifier: "toHistory", sender: nil)
            }else{
                alert(msg: "No History Found!")
            }
            
        } catch {
            print("error")
        }
        
    }
    
    @objc func historyClicked(){
        getData()
    }
    
    func alert(msg:String)  {
        let alert = UIAlertController(title: "Error!", message: msg, preferredStyle: UIAlertController.Style.alert)
        let okbtn = UIAlertAction(title: "OK", style: .default) 
        alert.addAction(okbtn)
        self.present(alert, animated: true, completion: nil)
    }
}

