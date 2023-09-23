//
//  ContentView.swift
//  programimimobileios2023
//
//  Created by Dreni Mujaj on 20.9.23.
//

import SwiftUI

struct ContentView: View {
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
                    Image("card2")
                    Spacer()
                    Image("card3")
                    Spacer()
                }
                Spacer()
                Image("button")
                Spacer()
                HStack {
                    Spacer()
                    VStack{
                        Text("Player").font(.headline).padding(.bottom, 10)
                        
                        Text("0").font(.largeTitle)
                    }
                    Spacer()
                    VStack{
                        Text("CPU").font(.headline).padding(.bottom, 10)
                        Text("0").font(.largeTitle)
                    }
                    Spacer()
                }.foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
