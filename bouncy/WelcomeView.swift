//
//  WelcomeView.swift
//  bouncy
//
//  Created by Nico on 4/17/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var startGame = false

    var body: some View {
        if startGame {
            GameView()
        } else {
            VStack {
                Text("Bouncy")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)

                Spacer().frame(height: 40)

                Button(action: {
                    startGame = true
                }) {
                    Text("Tap to begin")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
    }
}
