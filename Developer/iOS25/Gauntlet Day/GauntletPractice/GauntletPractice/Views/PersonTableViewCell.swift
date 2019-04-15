//
//  PersonTableViewCell.swift
//  GauntletPractice
//
//  Created by Colin Smith on 4/14/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var person: Person? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews(){
        personImageView.image = person?.image
        nameLabel.text = person?.name
        titleLabel.text = person?.title
    }
}
