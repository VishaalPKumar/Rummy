//
//  EditRoundView.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/14/24.
//

import SwiftUI

struct EditRoundView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var rounds: [[String : Int]]
    @State private var round: [String : Int] = [:]
    @State private var showAlert: Bool = false
    
    var roundIndex: Int? = nil
    let players: [String]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Scores") {
                    ForEach(round.sorted(by: {$0.value > $1.value || $0.key < $1.key}), id: \.key) { player, score in
                        HStack{
                            Text(player)
                            Spacer()
                            TextField("Score", value: binding(for: player), format: .number)
                                .multilineTextAlignment(.trailing)
                            
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    if let roundIndex {
                        Button("Save") {
                            if checkRound(round) {
                                rounds[roundIndex] = round
                                dismiss()
                            } else {
                                showAlert = true
                            }
                        }
                    } else {
                        Button("Add") {
                            if checkRound(round) {
                                rounds.append(round)
                                dismiss()
                            } else {
                                showAlert = true
                            }
                        }
                    }
                }
            }
            .onAppear {
                if let roundIndex {
                    round = rounds[roundIndex]
                } else {
                    for player in players {
                        round[player] = 0
                    }
                }
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Point Error"), message: Text("All points must sum to zero. Please check and try again."))
            }
        }
    }
    
    private func binding(for player: String) -> Binding<Int?> {
        return Binding<Int?>(
            get: {
                round[player]
            },
            set: { newValue in
                if let newValue = newValue {
                    round[player] = newValue
                } else {
                    round[player] = 0 // Set to a default value like 0 instead of removing the key
                }
            }
        )
    }
    
    private func checkRound(_ round: [String : Int]) -> Bool {
        let total: Int = round.values.reduce(0, +)
        return total == 0
    }
}

#Preview {
    let container = Game.container
    return EditRoundView(rounds: .constant(Game.sampleGame.rounds), players: Game.sampleGame.players)
        .modelContainer(container)
}
