//
//  ViewController.swift
//  ProficiencyExercise
//
//  Created by ajeet sharma on 08/12/17.
//  Copyright © 2017 Ajeet Sharma. All rights reserved.
//

import UIKit
import SwiftSpinner


class ViewController: UIViewController, UITableViewDelegate{
    
    var myTableView: UITableView!
    var apiManager:ApiManager = ApiManager()
    var titleHeader:String?
    var itemListArray:[ListItemData] = []
    var loadingIndicator:LoadingIndicator = LoadingIndicator()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        myTableView = UITableView()
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.separatorColor = UIColor.clear
        myTableView.register(CustomCellImageList.self, forCellReuseIdentifier: "cell")
        
        
        self.view.addSubview(myTableView)
        myTableView.autoPinEdgesToSuperviewEdges()
        
        self.loadingIndicator.showActivityIndicator(uiView: self.view)
        
        
      //  SwiftSpinner.show("Fetching Data....")
        
        apiManager.callRestApiToFetchDetails(onCompletion: {(responseData:ApiResponseData?, error:NSError?) -> Void in
            
            
            if error != nil {
            
                
            //SwiftSpinner.hide()
              
                
                let alert = UIAlertController(title: "Message", message: "Operation Failed!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                print("Error: \(error?.description)")
                
              
            }
            else{
            
                if let response:ApiResponseData = responseData {
                
                        self.itemListArray = (response.list)
                    
                        print("\(responseData?.list)")
                        
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                            
                            self.loadingIndicator.hideActivityIndicator(uiView: self.view)
                            
                            
                            //SwiftSpinner.hide()
                        }
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
}


extension ViewController: UITableViewDataSource{
    @available(iOS 2.0, *)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCellImageList     = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCellImageList
        
        cell.img.sd_setImage(with: URL(string:(itemListArray[indexPath.row] ).imageUrl), placeholderImage: UIImage(named: "PlaceHolderImage.png"), options: .refreshCached , completed: nil)
        
        cell.labelTitle.text = (itemListArray[indexPath.row]).title
        cell.labelDescription.text = (itemListArray[indexPath.row]).detail
        
        
        return cell
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemListArray.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
    
    
}


