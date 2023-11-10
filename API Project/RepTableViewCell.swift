//
//  RepTableViewCell.swift
//  API Project
//
//  Created by Tyler May on 11/9/23.
//

import UIKit

class RepTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    
    var repName: String? = nil {
        didSet {
            if oldValue != repName {
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    var repState: String? = nil {
        didSet {
            if oldValue != repState {
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    var repWebsite: String? = nil {
        didSet {
            if oldValue != repWebsite {
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    var repParty: String? = nil {
        didSet {
            if oldValue != repParty {
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        nameLabel.text = repName
        stateLabel.text = "\(repState ?? "") - \(repParty ?? "")"
        websiteLabel.text = repWebsite
    }
}
