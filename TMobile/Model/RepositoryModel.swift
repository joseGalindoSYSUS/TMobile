//
//  RepositoryModel.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 01/04/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import ObjectMapper

class RepositoryModel: Mappable {
    
    var id : Int64?
    var nodeId : String?
    var name : String?
    var fullName : String?
    var privateRepo : Bool = false
    var htmlRepo : String?
    var size : Int = 0
    var stargazersCount : Int = 0
    var watcherCount : Int = 0
    var language : String?
    var hasIssues : Bool = false
    var hasProjects : Bool = false
    var hasDownloads : Bool = false
    var hasWiki : Bool = false
    var hasPages : Bool = false
    var forksCount : Int = 0
    var archived : Bool = false
    var disabled : Bool = false
    var openIssuesCount : Int = 0
    var forks : Int = 0
    var openIssues : Int = 0
    var watchers : Int = 0
    var defaultBranch : String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        nodeId  <- map["node_id"]
        name    <- map["name"]
        fullName  <- map["full_name"]
        privateRepo  <- map["private"]
        htmlRepo     <- map["html_url"]
        size         <- map["size"]
        stargazersCount  <- map["stargazers_count"]
        watcherCount     <- map["watchers_count"]
        language         <- map["language"]
        hasIssues        <- map["has_issues"]
        hasProjects      <- map["has_projects"]
        hasDownloads     <- map["has_downloads"]
        hasWiki          <- map["has_wiki"]
        hasPages         <- map["has_pages"]
        forksCount       <- map["foeks_count"]
        archived         <- map["archived"]
        disabled         <- map["disabled"]
        openIssuesCount  <- map["open_issues_count"]
        forks            <- map["forks"]
        openIssues       <- map["open_issues"]
        watchers         <- map["watchers"]
        defaultBranch    <- map["default_branch"]
    }
}
