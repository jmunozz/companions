//
//  APIRequests.swift
//  swiftyCompanion
//
//  Created by Jordan MUNOZ on 1/22/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import Foundation

class APIRequests {
    
    let UID = "f0037ef8dbddebe72b11d00c4e4ff7e82d04cf2673865e1b24e6711e67bd8d4a"
    let SECRET = "c45dcb291945e84f0c620fa5cbbf7e2252fcccdd643968c109dfd690dc91ea32"
    let URL_BASE = "https://api.intra.42.fr"
    var TOKEN: String? = nil
    static private var API: APIRequests? = nil
    
    func authenticate() {
        if self.TOKEN == nil {
            let endpoint = "/oauth/token"
            guard let url = URL(string: URL_BASE + endpoint) else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = "grant_type=client_credentials&client_id=\(self.UID)&client_secret=\(self.SECRET)".data(using: String.Encoding.utf8)
            print(request)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                //Error has been thrown
                if let err = error {
                    print("Request Error: \(err)")
                    return
                }
                //Response code is invalid
                if let r = response {
                    let h = r as! HTTPURLResponse
                    if h.statusCode < 200 || h.statusCode >= 300 {
                        print("Status code is \(h.statusCode)")
                        return
                    }
                }
                //Data can be read
                if let d = data {
                    var decoded: Auth
                    do {
                        decoded = try JSONDecoder().decode(Auth.self, from: d);
                    } catch(let e) {
                        print("decodeFromJSON Error: \(e)");
                        return
                    }
                    print("Access Token received \(decoded.access_token)")
                    self.TOKEN = decoded.access_token
                }
            }.resume()
        }
    }
    
    func getUserByLogin(login: String, callback : @escaping (User?) -> Void) {
        if self.TOKEN == nil {
            print("Access Token not set...")
            return
        }
        
        let endpoint = "/v2/users"
        let querystring = "?filter[login]=\(login)"
        guard let url = URL(string: URL_BASE + endpoint + querystring) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(self.TOKEN!)", forHTTPHeaderField: "Authorization")
        print(urlRequest)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //Error has been thrown
            if let err = error {
                print("Request Error: \(err)")
                return
            }
            //Response code is invalid
            if let r = response {
                let h = r as! HTTPURLResponse
                if h.statusCode < 200 || h.statusCode >= 300 {
                    print("Status code is \(h.statusCode)")
                    if h.statusCode == 403 {
                        print("from here")
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 200000)) {                            self.getUserByLogin(login: login, callback: callback)
                        }
                    }
                    return
                }
            }
            //Data can be read
            if let d = data {
                var decoded: [User]
                do {
                    decoded = try JSONDecoder().decode([User].self, from: d);
                } catch(let e) {
                    print("decodeFromJSON Error: \(e)");
                    return
                }
                if decoded.count > 0 {
                    let user_id = decoded[0].id!
                    self.getUserById(id: user_id, callback: callback)
                } else {
                    callback(nil)
                }
            }
            }.resume()
    }
    
    func getUserById(id: Int, callback: @escaping (User?) -> Void) {
        if self.TOKEN == nil {
            print("Access Token not set...")
            return
        }
        
        let endpoint = "/v2/users/"
        guard let url = URL(string: URL_BASE + endpoint + String(id)) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(self.TOKEN!)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //Error has been thrown
            if let err = error {
                print("Request Error: \(err)")
                return
            }
            //Response code is invalid
            if let r = response {
                let h = r as! HTTPURLResponse
                if h.statusCode < 200 || h.statusCode >= 300 {
                    print("Status code is \(h.statusCode)")
                    if h.statusCode == 403 {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 200000)) {                            self.getUserById(id: id, callback: callback)
                        }
                    }
                    return
                }
            }
            //Data can be read
            if let d = data {
                var decoded: User
                do {
                    decoded = try JSONDecoder().decode(User.self, from: d);
                } catch(let e) {
                    print("decodeFromJSON Error: \(e)");
                    return
                }
                callback(decoded)
            }
            }.resume()
    }
    
    func getUserRangeByLogin(login: String, callback: @escaping ([User]?) -> Void) {
        if self.TOKEN == nil {
            print("Access Token not set...")
            return
        }
        
        let endpoint = "/v2/users"
        let querystring = "?range[login]=\(login),\(login)z"
        guard let url = URL(string: URL_BASE + endpoint + querystring) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(self.TOKEN!)", forHTTPHeaderField: "Authorization")
        print(urlRequest)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //Error has been thrown
            if let err = error {
                print("Request Error: \(err)")
                return
            }
            //Response code is invalid
            if let r = response {
                let h = r as! HTTPURLResponse
                if h.statusCode < 200 || h.statusCode >= 300 {
                    print("Status code is \(h.statusCode)")
                    if h.statusCode == 403 {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 200000)) {                            self.getUserRangeByLogin(login: login, callback: callback)
                        }
                    }
                    return
                }
            }
            //Data can be read
            if let d = data {
                var decoded: [User]
                do {
                    decoded = try JSONDecoder().decode([User].self, from: d);
                } catch(let e) {
                    print("decodeFromJSON Error: \(e)");
                    return
                }
                callback(decoded)
            }
            }.resume()
    }
    
    static func getAPIManager() -> APIRequests {
        if self.API == nil {
            self.API = APIRequests()
        }
        return self.API!
    }
}
