//
//  HistoryController.swift
//  Trivia
//
//  Created by Sham Sundar on 01/10/20.
//  Copyright © 2020 sham. All rights reserved.
//

import UIKit

class HistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var games = [String]()
    
    @IBOutlet var historyTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTV.delegate = self
        historyTV.dataSource = self
        historyTV.sizeToFit()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyViewCellId", for: indexPath) as! HistoryCell
        cell.gameDataLbl.text = games[indexPath.row]
        return cell;
    }
    
    
}
