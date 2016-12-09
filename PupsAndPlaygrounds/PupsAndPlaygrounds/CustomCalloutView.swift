//
//  CustomCalloutView.swift
//
//
//  Created by William Robinson on 12/5/16.
//
//

import UIKit
import SnapKit

class CustomCalloutView: UIView {
  
  // MARK: Properties
  lazy var nameLabel = UILabel()
  lazy var addressLabel = UILabel()
  lazy var ratingLabel = UILabel()
  lazy var distanceLabel = UILabel()
  
  // MARK: Initialization
  required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
  override init(frame: CGRect) { super.init(frame: frame) }
  convenience init() {
    let width = UIScreen.main.bounds.width / 1.1
    let height = width / 2.5
    self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
    configure()
    constrain()
  }
  
  // MARK: Setup
  func configure() {
    
    // View
    backgroundColor = UIColor.themeDarkBlue.withAlphaComponent(0.8)
    layer.cornerRadius = 20
    
    // Name
    nameLabel.font = UIFont.themeMediumLight
    nameLabel.textColor = UIColor.themeWhite
    nameLabel.numberOfLines = 0
    
    // Address
    addressLabel.font = UIFont.themeTinyBold
    addressLabel.textColor = UIColor.themeWhite
    addressLabel.numberOfLines = 0
    
    // Rating
    ratingLabel.font = UIFont.themeTinyBold
    ratingLabel.textColor = UIColor.themeWhite
    ratingLabel.numberOfLines = 0
    
    // Distance
    distanceLabel.font = UIFont.themeTinyBold
    distanceLabel.textColor = UIColor.themeMediumBlue
  }
  
  // MARK: Constrain
  func constrain() {
    addSubview(nameLabel)
    nameLabel.snp.makeConstraints {
      $0.leading.top.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    addSubview(addressLabel)
    addressLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(nameLabel.snp.bottom)
    }
    
    addSubview(ratingLabel)
    ratingLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(addressLabel.snp.bottom)
    }
    
    addSubview(distanceLabel)
    distanceLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(ratingLabel.snp.bottom)
    }
  }
}




