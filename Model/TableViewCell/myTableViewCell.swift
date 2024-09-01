//
//  myTableViewCell.swift
//  Wisedomleaf
//
//  Created by Sai Prakash Birudaraju on 30/08/24.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var myTitle: UILabel!
    
    @IBOutlet weak var ReleaseDates: UILabel!
    
    @IBOutlet weak var heart: UIButton!
    @IBOutlet weak var Favorites: UILabel!
    
   
    
    var MovieArray : [Movie] = []
    var filteredMovies: [Movie] = []
    var isSearching = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func Heartbtn(_ sender: UIButton) {
        
        
        if heart.tag == 0
        {
            heart.setImage(UIImage(systemName: "heart" ), for: .normal)
            heart.tag = 1
        }
        else{
            heart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heart.tag = 0
        }
    }
}
