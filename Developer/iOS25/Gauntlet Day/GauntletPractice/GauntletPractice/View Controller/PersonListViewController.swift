//
//  PersonListViewController.swift
//  GauntletPractice
//
//  Created by Colin Smith on 4/14/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PersonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell else {return UITableViewCell()}
        let person = PersonController.shared.people[indexPath.row]
        cell.person = person
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

       mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? PersonDetailViewController
        guard let chosenCell = mainTableView.indexPathForSelectedRow else {return}
        let person = PersonController.shared.people[chosenCell.row]
        destinationVC?.person = person
        
    }
    

}
