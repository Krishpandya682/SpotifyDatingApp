//
//  Card.swift
//  SpotifyDatingApp
//
//  Created by Krish Pandya on 4/24/23.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase

struct Features: Codable{
        let acousticness: Double
        let danceability: Double
        let duration_ms: Int
        let energy: Double
        let instrumentalness: Double
        let key: Int
        let liveness: Double
        let loudness: Double
        let mode: Int
        let speechiness: Double
        let tempo: Double
        let time_signature: Int
}

struct User: Identifiable, Codable {
    let id = UUID()
    let name: String
    let imageName: String
    let age: Int
    let description: String
    let features: [Features]
}

func setUsers(_ val: User) {
    
    FirestoreManager().createUser(userCard: val)
}

func getUsers(_ uid:String){
    print("HIIIII")
    FirestoreManager().getUsers(uid: uid)
}
