//
//  ProfileView.swift
//  PupsAndPlaygrounds
//
//  Created by William Robinson on 11/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
  
  // MARK: Properties
  var profileButton: UIButton!
  let profileButtonWidth: CGFloat = 200
  var userNameLabel: UILabel!

  // MARK: Initialization
  override init(frame: CGRect) {
    
    super.init(frame: frame)
  }
  
  convenience init() {
    
    self.init(frame: CGRect.zero)
    
    configure()
    constrain()
  }
  
  required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
  }
  
  // MARK: View Configuration
  private func configure() {
    backgroundColor = UIColor.themeLightBlue
    
    profileButton = UIButton()
    profileButton.titleLabel?.font = UIFont.themeMediumBold
    profileButton.titleLabel?.numberOfLines = 2
    profileButton.titleLabel?.textAlignment = .center
    profileButton.imageView?.contentMode = .scaleAspectFill
    profileButton.layer.cornerRadius = profileButtonWidth / 2
    profileButton.layer.borderWidth = 4
    profileButton.layer.borderColor = UIColor.themeWhite.cgColor
    profileButton.clipsToBounds = true
    
    userNameLabel = UILabel()
    userNameLabel.font = UIFont.themeMediumLight
    userNameLabel.textColor = UIColor.themeWhite
  }
  
  // MARK: View Constraints
  private func constrain() {
    
    addSubview(profileButton)
    profileButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(80)
      $0.width.height.equalTo(profileButtonWidth)
    }
    
    addSubview(userNameLabel)
    userNameLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileButton.snp.bottom).offset(40)
    }
  }
}