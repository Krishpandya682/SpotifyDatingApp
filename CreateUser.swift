//
//  CreateUser.swift
//  SpotifyDatingApp
//
//  Created by Krish Pandya on 4/25/23.
//

import Foundation

func extractParameters(from url: URL) -> [String: String]? {
    guard let fragment = url.fragment else {
        print("No hash fragment found in URL: \(url.absoluteString)")
        return nil
    }
    
    var parameters = [String: String]()
    let keyValuePairs = fragment.components(separatedBy: "&")
    
    for keyValuePair in keyValuePairs {
        let components = keyValuePair.components(separatedBy: "=")
        if components.count == 2 {
            let key = components[0]
            let value = components[1]
            parameters[key] = value
        }
    }
    
    if parameters.isEmpty {
        print("No parameters found in hash fragment: \(fragment)")
        return nil
    } else {
        return parameters
    }
}


func getUserInfo(with accessToken: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
    let urlString = "https://api.spotify.com/v1/me"
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "No data returned", code: -1, userInfo: nil)))
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completion(.success(json))
            } else {
                completion(.failure(NSError(domain: "Failed to parse JSON", code: -1, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}



func createUserProfile(url : URL) -> User{
    print("createUserProfile")
    let params = extractParameters(from: url)
    let token_type = params?["token_type"]
    let expires_in = params?["expires_in"]
    print(token_type)
    print(expires_in)
    
    if let accessToken = params?["access_token"] {
        getUserInfo(with: accessToken) { result in
            switch result {
            case .success(let json):
                if let userName = json["display_name"] as? String,
                   let profileImage = json["images"] as? [[String: Any]],
                   let firstImage = profileImage.first,
                   let profileImageLink = firstImage["url"] as? String {
                    print("User Name: \(userName)")
                    print("Profile Image Link: \(profileImageLink)")
                } else {
                    print("Failed to parse user info")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    } else {
        print("Access Token not found")
    }
    
    let tempFeatures = Features(acousticness: 0, danceability: 0, duration_ms: 0, energy: 0, instrumentalness: 0, key: 0, liveness: 0, loudness: 0, mode: 0, speechiness: 0, tempo: 0, time_signature: 0)
    let tempUser = User(spotifyId: "626E5AC0-122B-45D4-91D0-6C44396AE5E8",
                    name: "Krish", imageName: "i1", age: 20,
                    description: "This is my test description", gender: 0, genderPref: 1, ageLow: 18, ageHigh: 25, city: "College Park", state: "MD")
 
    
    return tempUser
}
