//
//  ResultTableViewCell.swift
//  ImdbList
//
//  Created by Danilo on 05/05/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    func setup(title:String, url: String) {
        lbTitle.text = title
        if let url = URL(string: url){
            ivMovie.kf.indicatorType = .activity
            ivMovie.kf.setImage(with: url)
        } else {
            ivMovie.image = nil
        }
        ivMovie.layer.cornerRadius = ivMovie.frame.size.width / 4
        ivMovie.layer.masksToBounds = true
        ivMovie.layer.borderColor = UIColor.gray.cgColor
        ivMovie.layer.borderWidth = 1
    }
}
