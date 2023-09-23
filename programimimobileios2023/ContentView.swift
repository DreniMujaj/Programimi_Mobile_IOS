//
//  ContentView.swift
//  programimimobileios2023
//
//  Created by Dreni Mujaj on 20.9.23.
//

import SwiftUI

struct ContentView: View {
    @State var playerCard = "card7"
    @State var cpuCard = "card13"
    @State var playerScore = 0
    @State var cpuScore = 0
    var body: some View {
        ZStack {
            Spacer()
            Image("background-plain").resizable().ignoresSafeArea()
            Spacer()
            VStack{
                Spacer()
                Image("logo")
                Spacer()
                HStack{
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                Spacer()
                
                Button {
                    deal()
                } label: {
                    Image("button")
                }

                Spacer()
                HStack {
                    Spacer()
                    VStack{
                        Text("Player").font(.headline).padding(.bottom, 10)
                        
                        Text(String(playerScore)).font(.largeTitle)
                    }
                    Spacer()
                    VStack{
                        Text("CPU").font(.headline).padding(.bottom, 10)
                        Text(String(cpuScore)).font(.largeTitle)
                    }
                    Spacer()
                }.foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    func deal() {
        var playerCardNumber = Int.random(in: 2...14)
        var cpuCardNumber = Int.random(in: 2...14)

        // Randomize the players card
        playerCard = "card" + String(playerCardNumber)
        
        // Randomize the cpu card
        cpuCard = "card" + String(cpuCardNumber)

        // update the scores
        if playerCardNumber > cpuCardNumber {
            playerScore = playerScore+1;
            
        } else if playerCardNumber < cpuCardNumber{
            cpuScore += 1;
        } else {
            playerScore = playerScore+1;
            cpuScore += 1;
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
