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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView = UITableView()
        myTableView.dataSource = self
        myTableView.delegate = self
    
        

        
        myTableView.separatorColor = UIColor.clear
        myTableView.register(CustomCellImageList.self, forCellReuseIdentifier: "cell")

        
        self.view.addSubview(myTableView)
        myTableView.autoPinEdgesToSuperviewEdges()

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}


extension ViewController: UITableViewDataSource{
    @available(iOS 2.0, *)
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCellImageList = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCellImageList
        
        cell.img.sd_setImage(with: URL(string:Constants.TestImageURL), completed: nil)
        
        cell.labelTitle.text = Constants.TestTitleString
        cell.labelDescription.text = Constants.TestDescriptionString
        return cell
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
    
    
    
}

extension ViewController: UITabBarDelegate{
    
    
    
    
}
