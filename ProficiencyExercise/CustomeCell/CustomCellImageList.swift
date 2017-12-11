//
//  CustomCellImageList.swift
//  ProficiencyExercise
//
//  Created by ajeet sharma on 08/12/17.
//  Copyright © 2017 Ajeet Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class CustomCellImageList: UITableViewCell {
    
    // MARK:- Variable Declaration -------
    
    
    var img     = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var seperatorLabel = UILabel()
    
    //MARK:- Default cell methods ---------
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setIntialValue()  // Call to set  initial value.
        
        
        self.addImage()
        self.addTitleLabel()
        self.addDescriptionLabel()
        self.addSeperatorLabel()
        
        
        self.setAutoLayoutConstraints()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK:- Method to set cell initial properties -------
    
    func setIntialValue(){
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.backgroundColor = .clear
        
    }
    
    // MARK:- Methods to add UI on cell -------
    
    func addImage(){
        
        img.layer.cornerRadius = 05.0
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 1.0
        img.clipsToBounds = true;
        contentView.addSubview(img)
        
        
    }
    
    func addTitleLabel(){
        
        titleLabel.font = Constants.TitleFont
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = UIColor.clear
        contentView.addSubview(titleLabel)
        
        
    }
    
    func addDescriptionLabel(){
        
        descriptionLabel.font = Constants.DescriptionFont
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.backgroundColor = UIColor.clear
        contentView.addSubview(descriptionLabel)
        
        
    }
    
    func addSeperatorLabel(){
        
        seperatorLabel.backgroundColor = UIColor.lightGray
        
        contentView.addSubview(seperatorLabel)
        
    }
    
    // MARK:- Method to set autolayout constraints -------
    
    
    func setAutoLayoutConstraints(){
        
        
        img.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        img.autoSetDimensions(to: CGSize.init(width: 80, height: 80))
        img.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        titleLabel.autoPinEdge(.left, to:.right, of: img, withOffset: 8)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
        
        
        descriptionLabel.autoPinEdge(.top, to:.bottom, of: titleLabel, withOffset: 2)
        descriptionLabel.autoPinEdge(.left, to:.right, of: img, withOffset: 5)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
        
        seperatorLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
        seperatorLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        seperatorLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
        seperatorLabel.autoSetDimension(.height, toSize: 0.5)
        
        
    }
    
    
    
}
