//
//  ApiManager.swift
//  ProficiencyExercise
//
//  Created by ajeet sharma on 09/12/17.
//  Copyright © 2017 Ajeet Sharma. All rights reserved.
//

import UIKit

typealias ServiceResponse = (ApiResponseData?, NSError?) -> Void

class ApiManager {
    
    func callRestApiToFetchDetails(onCompletion: @escaping ServiceResponse) {
        
        
        URLSession.shared.dataTask(with: URL(string: Constants.ApiURL)!) { (data, response, error) in
            
            if error == nil{
                
                onCompletion(self.parseData(data: data!)!, error as NSError?)
                
            }
            else{
                
                onCompletion(nil, error as NSError?)
                
            }
            
            }.resume()
        
        
        
    }
    
    func parseData(data:Data) -> ApiResponseData?{
        
        
        if let d: Data = data {
            if let value = String.init(data: d, encoding: String.Encoding.ascii) {
                
                if let jsonData = value.data(using: String.Encoding.utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! NSDictionary
                        
                        let responseData = ApiResponseData()
                        
                        var listItemArray = [ListItemData]()
                        
                        
                        
                        if let title = json.value(forKey: "title") as? String {
                            
                            
                            responseData.title = title
                        }
                        
                        if let arr = json.value(forKey: "rows") as? [NSDictionary] {
                            
                            
                            for dictionary in arr{
                                
                                // print("\(dictionary)")
                                
                                let testingDict:NSDictionary = dictionary
                                let listItem = ListItemData()
                                
                                if let titleAjit = testingDict.value(forKey: "title") as? String{
                                    
                                    listItem.title = titleAjit
                                    
                                }
                                if let detailAjit = testingDict.value(forKey: "description") as? String{
                                    
                                    listItem.detail = detailAjit
                                    
                                }
                                if let imageURLAjit = testingDict.value(forKey: "imageHref") as? String{
                                    
                                    listItem.imageUrl = imageURLAjit
                                    
                                }
                                
                                listItemArray.append(listItem)
                                
                            }
                            
                            responseData.list = listItemArray
                            return responseData
                        }
                        
                    } catch {
                        NSLog("ERROR \(error.localizedDescription)")
                        
                        return nil
                    }
                }
            }
            
        }
        
        return nil
    }
    
}


