//
//  FirebaseData.swift
//  PupsAndPlaygrounds
//
//  Created by Robert Deans on 11/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Firebase

class FirebaseData {
    
    // MARK: Account Creation
    
    static func createAccountTouched(firstName: String, lastName: String, email:String, password: String, checkedPassword:String) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
            
            guard error == nil else { print("error creating firebase user; Error: \(error)"); return }
            guard let user = user else { print("error unwrapping user data"); return }
            
            let changeRequest = user.profileChangeRequest()
            changeRequest.displayName = firstName + lastName
            
            changeRequest.commitChanges { error in
                
                guard error == nil else { print("error commiting changes for user profile change request"); return }
                
            }
        }
        
        addUserToBranch(firstName: firstName, lastName: lastName, email: email, password: password)
        
        
    }
    
    static func addUserToBranch(firstName: String, lastName: String, email:String, password: String) {
        let ref = FIRDatabase.database().reference().root
        guard let userKey = FIRAuth.auth()?.currentUser?.uid else { return }
        
        ref.child("users").updateChildValues([userKey: ["firstName": firstName, "lastName": lastName, "email": email, "password": password]])
    }
    
    
    static func signIn(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
            
            guard error == nil else { print("error signing user in"); return }
            
        }
    }
    
    // MARK: Reviews Data Branch
    
    static func addReview(comment: String, locationID: String) {
        let ref = FIRDatabase.database().reference().root
        
        let uniqueReviewKey = FIRDatabase.database().reference().childByAutoId().key
        
        guard let userKey = FIRAuth.auth()?.currentUser?.uid else { return }
        

        
        if locationID.hasPrefix("PG") {
        
            ref.child("reviews").updateChildValues([uniqueReviewKey: ["comment": comment, "userID": userKey, "locationID": locationID]])
            
            ref.child("locations").child("playgrounds").child("\(locationID)").child("reviews").updateChildValues([uniqueReviewKey: ["comment": comment, "userID": userKey]])
            
            ref.child("users").child("\(userKey)").child("reviews").updateChildValues([uniqueReviewKey: ["comment": comment]])
            
        } else if locationID.hasPrefix("DR") {
            
            ref.child("reviews").updateChildValues([uniqueReviewKey: ["comment": comment, "userID": userKey, "locationID": locationID]])
            
            ref.child("locations").child("dogruns").child("\(locationID)").child("reviews").updateChildValues([uniqueReviewKey: ["comment": comment, "userID": userKey]])
            
            ref.child("users").child("\(userKey)").child("reviews").updateChildValues([uniqueReviewKey: ["comment": comment]])
        }
        
        
    }
    
    // MARK: Generates Locations on the app FROM Firebase data source
    
    static func getAllPlaygrounds(with completion: @escaping ([Playground]) -> Void ) {
        var newArray: [Playground] = []
        
        let ref = FIRDatabase.database().reference().child("locations").child("playgrounds")
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let playgroundDict = snapshot.value as? [String : Any] else { return }
            
            
            for newPlayground in playgroundDict {
                let ID = newPlayground.key
                let value = newPlayground.value as! [String:Any]
                
                guard let name = value["name"] as? String else { return }
                guard let location = value["location"] as? String else { return }
                guard let isHandicap = value["isHandicap"] as? String else { return }
                guard let latitude = value["latitude"] as? String else { return }
                guard let longitude = value["longitude"] as? String else { return }
                
                let newestPlayground = Playground(ID: ID, name: name, location: location, handicap: isHandicap, latitude: latitude, longitude: longitude)
                
                newArray.append((newestPlayground))
            }
            completion(newArray)
        })
    }
    
    // MARK: Adding local JSON files to Firebase
    
    static func addPlaygroundsToFirebase(playgroundID: String, name: String, location: String, isHandicap: Bool, latitude: String, longitude: String) {
        
        let ref = FIRDatabase.database().reference().root
        
        let uniqueLocationKey = "PG+\(playgroundID)"
        
        var isHandicapString = "No"
        
        if isHandicap == true {
            isHandicapString = "Yes"
        }
        
        ref.child("locations").child("playgrounds").updateChildValues( [uniqueLocationKey:["name": name, "location": location, "isHandicap": isHandicapString, "latitude": latitude, "longitude": longitude]])
    }
    
    static func addDogrunsToFirebase(dogRunID: String, name: String, location: String, isHandicap: Bool, dogRunType: String, notes: String) {
        
        let ref = FIRDatabase.database().reference().root
        
        let uniqueLocationKey = "DR+\(dogRunID)"
        
        var isHandicapString = "No"
        
        if isHandicap == true {
            isHandicapString = "Yes"
        }
        
        ref.child("locations").child("dogruns").updateChildValues( [uniqueLocationKey:["name": name, "location": location, "isHandicap": isHandicapString, "dogRunType": dogRunType, "notes": notes]])
    }
    
    // MARK: Location Services
    
    static func getPlaygroundsLocationCoordinates(for locationID: String, completion: @escaping (_ longitude: String, _ latitude: String) -> Void) {
        
        let ref = FIRDatabase.database().reference().child("locations").child("playgrounds").child(locationID)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let locationSnap = snapshot.value as? [String: Any] else {return}
            
            print("LOCATIONSNAP = \(locationSnap)")
            
            guard let longitude = locationSnap["longitude"] as? String else {return}
            guard let latitude = locationSnap["latitude"] as? String else {return}
            
            completion(longitude, latitude)
        })
        
    }
    
    
}