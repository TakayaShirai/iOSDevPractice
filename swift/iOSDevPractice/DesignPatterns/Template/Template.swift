///// Motivation: Algorithms can be decomposed into common parts + specifics
///// Strategy pattern does this through composition
///// - High-level algorithm uses an interface
///// - Concrete implementations implement the interface
///// Template Method does the same thing through inheritance
///// - Overall algorithm make use of abstract member
///// - Inheritors override the abstract members
///// - Parent template method invoked
/////
///// Template: Allows us to define the "skeleton" of the algorithm, with concrete implementations define in subclasses.
//
//import Foundation
//
//class Game {
//  func run() {
//    start()
//    while !haveWinner {
//      takeTurn()
//    }
//    print("Player \(winningPlayer) wins!")
//  }
//
//  internal func start() {
//    precondition(false, "this method needs to be overridden")
//  }
//
//  internal func takeTurn() {
//    precondition(false, "this method needs to be overridden")
//  }
//
//  internal var winningPlayer: Int {
//    precondition(false, "this property needs to be overridden")
//    return 0
//  }
//
//  internal var haveWinner: Bool {
//    precondition(false, "this property needs to be overridden")
//    return false
//  }
//
//  internal var currentPlayer = 0
//  internal let numberOfPlayers: Int
//
//  init(numberOfPlayers: Int) {
//    self.numberOfPlayers = numberOfPlayers
//  }
//}
//
//class Chess: Game {
//  private let maxTurns = 10
//  private var turn = 1
//
//  init() {
//    super.init(numberOfPlayers: 2)
//  }
//
//  override func start() {
//    print("Starting a game of chess with \(numberOfPlayers) players.")
//  }
//
//  override var haveWinner: Bool {
//    return turn > maxTurns
//  }
//
//  override func takeTurn() {
//    print("Player \(currentPlayer)'s turn.")
//    turn += 1
//    currentPlayer = (currentPlayer + 1) % numberOfPlayers
//  }
//
//  override var winningPlayer: Int {
//    return currentPlayer
//  }
//}
//
//func main() {
//  let chess = Chess()
//  chess.run()
//
//  //  Starting a game of chess with 2 players.
//  //  Player 0's turn.
//  //  Player 1's turn.
//  //  Player 0's turn.
//  //  Player 1's turn.
//  //  Player 0's turn.
//  //  Player 1's turn.
//  //  Player 0's turn.
//  //  Player 1's turn.
//  //  Player 0's turn.
//  //  Player 1's turn.
//  //  Player 0 wins!
//}
//
//main()
