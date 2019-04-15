//
//  PersonDetailViewController.swift
//  GauntletPractice
//
//  Created by Colin Smith on 4/14/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bioTextLabel: UILabel!
    
    var person: Person?
        
    
    
    func updateViews(){
        nameLabel.text = person?.name
        titleLabel.text = person?.title
        profileImage.image = person?.image
        bioTextLabel.text = person?.bio
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLinkedInView"{
            guard let destinationVC = segue.destination as? LinkedInViewController,
             let profileTarget = person?.linkedIn else {return}
            destinationVC.profile = profileTarget
            
        }
    }
    

}
