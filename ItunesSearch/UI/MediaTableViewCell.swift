//
//  MediaTableViewCell.swift
//  ItunesSearch
//
//  Created by Florian Praile on 30/08/2018.
//  Copyright © 2018 Underside. All rights reserved.
//

import UIKit
import AlamofireImage

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaNameLabel: UILabel!
    @IBOutlet weak var mediaInfoLabel: UILabel!
    
    var media: StoreItem?{
        didSet{
            guard let media = media else {
                return
            }
            
            
            
            self.mediaImageView.af_setImage(withURL: media.artworkURL, placeholderImage: #imageLiteral(resourceName: "Media PlaceHolder"))
            self.mediaNameLabel.text = media.name
            self.mediaInfoLabel.text = media.artist
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        self.contentView.layer.shadowOpacity = 0.7
        self.contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        self.mainContainerView.layer.masksToBounds = true
        self.mainContainerView.layer.cornerRadius = 4.0
        self.mainContainerView.layer.borderColor = UIColor.lightGray.cgColor
        self.mainContainerView.layer.borderWidth = 0.5
        
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        UIView.animate(withDuration: 0.5) {
            self.mainContainerView.backgroundColor = selected ? UIColor.lightGray : UIColor.white
            self.contentView.layer.shadowOpacity = selected ? 0.0 : 0.7
            self.mediaNameLabel.textColor = selected ? UIColor.white : UIColor.black
            self.mediaInfoLabel.textColor = selected ? UIColor.white : UIColor.black
        }
        
    }
    
    

}



