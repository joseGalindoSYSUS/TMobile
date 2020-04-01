//
//  UserModel.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 31/03/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModel: Mappable {
    
    var login             : String?
    var id                : Int = 1
    var nodeId            : String?
    var avatarUrl         : String?
    var gravatarId        : String?
    var htmlUrl           : String?
    var mUrl              : String?
    var followerUrl       : String?
    var followingUrl      : String?
    var gistUrl           : String?
    var starredUrl        : String?
    var subscriptionUrl   : String?
    var organizationsUrl  : String?
    var reposUrl          : String?
    var eventsUrl         : String?
    var receivedEventsUrl : String?
    var type              : String?
    var siteAdmin         : Bool = false
    // This is optional
    var name              : String?
    var company           : String?
    var blog              : String?
    var location          : String?
    var email             : String?
    var hireable          : Bool = false
    var bio               : String?
    var publicRepos       : Int = 0
    var publicGist        : Int = 0
    var followers         : Int = 0
    var following         : Int = 0
    var createdAt         : String?
    var updatedAt         : String?
    
    let dFormat = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss", locale: "en_US")
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        login      <- map["login"]
        id         <- map["id"]
        nodeId     <- map["node_id"]
        avatarUrl  <- map["avatar_url"]
        gravatarId <- map["gravatar_url"]
        mUrl       <- map["url"]
        htmlUrl    <- map["html_url"]
        followerUrl <- map["followers_url"]
        followingUrl <- map["following_url"]
        gistUrl      <- map["gist_url"]
        starredUrl   <- map["starred_url"]
        subscriptionUrl  <- map["subscriptions_url"]
        organizationsUrl <- map["organizations_url"]
        reposUrl         <- map["repos_url"]
        eventsUrl        <- map["events_url"]
        receivedEventsUrl <- map["received_events_url"]
        type              <- map["type"]
        siteAdmin         <- map["site_admin"]
        name              <- map["name"]
        company           <- map["company"]
        blog              <- map["blog"]
        location          <- map["location"]
        email             <- map["email"]
        hireable          <- map["hireable"]
        bio               <- map["bio"]
        publicRepos       <- map["public_repos"]
        publicGist        <- map["public_gist"]
        followers         <- map["followers"]
        following         <- map["following"]
        createdAt         <- map["created_at"]
        updatedAt         <- map["updated_at"]
    }
    
    func describing() -> String {
        var description: String = ""
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
    

}
