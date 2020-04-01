//
//  TVCRepos.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 01/04/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class TVCRepos: UITableViewCell {

    static let REUSE_IDENTIFIER = "Repos_Identifier"
    
    // UI
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var forkLbl: UILabel!
    @IBOutlet weak var starsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ repo : RepositoryModel) {
        repoName.text = repo.name
        forkLbl.text = "\(repo.forks) Forks"
        starsLbl.text = "\(repo.stargazersCount) Stars"
    }
    
}
