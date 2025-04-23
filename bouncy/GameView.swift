//
//  GameView.swift
//  bouncy
//
//  Created by Nico on 4/22/25.
//

import SwiftUI
import SwiftData

struct GameView: View {
    @Environment(\.modelContext) private var context
    @Query private var scores: [HighScore]

    @State private var currentScore = 0
    @State private var ballPosition = CGPoint(x: 200, y: 100)
    @State private var ballVelocity = CGSize(width: 2, height: 4)
    @State private var paddleX: CGFloat = 200
    @State private var viewHeight: CGFloat = 0
    @State private var viewWidth: CGFloat = 0
    @State private var ballColor: Color = .white
    @State private var showColorPicker = false
    @State private var gameTimer: Timer?

    let paddleWidth: CGFloat = 100
    let paddleHeight: CGFloat = 10

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height

            ZStack {
                Color.black.ignoresSafeArea()

                // UI Text Info
                VStack {
                    HStack {
                        Text("Score: \(currentScore)")
                        Spacer()
                        Text("High score: \(scores.first?.value ?? 0)")
                        // Button
                        Button(action: {
                            showColorPicker.toggle()
                        }) {
                            Image(systemName: "paintpalette")
                                .foregroundColor(ballColor)
                                .padding()
                        }
                    }
                    .foregroundColor(.white)
                    .padding()

                    Spacer()
                }

                // Ball
                Circle()
                    .fill(ballColor)
                    .frame(width: 30, height: 30)
                    .position(ballPosition)

                // Paddle (FIXED: not inside VStack)
                Rectangle()
                    .frame(width: paddleWidth, height: paddleHeight)
                    .foregroundColor(.white)
                    .position(x: paddleX, y: height - 80)
                    .gesture(
                        DragGesture().onChanged { value in
                            paddleX = value.location.x
                        }
                    )

                // Color Picker
                if showColorPicker {
                    ColorPickerView(selectedColor: $ballColor)
                }
            }
            .onAppear {
                viewHeight = height
                viewWidth = width
                paddleX = width / 2
                ballPosition = CGPoint(x: width / 2, y: 100)
                startGame()
            }
            .onDisappear {
                gameTimer?.invalidate()
            }
        }
    }

    func startGame() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            updateBall()
        }
    }

    func updateBall() {
        var newX = ballPosition.x + ballVelocity.width
        var newY = ballPosition.y + ballVelocity.height

        if newX <= 15 || newX >= viewWidth - 15 {
            ballVelocity.width *= -1
        }

        if newY <= 15 {
            ballVelocity.height *= -1
        }

        let paddleY = viewHeight - 80
        if newY >= paddleY - 15 && newY <= paddleY + 15 &&
            abs(newX - paddleX) <= paddleWidth / 2 {
            ballVelocity.height *= -1
            currentScore += 1
        }

        if newY > viewHeight {
            endGame()
            return
        }

        ballPosition = CGPoint(x: newX, y: newY)
    }

    func endGame() {
        gameTimer?.invalidate()
        if currentScore > (scores.first?.value ?? 0) {
            if let existing = scores.first {
                existing.value = currentScore
            } else {
                let newHighScore = HighScore(value: currentScore)
                context.insert(newHighScore)
            }
            try? context.save()
        }

        currentScore = 0
        ballPosition = CGPoint(x: viewWidth / 2, y: 100)
        ballVelocity = CGSize(width: 2, height: 4)
    }
}

#Preview {
    ContentView()
}
