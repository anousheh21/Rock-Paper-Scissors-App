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
    
    var body: some View {
        VStack {
            HStack {
                Button("🪨") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "scissors", loseAgainst: "paper")
                }
                .standardButton()
                
                Button("🗞️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "rock", loseAgainst: "scissors")
                }
                .standardButton()
                
                Button("✂️") {
                    shuffleOptions()
                    answer = options[0]
                    checkAnswer(winAgainst: "paper", loseAgainst: "rock")
                }
                .standardButton()
            }
            
            Text(answer)
            Text(checkedAnswer)
            
        }
        .padding()
    }
    
    // FUNCTIONS
    func shuffleOptions() {
        answer = ""
        options.shuffle()
    }
    
    func checkAnswer(winAgainst win: String, loseAgainst lose: String) {
        if answer == win {
            checkedAnswer = "You Win"
        } else if answer == lose {
            checkedAnswer = "You Lose"
        } else {
            checkedAnswer = "It's a Draw"
        }
    }
}

#Preview {
    ContentView()
}
