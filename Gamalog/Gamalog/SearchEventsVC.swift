//
//  SearchEventsVC.swift
//  Gamalog
//
//  Created by Ram on 6/4/17.
//  Copyright © 2017 Rowan Technologies. All rights reserved.
//

import UIKit

class SearchEventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventsSearchResultTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventsSearchResultTable.delegate = self
        self.eventsSearchResultTable.dataSource = self
        
        self.eventsSearchResultTable.tableFooterView = UIView(frame: .zero)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

