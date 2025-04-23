//
//  ColorPickerView.swift
//  bouncy
//
//  Created by Nico on 4/22/25.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [.white, .red, .orange, .yellow, .green, .blue, .purple, .pink, .brown]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
            .padding()

            Text("Selected color:")
                .foregroundColor(.white)

            Circle()
                .fill(selectedColor)
                .frame(width: 30, height: 30)

            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 15) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding()
        }
        .background(Color.black.opacity(0.9))
    }
}
