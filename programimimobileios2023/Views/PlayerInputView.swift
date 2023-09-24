import SwiftUI

struct PlayerInputView: View {
    @State private var playerName = ""
    @State private var isNavigationActive = false
    @EnvironmentObject var playerData: PlayerData // Inject the PlayerData object
    @State private var errorMessage: String?
    @State private var isAlertPresented = false


    var body: some View {
        NavigationView {
            ZStack {
                Image("background-wood-cartoon")
                VStack {
                    HStack {
                        Spacer()
                        TextField("Enter your name", text: $playerName)
                            .padding()
                            .foregroundColor(.gray)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
                            .padding()
                        Spacer()
                    }

                    NavigationLink(destination: ContentView().environmentObject(playerData) , isActive: $isNavigationActive) {
                                    Text("Continue")
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 100.0)
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            savePlayerName()
                        }
                    }
                }
            }.alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage ?? "An error occurred"),
                    dismissButton: .default(Text("OK")) {
                        print("error happned")
                    }
                )
            }
        }
    }

    func savePlayerName() {
        // Create the URL for your backend route
        if let url = URL(string: "http://localhost:3000/api/player") {
            var request = URLRequest(url: url)
            
            // Define the HTTP method as POST
            request.httpMethod = "POST"
            
            // Create a dictionary with the player name
            let bodyDict: [String: String] = ["name": playerName]
            
            // Convert the dictionary to JSON data
            if let jsonData = try? JSONSerialization.data(withJSONObject: bodyDict) {
                // Set the request body
                request.httpBody = jsonData
                
                // Set the Content-Type header
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // Create a URLSession task to send the request
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    // Inside your URLSession task's completion handler
                    if let data = data {
                        // Attempt to decode the response into PlayerResponse
                        do {
                        let jsonString = String(data: data, encoding: .utf8)
                            
                            if let jsonData = jsonString?.data(using: .utf8) {
                                do {
                                    if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                        if let error = jsonObject["error"] as? String {
                                            // Access the "error" property from the JSON string
                                            DispatchQueue.main.async {
                                                errorMessage = "Error: \(error)"
                                                isAlertPresented = true
                                            }
                                        } else {
                                            let decodedResponse = try JSONDecoder().decode(PlayerResponse.self, from: data)
                                            
                                            // No error, update the playerResponse in PlayerData
                                            DispatchQueue.main.async {
                                                playerData.playerResponse = decodedResponse
                                                isNavigationActive = true
                                            }
                                        }
                                    } else {
                                        print("Failed to parse JSON string as a dictionary.")
                                    }
                                } catch {
                                    print("Error parsing JSON string: \(error.localizedDescription)")
                                }
                            } else {
                                print("Unable to convert JSON string to data.")
                            }
                            
                        } catch {
                         
                        }
                    } else if let error = error {
                        // Handle network error
                        DispatchQueue.main.async {
                            errorMessage = "Network error: \(error.localizedDescription)"
                            isAlertPresented = true
                        }
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
