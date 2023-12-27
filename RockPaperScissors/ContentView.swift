//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anousheh Hasan on 26/12/2023.
//

import SwiftUI

// Custom modifier to add styling to buttons
struct StandardButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            // .buttonStyle(.bordered)
            .controlSize(.large)
            .font(.system(size: 72))
    }
}

// Extension for StandardButton ViewModifier
extension View {
    func standardButton() -> some View {
        modifier(StandardButton())
    }
}

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24))
            .fontWeight(.bold)
    }
}

extension View {
    func textStyle() -> some View {
        modifier(TextStyle())
    }
}

struct ContentView: View {
    // Variables
    let rock = "🪨"
    let paper = "🗞️"
    let scissors = "✂️"
    
    @State private var options = ["🪨", "🗞️", "✂️"].shuffled()
    @State private var answer = ""
    @State private var checkedAnswer = ""
    @State private var score = 0
    @State private var roundNumber = 0
    @State private var showEndAlert = false
    
    // MAIN BODY
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            // HStack containing rock, paper, scissors buttons
            HStack {
                Spacer()
                Button("🪨") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: scissors, loseAgainst: paper)
                    checkRoundNumber()
                }
                .standardButton()
                
                Spacer()
                
                Button("🗞️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: rock, loseAgainst: scissors)
                    checkRoundNumber()
                }
                .standardButton()
                
                Spacer()
                
                Button("✂️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: paper, loseAgainst: rock)
                    checkRoundNumber()
                }
                .standardButton()
                
                Spacer()
            }
            .padding()
            Spacer()
            // Text to display computer's choice, and whether the user won/lost/drew
            Text(answer)
                .font(.system(size: 55))
                .textStyle()
            Spacer()
            Text(checkedAnswer).textStyle()
            Spacer()
            
        }
        .padding()
        // Shows alert with final score after 3 rounds
        .alert("Final Score: \(score)/3", isPresented: $showEndAlert) {
            Button("Restart", action: restartGame)
        }
    }
    
    // FUNCTIONS
    // Function to reset displayed answer and shuffle the options array
    func shuffleOptions() {
        answer = ""
        options.shuffle()
    }
    
    // Function to check whether the user won/lost/drew against the computer
    func checkAnswer(winAgainst win: String, loseAgainst lose: String) {
        if answer == win {
            checkedAnswer = "Round Won"
            score += 1
        } else if answer == lose {
            checkedAnswer = "Round Lost"
        } else {
            checkedAnswer = "Round Drawn"
        }
        
        roundNumber += 1
    }
    
    // Function to keep track of the rounds and show end game alert after 3 rounds
    func checkRoundNumber() {
        if roundNumber == 3 {
            showEndAlert = true
        }
    }
    
    // Function to restart the game upon dismissal of the end game alert
    func restartGame() {
        score = 0
        roundNumber = 0
        answer = ""
        checkedAnswer = ""
    }
}

#Preview {
    ContentView()
}
