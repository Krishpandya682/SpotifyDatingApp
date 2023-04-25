//
//  UserView.swift
//  SpotifyDatingApp
//
//  Created by Krish Pandya on 4/25/23.
//

import Foundation
import SwiftUI

struct UserView: View {

    var body: some View {
        Button(action: {setUsers(User(name: "Krish", imageName: "p", age: 20, description: "Desc", features: []))}){
            Text("Write")
        }
        Button(action: {getUsers("626E5AC0-122B-45D4-91D0-6C44396AE5E8")}){
            Text("Read")
        }

            }
     
}


