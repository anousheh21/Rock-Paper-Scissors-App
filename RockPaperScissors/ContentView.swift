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
            .buttonStyle(.bordered)
    }
}

// Extension for StandardButton ViewModifier
extension View {
    func standardButton() -> some View {
        modifier(StandardButton())
    }
}

struct ContentView: View {
    // Variables
    @State private var options = ["rock", "paper", "scissors"].shuffled()
    @State private var answer = ""
    @State private var checkedAnswer = ""
    @State private var score = 0
    @State private var roundNumber = 0
    @State private var showEndAlert = false
    
    // MAIN BODY
    var body: some View {
        VStack {
            // HStack containing rock, paper, scissors buttons
            HStack {
                Button("🪨") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "scissors", loseAgainst: "paper")
                    checkRoundNumber()
                }
                .standardButton()
                
                Button("🗞️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "rock", loseAgainst: "scissors")
                    checkRoundNumber()
                }
                .standardButton()
                
                Button("✂️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "paper", loseAgainst: "rock")
                    checkRoundNumber()
                }
                .standardButton()
            }
            
            // Text to display computer's choice, and whether the user won/lost/drew
            Text(answer)
            Text(checkedAnswer)
            
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
            checkedAnswer = "You Win"
            score += 1
        } else if answer == lose {
            checkedAnswer = "You Lose"
        } else {
            checkedAnswer = "It's a Draw"
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
