//
//  Game.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/15/24.
//

import SwiftUI
import SwiftData

@Model
final class Game {
    
    let title: String
    var players: [String]
    var rounds: [[String: Int]]
    
    var scoreCard: [String: Int] {
        var card: [String : Int] = [:]
        for player in players {
            card[player] = 0
        }
        for round in rounds {
            for (player, score) in round {
                card[player] = card[player, default: 0] + score
            }
        }
        return card
    }
    
    init(title: String, players: [String] = [], rounds: [[String : Int]] = []) {
        self.title = title
        self.players = players
        self.rounds = rounds
    }
    
    func addRound(round: [String: Int]) -> () {
        rounds.append(round)
    }
    
    func deleteRoundAt(_ indexSet: IndexSet) {
        for index in indexSet {
            rounds.remove(at: index)
        }
    }
    
    static let sampleGame: Game = Game(title: "Game 1",
                                       players: ["P1", "P2", "P3"],
                                       rounds: [
                                        ["P1": 200, "P2": -100, "P3": -100, ],
                                        ["P1": -100, "P2": -100, "P3": 200, ],
                                        ["P1": 200, "P2": -100, "P3": -100, ],
                                       ])
    
}

extension Game {
    @MainActor
    static var container: ModelContainer {
        let container = try! ModelContainer(for: Game.self,
                                            configurations: ModelConfiguration(isStoredInMemoryOnly: true))

        container.mainContext.insert(Game.sampleGame)
        return container
    }
}
