//
//  MainTableViewCell.swift
//  Test
//
//  Created by Gursewak singh on 04/09/20.
//  Copyright © 2020 Gursewak singh. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let shadowSize : CGFloat = 18.0
           let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                      y: -shadowSize / 2,
                                                      width: UIScreen.main.bounds.size.width - 32 + shadowSize,
                                                      height: UIScreen.main.bounds.size.height - 32 + shadowSize))
           self.view_main.layer.masksToBounds = false
           self.view_main.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6011773768)
           self.view_main.layer.shadowOffset = CGSize(width: 0, height: 0)
           self.view_main.layer.shadowOpacity = 0.08
           self.view_main.layer.shadowPath = shadowPath.cgPath
        
        
        self.lbl_title.font = UIFont(name: Font.regular, size:15.0)
        self.lbl_description.font = UIFont(name: Font.regular, size:14.0)
        self.lbl_date.font = UIFont(name: Font.regular, size:14.0)
        self.btn_edit.titleLabel?.font = UIFont(name: Font.regular, size:14.0)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
