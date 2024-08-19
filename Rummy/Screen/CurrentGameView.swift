//
//  CurrentGameView.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/13/24.
//

import SwiftUI
import SwiftData

struct CurrentGameView: View {
    
    @Bindable var game: Game
    @State var isEditRoundShowing: Bool = false
    @State var selectedRound: Int? = nil
    
    var body: some View {
        List {
            Section("Players") {
                ForEach(game.scoreCard.sorted(by: { $0.value > $1.value }), id: \.key) { player, score in
                    PlayerListItem(player: player, score: score)
                }
            }
            
            Section("Rounds") {
                ForEach(game.rounds.indices, id: \.self) { i in
                    DisclosureGroup {
                        ForEach(Array(game.rounds[i].sorted(by: { $0.value > $1.value })), id: \.key) { player, points in
                            HStack {
                                Text(player)
                                Spacer()
                                if points > 0 {
                                    Text("\(points)")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.green)
                                } else {
                                    Text("\(points)")
                                        .foregroundStyle(.red)
                                }
                                
                            }
                        }
                        
                    } label: {
                        HStack {
                            Image(systemName: "\(i + 1).circle")
                            Text("Round \(i + 1)")
                        }
                        .padding(.vertical, 5)
                    }
                    .swipeActions(edge: .leading) {
                        Button("Edit") {
                            selectedRound = i
                            isEditRoundShowing = true
                        }
                        .tint(.green)
                    }
                }
                .onDelete(perform: { indexSet in
                    game.deleteRoundAt(indexSet)
                })
                
            }
            
            Button("New Round") {
                selectedRound = nil
                isEditRoundShowing = true
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isEditRoundShowing) {
            EditRoundView(rounds: $game.rounds, roundIndex: selectedRound, players: game.players)
        }
    }
}

struct PlayerListItem: View {
    let player: String
    let score: Int
    
    var body: some View {
        HStack {
            Text(player)
            Spacer()
            Text("\(score)")
        }
        .padding(.vertical, 7)
    }
}


#Preview {
    let container = Game.container
    return CurrentGameView(game: Game.sampleGame)
        .modelContainer(container)
}
