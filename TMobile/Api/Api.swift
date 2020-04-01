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

}
