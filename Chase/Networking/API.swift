//
//  API.swift
//  Chase
//
//  Created by Shingade on 4/19/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit
import Unbox

let SCHOOL_INFO_URL = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
let SCHOOL_SAT_URL = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
let SCHOOL_SAT_SCHOOL_NAME_URL = "https://data.cityofnewyork.us/resource/734v-jeq5.json?dbn="

class API: NSObject {
    
    static var shared = API.init()
    var urlSession:URLSession {
        let config = URLSessionConfiguration.default
        return URLSession.init(configuration: config)
    }
    
    func parseData(data:Data, onSuccess success: @escaping ([SchoolDetails]) -> Void, onFailure failure: @escaping (Error?) -> Void) {
        var model = [SchoolDetails]()
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let jsonArray = jsonObject as? [Any] {
                for item in jsonArray {
                    if let jsonDict = item as? [String:Any] {
                        let schoolModel:SchoolDetails = try unbox(dictionary: jsonDict)
                        model.append(schoolModel)
                    }
                }
            }
        } catch let error {
            return failure(error)
        }

        success(model)
    }
    
    func parseSATData(data:Data, onSuccess success: @escaping (SchoolSATScores) -> Void, onFailure failure: @escaping (Error?) -> Void) {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let jsonArray = jsonObject as? [Any] {
                if jsonArray.count > 0 {
                    if let jsonDict = jsonArray[0] as? [String:Any] {
                        let schoolSAT:SchoolSATScores = try unbox(dictionary:jsonDict)
                        success(schoolSAT)
                    }
                }
                else{
                    failure(ParseError.parsingError)
                }
            }
        } catch {
            failure(JSONError.jsonError)
        }
        
        failure(JSONError.jsonError)
    }
    
    func fetchSchoolInfo(onSuccess success: @escaping ([SchoolDetails]) -> Void, onFailure failure: @escaping (Error?) -> Void) {
        guard let url=URL.init(string: SCHOOL_INFO_URL) else {
            return failure(ParseError.parsingError)
        }
        
        let request = URLRequest.init(url: url)
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else  {
                return failure(JSONError.jsonError)
            }
            
            self.parseData(data: data, onSuccess: { (schoolDetails) in
                success(schoolDetails)
            }, onFailure: { (error) in failure(error) })
        }
        task.resume()
    }
    
    func fetchSatScores(forSchoolID: String, onSuccess success: @escaping (SchoolSATScores) -> Void, onFailure failure: @escaping (Error?) -> Void) {
        var sURL = SCHOOL_SAT_SCHOOL_NAME_URL
        if let encodeSchoolName = forSchoolID.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            sURL.append(encodeSchoolName)
        }
        
        guard let url=URL.init(string: sURL) else {
            return failure(ParseError.parsingError)
        }
        
        let request = URLRequest.init(url: url)
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else  {
                return failure(JSONError.jsonError)
            }
            self.parseSATData(data: data, onSuccess: { (schoolSAT) in
                success(schoolSAT)
            }, onFailure: { (error) in
                failure(error)
            })
        }
        task.resume()
    }

}
