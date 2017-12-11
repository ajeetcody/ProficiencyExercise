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
                
                onCompletion(JSONParseManager.parseData(data: data!)!, error as NSError?)
                
            }
            else{
                
                onCompletion(nil, error as NSError?)
                
            }
            
            }.resume()
        
        
        
    }
    
    
}


