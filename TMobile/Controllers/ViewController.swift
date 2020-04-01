//
//  ViewController.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 31/03/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UI
    @IBOutlet weak var mTableView: UITableView!
    var searchController = UISearchController()
    
    //
    lazy var usersDwnld = [UserModel]()
    lazy var filteredUsers = [UserModel]()
    var lastId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "GitHub Searcher"
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        
        let mNib = UINib.init(nibName: "TVCSingleRow", bundle: nil)
        self.mTableView.register(mNib, forCellReuseIdentifier: TVCSingleRow.REUSE_IDENTIFIER)
        
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.mTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        getExtraUsers()
    }

    
    /// Get the user 
    private func getExtraUsers() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view, animated: true)
        Api.shared.getUsers(lastId, onSuccess: { (succs) in
            if succs != nil {
                self.usersDwnld.append(contentsOf: (succs as! [UserModel]))
                self.mTableView.reloadData()
            }
            hud.dismiss()
        }) { (mError) in
            self.showErrorMessage("An Error occurred, please try later")
            hud.dismiss()
        }
    }
    
    // MARK :- UITableViewDelegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredUsers.count
        } else {
            return usersDwnld.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVCSingleRow.REUSE_IDENTIFIER, for: indexPath) as! TVCSingleRow
        
        if searchController.isActive {
            cell.configureCell(filteredUsers[indexPath.row])
        } else {
            cell.configureCell(usersDwnld[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TVCSingleRow.SINGLE_ROW_HEIGTH
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var userM : UserModel
        if searchController.isActive {
            searchController.setEditing(false, animated: false)
            searchController.dismiss(animated: false, completion: nil)
            userM = filteredUsers[indexPath.row]
        } else {
            userM = usersDwnld[indexPath.row]
        }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view, animated: true)
        Api.shared.getUser(userM.login!, onSuccess: { (succsRes) in
            guard let _ = succsRes else {
                return
            }
            hud.dismiss()
            self.performSegue(withIdentifier: "showDetail", sender: succsRes)
        }) { (mError) in
            hud.dismiss()
            self.showErrorMessage("An Error occurred, please try later")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == usersDwnld.count {
            lastId = usersDwnld.last!.id
            getExtraUsers()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UserDetailViewController
        vc.userSelected = (sender as? UserModel)
    }

}

extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredUsers.removeAll()
        filteredUsers.append(contentsOf: usersDwnld.filter { (usrm) -> Bool in
            return usrm.login!.contains(searchController.searchBar.text!.lowercased())
        })
        mTableView.reloadData()
    }
}

