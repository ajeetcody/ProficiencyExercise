//
//  ViewController.swift
//  ProficiencyExercise
//
//  Created by ajeet sharma on 08/12/17.
//  Copyright © 2017 Ajeet Sharma. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate{
    
    var myTableView: UITableView!
    var apiManager:ApiManager = ApiManager()
    var titleHeader:String?
    var itemListArray:[ListItemData] = []
    var loadingIndicator:LoadingIndicator = LoadingIndicator()
    var cellHeightArray:[CGFloat] = []
    
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
        
        myTableView.estimatedRowHeight = 100
        
        
        
        apiManager.callRestApiToFetchDetails(onCompletion: {(responseData:ApiResponseData?, error:NSError?) -> Void in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Message", message: "Operation Failed!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.loadingIndicator.hideActivityIndicator(uiView: self.view)
                print("Error: \(error?.description)")
                
                
            }
            else{
                
                if let response:ApiResponseData = responseData {
                    
                    self.itemListArray = (response.list)
                    self.title = responseData?.title
                    
                    DispatchQueue.main.async {
                        
                        self.calculateCellsHeight()
                        
                        
                        self.myTableView.reloadData()
                        self.loadingIndicator.hideActivityIndicator(uiView: self.view)
                        
                    }
                }
            }
        })
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.cellHeightArray.removeAll()
        self.calculateCellsHeight()
        
        // code to handle rotation details
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func heightForView(text:String, font:UIFont) -> CGFloat{
        
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 90 , height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func calculateCellsHeight(){
        
        for test:ListItemData in itemListArray{
            
            var titleH: CGFloat
            var descrH: CGFloat
            
            titleH = heightForView(text: test.title, font: Constants.TitleFont)
            descrH = heightForView(text: test.detail, font: Constants.TitleFont)
            
            
            if (titleH + descrH) < 120.0 {
                
                
                self.cellHeightArray.append(120.0)
            }
            else{
                
                self.cellHeightArray.append(titleH + descrH)
            }
            
            
            
        }
        
        
        
    }
    
    
}


extension ViewController: UITableViewDataSource{
    @available(iOS 2.0, *)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCellImageList = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCellImageList
        
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
        
        
        
        
        return cellHeightArray[indexPath.row]
        
    }
    
    
}


