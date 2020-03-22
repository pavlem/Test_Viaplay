//  TestViaplay
//
//  Created by Pavle Mijatovic on 19/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation
import UIKit

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

let reachability = Reachability()!

class WebClient {
    
    private var baseUrl: String
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func load(path: String, method: RequestMethod, params: JSON?, headers: HTTPHeaders? = nil, isUrlComponentsUsed: Bool? = true, completion: @escaping (Any?, Data?, ServiceError?) -> Void) -> URLSessionDataTask? {
        
        guard ReachabilityHelper.shared.reachability.connection != .none else {
            completion(nil, nil, ServiceError.noInternetConnection)
            return nil
        }
                
        let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params, headers: headers, isUrlComponentsUsed: isUrlComponentsUsed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.logResponse(data: data, httpResponse: response, error: error)
            
            var object: Any?
            
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                completion(object, data, nil)
            } else if let httpResponse = response as? HTTPURLResponse, (400..<500) ~= httpResponse.statusCode {
                completion(object, data, ServiceError.serverHostnameNotAvailable)
            } else {
                completion(nil, nil, ServiceError.other)
            }
        }
        
        request.log()

        task.resume()
        return task
    }
}

extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON?, headers: HTTPHeaders? = nil, isUrlComponentsUsed: Bool? = true) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method, isUrlComponentsUsed: isUrlComponentsUsed)
        self.init(url: url)
        httpMethod = method.rawValue
        
//        setValue("application/json", forHTTPHeaderField: "Accept")
//        setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if headers != nil {
            for (key, value) in headers! {
                setValue(value, forHTTPHeaderField: key)
            }
        }
        
        switch method {
        case .post, .put, .patch:
            guard let params = params else { break }
            do {
                let dataForBody = try JSONSerialization.data(withJSONObject: params, options: [])
                httpBody = dataForBody
            } catch {
            }

        default:
            break
        }
    }
}

extension URL {
    init(baseUrl: String, path: String, params: JSON?, method: RequestMethod, isUrlComponentsUsed: Bool? = true) {
        
        guard isUrlComponentsUsed == true else { // This part is meant if we want to override the the URLComponents builder down below
            let url = URL(string: baseUrl + path)!
            self = url
            return
        }
        
        var components = URLComponents(string: baseUrl)!
        components.path += path
        
        switch method {
        case .get, .delete:
            guard let params = params else { break }
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }
        
        print(components.url!)
        self = components.url!
    }
}

extension WebClient {
    
    func logResponseString(data: Data?, httpResponse: URLResponse?, error: Error?) -> String {
        var txt = ""
        txt.append("⏪⏪⏪⏪⏪⏪⏪\n")
        txt.append("data: \n\(String(describing: data))\n")
        txt.append("response: \n\(String(describing: httpResponse))\n")
        
        txt.append("error: \n\(String(describing: error))\n")
        if let data = data {
            txt.append((data.prettyPrintedJSONString as String? ?? ""))
            txt.append("\n")
        } else {
            txt.append("⏪⏪⏪⏪⏪⏪⏪\n")
        }
        return txt
    }
    
    func logResponse(data: Data?, httpResponse: URLResponse?, error: Error?) {
        print("⏪⏪⏪⏪⏪⏪⏪")
        print("data: \n\(String(describing: data))\n")
        print("response: \n\(String(describing: httpResponse))\n")
        print("error: \n\(String(describing: error))\n")
        
        guard let data = data else {
            print("⏪⏪⏪⏪⏪⏪⏪")
            return
        }
        
        print(data.prettyPrintedJSONString ?? "")
        print("⏪⏪⏪⏪⏪⏪⏪")
    }
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

extension URLRequest {
    func log() {
        print(self.logReqString)
    }
    
    var logReqString: String {
        var txt = ""
        txt.append("⏩⏩⏩⏩⏩⏩⏩\n")
        txt.append("METHOD: \(httpMethod ?? "")\n")
        txt.append("URL: \(self)\n")
        if let body = httpBody {
            txt.append("BODY: \n \(body.toString() ?? "")\n")
        } else {
            txt.append("BODY: None\n")
        }
        txt.append("HEADERS: \n \(allHTTPHeaderFields ?? ["": ""])\n")
        txt.append("URL: \(self)\n")
        txt.append("⏩⏩⏩⏩⏩⏩⏩\n")
        return txt
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { // NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
