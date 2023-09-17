import Foundation

class TicTacToeGameLogic {
    // Enum to represent players X and O
    enum Player {
        case X
        case O
    }

    // Dictionary to represent the game board, where Int is the position and Player is the current player's symbol
    var gameBoard: [Int: Player] = [:]
    
    // The current player (X or O)
    var currentPlayer: Player = .X
    
    // Flag to indicate if the game is over
    var isGameOver = false

    // Defines the winning combinations for rows, columns, and diagonals
    let winCombinations: [[Int]] = [
        [1, 2, 3], [4, 5, 6], [7, 8, 9],    // Rows
        [1, 4, 7], [2, 5, 8], [3, 6, 9],    // Columns
        [1, 5, 9], [3, 5, 7]               // Diagonals
    ]
    
    // The maximum number of moves allowed in the game
    private let maxMoves = 9

    // Reset the game board and current player to start a new game
    func resetGame() {
        gameBoard.removeAll()
        currentPlayer = .X
        isGameOver = false
        print("Board are reset")
    }

    // Make a move at the specified position on the game board
    // - Parameters:
    //   - position: The position on the game board where the move is made
    func makeMove(at position: Int) {
        // Ensure the game is not already over and the selected cell is empty
        guard !isGameOver, gameBoard[position] == nil else {
            return
        }
        
        // Set the current player's symbol in the cell
        gameBoard[position] = currentPlayer

        // Check if the current player has won or if the game is a draw
        if checkForWin() {
            isGameOver = true
        } else if checkForDraw() {
            isGameOver = true
        }
          else {
            // Switch to the other player for the next turn
            currentPlayer = (currentPlayer == .X) ? .O : .X
        }
    }

    // Check if the current player has won the game
    // - Returns: True if the current player has won, otherwise false
    func checkForWin() -> Bool {
        for combination in winCombinations {
            if let player = gameBoard[combination[0]],    // Row combination
                player == gameBoard[combination[1]], // Columns combination
                player == gameBoard[combination[2]] // Diagonal combination
            {
                print("\(player) combination is \(combination)")
                return true
            }
        }
        print("No one won")
        return false
        
    }

    // Check if the game is a draw (all cells are filled)
    // - Returns: True if the game is a draw, otherwise false
    func checkForDraw() -> Bool {
        return gameBoard.count == maxMoves
    }
}
