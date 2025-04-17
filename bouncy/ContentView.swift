//
//  ContentView.swift
//  bouncy
//
//  Created by Nico on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Spacer()
        VStack {
            Text("Bouncy")
                .padding()
                .fixedSize()
            Circle()
                .fill(Color.black)
                .frame(width: 25, height: 25)
            Ellipse()
                .fill(Color.black)
                .frame(width: 25, height: 7)
        }
        .padding()
        Spacer()
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .frame(width: 100, height: 5)
            Text("tap to begin")
        }
        .padding()
        Spacer()
    }
}

#Preview {
    ContentView()
}
