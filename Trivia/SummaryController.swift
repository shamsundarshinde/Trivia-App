//
//  SummaryController.swift
//  Trivia
//
//  Created by Sham Sundar on 01/10/20.
//  Copyright © 2020 sham. All rights reserved.
//

import UIKit
import CoreData

class SummaryController: UIViewController {

    var userName = ""
    var firstAnswer = ""
    var secondAnswer = ""
    var summary = ""
    @IBOutlet var summaryTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userName)
        print(firstAnswer)
        print(secondAnswer)
        summary = "Hello " + userName + "\n\nHere are the answers selected \n\nWho is the best cricketer in the world? \nAnswer:" + firstAnswer + "\n\nWhat are the colors in the national flag? \nAnswer:" + secondAnswer
        summaryTV.text = summary;
    }
    
    

    func getDateTime() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM h:mm a"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    @IBAction func finshedGame(_ sender: Any) {
        print("finish clicked")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let newGame = NSEntityDescription.insertNewObject(forEntityName: "Trivia", into: context)

        //Attributes
        newGame.setValue(UUID(), forKey: "id")
        newGame.setValue(userName, forKey: "name")
        newGame.setValue(firstAnswer, forKey: "cricketer")
        newGame.setValue(secondAnswer, forKey: "colors")
        newGame.setValue(getDateTime(), forKey: "datetime")


        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        print("finish ended")
        performSegue(withIdentifier: "finishedGame", sender: nil)
    }
}
