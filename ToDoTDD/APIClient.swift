//
//  APIClient.swift
//  ToDoTDD
//
//  Created by Mac on 31.08.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import Foundation

enum WebserviceError : Error {
    case DataEmptyError, ResponseError
}
protocol ToDoURLSession {
    func dataTaskWithURL(url: URL,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
class APIClient{
    lazy var session: ToDoURLSession = URLSession.shared
    var keychainManager: KeychainAccessible?
    
    func loginUserWithName(username: String,
                           password: String,
                           completion: @escaping (Error?) -> Void) {
        
        let allowedCharacters = CharacterSet(charactersIn: "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let encodedUsername = username.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
            else {
                fatalError()
            }
        guard let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
            else {
                fatalError()
            }
        guard let url = URL(string: "https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)")
            else{
                fatalError()
            }
        
        let task = session.dataTaskWithURL(url: url) { (data, response, error) -> Void in
            if error != nil {
                completion(WebserviceError.ResponseError)
                return
            }
            if let data = data {
                do {
                    let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    let token = responseDict!["token"] as! String
                    self.keychainManager?.setPassword(password: token, account: "token")
                } catch{
                    completion(error)
                }
            } else {
                completion(WebserviceError.DataEmptyError)
            }
        }
        task.resume()
        
        
    }
    
}
extension URLSession : ToDoURLSession {
    func dataTaskWithURL(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTask()
    }
}
