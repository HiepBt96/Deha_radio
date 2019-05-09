//
//  ItemSong_TableViewCell.swift
//  Deha_Radio
//
//  Created by Bui The Hiep on 4/25/19.
//  Copyright © 2019 BuiTheHiep. All rights reserved.
//

import UIKit

class ItemSong_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgSong: UIImageView!
    @IBOutlet weak var txtSongname: UILabel!
    @IBOutlet weak var txtDescrible: UILabel!
    @IBOutlet weak var imgPlayed: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
