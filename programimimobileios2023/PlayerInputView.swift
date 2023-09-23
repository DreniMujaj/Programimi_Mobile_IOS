//
//  PlayerInputView.swift
//  programimimobileios2023
//
//  Created by Dreni Mujaj on 23.9.23.
//

import SwiftUI
import Combine

import SwiftUI

struct PlayerInputView: View {
    @State private var playerName = ""
    @State private var isNavigationActive = false // Step 2
        
    var body: some View {
        NavigationView { // Step 1
            ZStack {
                Image("background-wood-cartoon")
                VStack {
                    HStack {
                        Spacer()
                        TextField("Enter your name", text: $playerName)
                            .padding()
                            .foregroundColor(.gray)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white)) // Added background styling
                            .padding()
                        Spacer()
                    }

                    NavigationLink(destination: ContentView(), isActive: $isNavigationActive) { // Step 3
                        Text("Continue")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(width: 100.0)
                            .foregroundColor(.orange)
                            .onTapGesture {
                                savePlayerName()
                                playerName = ""
                                isNavigationActive = true // Activate the navigation
                            }
                    }
                }
            }
        }
    }

    func savePlayerName() {
        // Create the URL for your backend route
        if let url = URL(string: "http://localhost:3000/user") {
            var request = URLRequest(url: url)
            
            // Define the HTTP method as POST
            request.httpMethod = "POST"
            
            // Create a dictionary with the player name
            let bodyDict: [String: String] = ["player": playerName]
            
            // Convert the dictionary to JSON data
            if let jsonData = try? JSONSerialization.data(withJSONObject: bodyDict) {
                // Set the request body
                request.httpBody = jsonData
                
                // Set the Content-Type header
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // Create a URLSession task to send the request
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    // Handle the response and error here
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        // Handle the data returned by the server, if any
                        print("Response: \(String(data: data, encoding: .utf8) ?? "")")
                        
                        // Activate the navigation to ContentView
                        isNavigationActive = true
                    }
                }
                
                // Start the URLSession task
                task.resume()
            }
        }
    }
}


struct PlayerInputView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInputView()
    }
}
