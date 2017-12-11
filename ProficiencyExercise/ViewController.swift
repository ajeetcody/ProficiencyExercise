//
//  ViewController.swift
//  ProficiencyExercise
//
//  Created by ajeet sharma on 08/12/17.
//  Copyright © 2017 Ajeet Sharma. All rights reserved.
//

import UIKit


class ViewController: MasterViewController, UITableViewDelegate{
    
    // MARK:- Variable declaration ------------
    
    var myTableView: UITableView!
    var apiManager:ApiManager = ApiManager()
    var titleHeader:String?
    var itemListArray:[ListItemData] = []
    var loadingIndicator:LoadingIndicator = LoadingIndicator()
    var cellHeightArray:[CGFloat] = []
    
    // MARK:- UIViewController lifecycle methods ------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor =  Constants.BackgroundColor
        self.addMyTableView()
        self.addRefreshButton()
        
        self.callAPI()
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.cellHeightArray.removeAll()
        self.calculateCellsHeight()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK:- Add UI element methods  -----------
    
    /*
     addRefreshButton:
     
    This method will add a refresh button on right side of navigationBar.
     
     */
    
    private func addRefreshButton(){
        
        let refreshButton = UIButton(type: .custom)
        refreshButton.setImage(UIImage(named: "RefreshButton"), for: .normal)
        refreshButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        refreshButton.addTarget(self, action: #selector(refreshButtonAction), for: .touchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem(customView: refreshButton)
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
    }
    
    
    
    private func addMyTableView(){
    
        myTableView = UITableView()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorColor = UIColor.clear
        myTableView.backgroundColor = .clear
        myTableView.estimatedRowHeight = 100
        myTableView.register(CustomCellImageList.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(myTableView)
        myTableView.autoPinEdgesToSuperviewEdges()
        
    }
    
    /*
     calculateCellsHeight:
     
    This method will create an array of cell heights after getting response. And we will use array 'cellHeightArray' to cell height of each cell.
     
     */
    
    private func calculateCellsHeight(){
        
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
    
    // MARK:- API calling method -----
    
    /*
     callAPI:
     
     This method is used to call api and show response/error.
     
     
     */
    
    private  func callAPI(){
        
        
        self.loadingIndicator.showActivityIndicator(uiView: self.view)
        
        apiManager.callRestApiToFetchDetails(onCompletion: {(responseData:ApiResponseData?, error:NSError?) -> Void in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Message", message: "Operation Failed!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                // self.loadingIndicator.hideActivityIndicator(uiView: self.view)
                print("Error: \(error?.description)")
                
                
            }
            else{
                
                if let response:ApiResponseData = responseData {
                    
                    self.itemListArray = (response.list)
                    self.title = responseData?.title
                    
                    DispatchQueue.main.async {
                        
                        self.title = responseData?.title

                        self.calculateCellsHeight()
                        self.myTableView.reloadData()
                        self.loadingIndicator.hideActivityIndicator(uiView: self.view)
                        
                    }
                }
            }
        })
        
    }
    
    
    
    // MARK:- UIButton action method --------------------
    
    
       func refreshButtonAction(sender:UIButton) {
        
        self.callAPI()
        
        
    }
    
    
    
    
}


// MARK:- UITableviewCell Datasource --------------------

extension ViewController: UITableViewDataSource{
    @available(iOS 2.0, *)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCellImageList = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCellImageList
        
        cell.img.sd_setImage(with: URL(string:(itemListArray[indexPath.row] ).imageUrl), placeholderImage: UIImage(named: "PlaceHolderImage.png"), options: .refreshCached , completed: nil)
        
        cell.titleLabel.text = (itemListArray[indexPath.row]).title
        cell.descriptionLabel.text = (itemListArray[indexPath.row]).detail

        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        return cellHeightArray[indexPath.row]
        
    }
    
    
}


