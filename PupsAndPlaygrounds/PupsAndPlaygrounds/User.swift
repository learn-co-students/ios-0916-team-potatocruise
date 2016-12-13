//
//  User.swift
//  PupsAndPlaygrounds
//
//  Created by Robert Deans on 11/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User {
  let uid: String
  var firstName: String
  var lastName: String
  var reviewIDs = [String]()
  var profilePhoto: UIImage?
  var photos: [UIImage]?
  
  init(uid: String, firstName: String, lastName: String) {
    self.uid = uid
    self.firstName = firstName
    self.lastName = lastName
  }
}
