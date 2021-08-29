//
//  RadiusTableViewCell.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import UIKit

class RadiusTableViewCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setNameAndIcon(_ option : Option?){
        if let name = option?.name{
            nameLabel.text = name
            
        }
        if let isEnable = option?.isEnabled{
            nameLabel.textColor = isEnable ? .black : .gray
        }else{
            nameLabel.textColor = .black
        }
        if let icon  = option?.icon{
            iconImage.image = UIImage(imageLiteralResourceName: icon)
        }
    }
    
}
