//
//  UserDetailViewController.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 31/03/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import Nuke

class UserDetailViewController: UIViewController {
    
    // UI
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var usrNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var joinDateLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var followerLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    
    @IBOutlet weak var mSearchBar: UISearchBar!
    @IBOutlet weak var mTableView: UITableView!
    
    //
    var userSelected : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "GitHub Searcher"
        self.configureView()
    }
    
    private func configureView() {
        let urlImg = URL(string: userSelected!.avatarUrl!)
        let options = ImageLoadingOptions(placeholder: nil, transition: .fadeIn(duration: 0.2), failureImage: nil, failureImageTransition: nil, contentModes: .init(success: .scaleAspectFit, failure: .center, placeholder: .center))
        Nuke.loadImage(with: urlImg!, options: options, into: avatarImg, progress: nil, completion: nil)
        
        usrNameLbl.text = userSelected!.login ?? "No user name"
        emailLbl.text = userSelected!.email ?? "No email address"
        locationLbl.text = userSelected!.location ?? "No location"
        joinDateLbl.text = "\(userSelected!.createdAt!)"
        usrNameLbl.text = userSelected!.login ?? "No user name"
        followerLbl.text = "\(userSelected!.followers) Followers"
        followingLbl.text = "Following \(userSelected!.following)"
        
        
        if userSelected!.bio == nil {
            bioLbl.isHidden = true
        } else {
            bioLbl.text = userSelected!.bio
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
