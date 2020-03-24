//
//  SectionService.swift
//  TestViaplay
//
//  Created by Pavle Mijatovic on 20/03/2020.
//  Copyright © 2020 Pavle Mijatovic. All rights reserved.
//

import Foundation

class SectionsService: ContentServer {
    
    func getSections(completion: @escaping (SectionsResponse?, ServiceError?) -> Void) -> URLSessionDataTask? {
        
        return client.load(path: ServiceEndpoint.ios, method: .get, params: nil, headers: nil) { (jsonObject, data, serviceErr) in

            guard jsonObject != nil else {
                completion(nil, serviceErr)
                return
            }

            do {
                let sectionResponse = try JSONDecoder().decode(SectionsResponse.self, from: data!)
                completion(sectionResponse, serviceErr)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completion(nil, serviceErr)
            }
        }
    }
    
    
    func getSection(path: String, completion: @escaping (SectionResponse?, ServiceError?) -> Void) -> URLSessionDataTask? {
        
        return client.load(path: ServiceEndpoint.ios + path, method: .get, params: nil, headers: nil) { (jsonObject, data, serviceErr) in

            guard jsonObject != nil else {
                completion(nil, serviceErr)
                return
            }

            do {
                let sectionResponse = try JSONDecoder().decode(SectionResponse.self, from: data!)
                completion(sectionResponse, serviceErr)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completion(nil, serviceErr)
            }
        }
    }
    
}
