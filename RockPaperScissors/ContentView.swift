//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anousheh Hasan on 26/12/2023.
//

import SwiftUI

struct StandardButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
    }
}

extension View {
    func standardButton() -> some View {
        modifier(StandardButton())
    }
}

struct ContentView: View {
    @State private var options = ["rock", "paper", "scissors"].shuffled()
    @State private var answer = ""
    @State private var checkedAnswer = ""
    @State private var score = 0
    @State private var roundNumber = 0
    @State private var showEndAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Button("🪨") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "scissors", loseAgainst: "paper")
                    checkRoundNumber()
                    // roundNumber += 1
                }
                .standardButton()
                
                Button("🗞️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "rock", loseAgainst: "scissors")
                    checkRoundNumber()
                   // roundNumber += 1
                }
                .standardButton()
                
                Button("✂️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "paper", loseAgainst: "rock")
                    checkRoundNumber()
                   // roundNumber += 1
                }
                .standardButton()
            }
            
            Text(answer)
            Text(checkedAnswer)
            
        }
        .padding()
        .alert("Final Score: \(score)/3", isPresented: $showEndAlert) {
            Button("Restart", action: restartGame)
        }
    }
    
    // FUNCTIONS
    func shuffleOptions() {
        answer = ""
        options.shuffle()
    }
    
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
    
    func checkRoundNumber() {
        if roundNumber == 3 {
            showEndAlert = true
        }
    }
    
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
