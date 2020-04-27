//
//  StatisticsViewController.swift
//  CGreeneSalesTrack
//
//  Created by Christopher Greene on 4/25/20.
//  Copyright © 2020 Christopher Greene. All rights reserved.
//

import UIKit

var items: [Items] = []
let priceFormatter = NumberFormatter()

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var totalItemsLabel: UILabel!
    
    @IBOutlet weak var totalValueLabel: UILabel!
    
    @IBOutlet weak var averagePriceLabel: UILabel!
    
    @IBOutlet weak var averageValueLabel: UILabel!
    
    @IBOutlet weak var roiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalItemsLabel.text = String(itemCount)
        totalValueLabel.text = "$\(totalValue)"
        averagePriceLabel.text = "$\((averageCost*100).rounded()/100)"
        averageValueLabel.text = "$\((averageValue*100).rounded()/100)"
        roiLabel.text = "\((roi*10000).rounded() / 100)%"
        
    }
    
}
