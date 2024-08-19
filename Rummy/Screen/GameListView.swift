//
//  GameListView.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/15/24.
//

import SwiftUI
import SwiftData

struct GameListView: View {
    
    @Query(sort: \Game.title) var games: [Game] = []
    @Environment(\.modelContext) var context
    @State var isAddGamePresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink(value: game) {
                        GameListItem(game: game)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        context.delete(games[index])
                    }
                })
            }
            .listStyle(.plain)
            .padding(.top, 10)
            .navigationDestination(for: Game.self) { game in
                CurrentGameView(game: game)
                
            }
            .navigationTitle("♠️ Rummy")
            .overlay(alignment: .bottomTrailing) {
                if !games.isEmpty {
                    Button {
                        isAddGamePresented = true
                    } label: {
                        FloatingButton(systemImageName: "plus")
                            .padding()
                    }
                }
            }
            .overlay {
                if games.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Games", systemImage: "table.furniture")
                    }, description: {
                        Text("Add a new game")
                    }, actions: {
                        Button {
                            isAddGamePresented = true
                        } label: {
                            Text("Add Game")
                        }
                    })
                }
            }
            .sheet(isPresented: $isAddGamePresented) {
                CreateGameView()
            }
        }
    }
}

struct GameListItem: View {
    
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Text("Number of Rounds: \(game.rounds.count)")
                .font(.caption)
                .fontWeight(.light)
        }
    }
}

#Preview {
    let container = Game.container
    return GameListView()
        .modelContainer(container)
}
