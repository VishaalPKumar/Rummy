//
//  ContentView.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/13/24.
//

import SwiftUI

struct CreateGameView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var numPlayers: Int = 2
    @State private var gameTitle: String = ""
    @State private var playerNames: [String] = ["", ""]
    @State private var showAlert: Bool = false
    
    var body: some View {
        Form {
            Section("Game Information") {
                TextField("Game Title", text: $gameTitle)
                Stepper("Number of Players: \(numPlayers)", value: $numPlayers, in: 2...10)
            }
            
            Section("Player Information") {
                ForEach(1...numPlayers, id: \.self) {
                    TextField("Player \($0) Name", text: $playerNames[$0 - 1])
                }
            }
            Button {
                if checkEntries() {
                    let newGame = Game(title: gameTitle,
                                       players: playerNames)
                    context.insert(newGame)
                    dismiss()
                } else {
                    showAlert = true
                }
                
            } label: {
                Text("Start Game")
            }
            
        }
        .onChange(of: numPlayers, { oldValue, newValue in
            if oldValue < newValue {
                playerNames.append("")
            } else {
                playerNames.removeLast()
            }
        })
        .navigationTitle("New Game")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Incorrect Values"), message: Text("Please ensure you have entered a game title and all player names have unique names."))
        }
    }
    
    private func checkEntries() -> Bool {
        if gameTitle.isEmpty { return false }
        
        if playerNames.contains(where: \.isEmpty){ return false }
        
        if !playerNames.isUnique { return false }
        
        return true
    }
}

#Preview {
    let container = Game.container
    return CreateGameView()
        .modelContainer(container)
}

