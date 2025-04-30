//
//  ColorPickerView.swift
//  bouncy
//
//  Created by Nico on 4/22/25.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    @Environment(\.dismiss) var dismiss

    // Preset color choices
    let presetColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .white, .cyan]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Choose Ball Color")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)

                // Preset colors
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(presetColors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                )
                                .onTapGesture {
                                    selectedColor = color
                                }
                        }
                    }
                    .padding()
                }

                // System color picker
                ColorPicker("Or pick any color:", selection: $selectedColor, supportsOpacity: false)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemBackground).opacity(0.2))
                    )
                    .foregroundColor(.white)
                    .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.black.ignoresSafeArea()) // black background
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
