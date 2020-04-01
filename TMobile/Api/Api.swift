//
//  Api.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 31/03/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Api: NSObject {
    
    public typealias APIRequestCompleteSuccessClosure = (_ anyObject : Any?) -> Void
    public typealias APIRequestCompleteFailureClosure = (_ reason : Any?) -> Void
    
    //EndPoints
    private let kAPI_USERS = "/users"
    
    // Properties
    private var sessionManager : Alamofire.SessionManager
    
    static let shared : Api = {
        let lock = NSRecursiveLock()
        lock.lock()
        let instance = Api()
        lock.unlock()
        return instance
    }()
    
    private override init() {
        self.sessionManager = Alamofire.SessionManager.default
    }
    
    
    /// Get the users from GitHub
    /// - Parameters:
    ///   - lastId: the last id seen in the list
    ///   - successBlock: if the request was successfully the success block will bring
    ///   a list of users
    ///   - failBlock: If something's wrong, an error will be thrown
    func getUsers(_ lastId : Int,
                  onSuccess successBlock : @escaping APIRequestCompleteSuccessClosure,
                  onFailure failBlock : @escaping APIRequestCompleteFailureClosure) {
        let mUrl = URL(string: "\(Constants.URL_BASE)\(kAPI_USERS)")!
        let params = ["since" : lastId]
        self.sessionManager.request(mUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"]).responseArray { (response : DataResponse<[UserModel]>) in
                switch response.result {
                case .success:
                    successBlock(response.result.value)
                    break
                case .failure(let mError):
                    failBlock(mError)
                    break
                }
        }
    }
    
    
    /// get a single user from GitHub
    /// - Parameters:
    ///   - user: the login's id user
    ///   - successBlock: if the request was successfully the success block will bring
    ///   the user information
    ///   - failBlock: If something's wrong, an error will be thrown
    func getUser(_ user : String,
                 onSuccess successBlock : @escaping APIRequestCompleteSuccessClosure,
                 onFailure failBlock : @escaping APIRequestCompleteFailureClosure) {
        let mUrl = URL(string: "\(Constants.URL_BASE)\(kAPI_USERS)/\(user)")!
        self.sessionManager.request(mUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseObject { (response : DataResponse<UserModel>) in
                switch response.result {
                case .success:
                    successBlock(response.result.value)
                    break
                case .failure(let mError):
                    failBlock(mError)
                    break
                }
        }
    }
    
    
    /// For every single user, we can get all his repositories
    /// - Parameters:
    ///   - path: The complete path for the repos
    ///   - successBlock: if the request was successfully the success block will bring
    ///   a list of repositories that belongs to user
    ///   - failureBlock: If something's wrong, an error will be thrown
    func getRepos(_ path : String,
                  onSuccess successBlock : @escaping APIRequestCompleteSuccessClosure,
                  onFailure failureBlock : @escaping APIRequestCompleteFailureClosure) {
        let mUrl = URL(string: path)!
        self.sessionManager.request(mUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseArray { (response : DataResponse<[RepositoryModel]>) in
                switch response.result {
                case .success:
                    successBlock(response.result.value)
                    break
                case .failure(let mError):
                    failureBlock(mError)
                    break
                }
        }
    }

}
