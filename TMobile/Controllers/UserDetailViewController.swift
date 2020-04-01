//
//  UserDetailViewController.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 31/03/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import Nuke

class UserDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    // UI
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var usrNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var joinDateLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var followerLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var mTableView: UITableView!
    
    var searchController = UISearchController()
    
    //
    var userSelected : UserModel?
    lazy var repos = [RepositoryModel]()
    lazy var filterRepos = [RepositoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "GitHub Searcher"
        
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.mTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
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
        
        mTableView.dataSource = self
        mTableView.delegate = self
        let mNib = UINib.init(nibName: "TVCRepos", bundle: nil)
        mTableView.register(mNib, forCellReuseIdentifier: TVCRepos.REUSE_IDENTIFIER)
        
        Api.shared.getRepos(userSelected!.reposUrl!, onSuccess: { (succs) in
            guard let _ = succs else {
                return
            }
            self.repos.append(contentsOf: (succs as! [RepositoryModel]))
            self.mTableView.reloadData()
        }) { (merror) in
            
        }
    }

    // MARK: -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filterRepos.count
        } else {
            return repos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVCRepos.REUSE_IDENTIFIER, for: indexPath) as! TVCRepos
        
        if searchController.isActive {
            cell.configureCell(filterRepos[indexPath.row])
        } else {
            cell.configureCell(repos[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var repoSlctd : RepositoryModel
        if searchController.isActive {
            repoSlctd = filterRepos[indexPath.row]
        } else {
            repoSlctd = repos[indexPath.row]
        }
        let repoUrl = URL(string: repoSlctd.htmlRepo!)
        UIApplication.shared.open(repoUrl!, options: [:], completionHandler: nil)
    }
    
    // MARK: -
    func updateSearchResults(for searchController: UISearchController) {
        filterRepos.removeAll(keepingCapacity: false)
        filterRepos.append(contentsOf: repos.filter { (repo) -> Bool in
            return repo.name!.contains(searchController.searchBar.text!.lowercased())
        })
        mTableView.reloadData()
    }

}
