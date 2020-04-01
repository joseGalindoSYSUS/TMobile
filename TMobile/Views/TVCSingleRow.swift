//
//  TVCSingleRow.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 31/03/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import Nuke

class TVCSingleRow: UITableViewCell {

    static let REUSE_IDENTIFIER = "SingleRow_ReuseIdentifier"
    static let SINGLE_ROW_HEIGTH : CGFloat = 60
    
    // UI
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var repos: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(_ userm : UserModel) {
        name.text = userm.login!
        repos.text = "Repos: \(userm.publicRepos)"
        
        guard let _ = userm.avatarUrl else {
            return
        }
        let imgUrl = URL(string: userm.avatarUrl!)!
        Nuke.loadImage(with: imgUrl, into: mImage)
    }
    
}
