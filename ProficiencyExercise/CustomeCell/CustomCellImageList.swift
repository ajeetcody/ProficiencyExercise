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
    
    var img     = UIImageView()
    var labelTitle = UILabel()
    var labelDescription = UILabel()
    var labelSeperator = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        img.layer.cornerRadius = img.frame.size.width / 2
        img.clipsToBounds = true;
        
        
        labelTitle.font = Constants.TitleFont
        labelDescription.font = Constants.DescriptionFont
        
        labelDescription.numberOfLines = 0
        
        contentView.addSubview(img)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelDescription)
        contentView.addSubview(labelSeperator)
        
        
        img.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        img.autoSetDimensions(to: CGSize.init(width: 80, height: 80))
        img.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        labelTitle.autoPinEdge(.left, to:.right, of: img, withOffset: 5)
        labelTitle.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
       // labelTitle.autoSetDimension(.height, toSize: Constants.TitleLabelDefaultHeight)
        labelTitle.backgroundColor = UIColor.clear
        
        
        labelDescription.autoPinEdge(.top, to:.bottom, of: labelTitle, withOffset: 2)
        labelDescription.autoPinEdge(.left, to:.right, of: img, withOffset: 5)
        labelDescription.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
       // labelDescription.autoSetDimension(.height, toSize: Constants.DescriptionDefaultLabelHeight)
        labelDescription.backgroundColor = UIColor.clear
        
        
        labelSeperator.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
        labelSeperator.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        labelSeperator.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
        labelSeperator.autoSetDimension(.height, toSize: 0.5)
        
        labelSeperator.backgroundColor = UIColor.lightGray
        
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
    
}
