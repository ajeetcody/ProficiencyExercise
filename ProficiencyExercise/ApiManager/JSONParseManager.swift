//
//  JSONParseManager.swift
//  ProficiencyExercise
//
//  Created by ajeet sharma on 11/12/17.
//  Copyright © 2017 Ajeet Sharma. All rights reserved.
//

import UIKit

class JSONParseManager {
    
    
    class  func parseData(data:Data) -> ApiResponseData?{
        
        
            if let value = String.init(data: data, encoding: String.Encoding.ascii) {
                
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
            
        
        return nil
    }
    
    
}
