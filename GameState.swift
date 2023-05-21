import Foundation

class GameState:ObservableObject
{
    @Published var game = [[Cell]]()
    @Published var turn = Board.Cross
    @Published var crossScore = 0
    @Published var circleScore = 0
    @Published var draw = false
    @Published var message = ""
    
    init()
    {
        resetGame()
    }
    
    // this function marks where an X or O was placed on the board
    func placeItem(_ row: Int,_ column: Int)
    {
        if (game[row][column].board != Board.Blank)
        {
            return
        }
        
        game[row][column].board = turn == Board.Cross ? Board.Cross: Board.Circle
        
        if (playerWon())
        {
            // when a player wins it adds to their score
            if(turn == Board.Cross)
            {
                crossScore += 1
            }
            else
            {
                circleScore += 1
            }
            
            // determines which text to display
            let winner = turn == Board.Cross ? "Player 1": "Player 2"
            message = winner + " Wins!!"
            
            draw = true
        }
        else
        {
            turn = turn == Board.Cross ? Board.Circle: Board.Cross

        }
        
        if (playerDraw())
        {
            // I added this if else if for the case when there are no tiles left and one player won diagonally on the last turn
            if (isTurn(0, 0) && isTurn(1, 1) && isTurn(2, 2))
            {
                let winner = turn == Board.Cross ? "Player 1": "Player 2"
                message = winner + " Wins!!"
                
                draw = true
            }
            else if (isTurn(0, 2) && isTurn(1, 1) && isTurn(2, 0))
            {
                let winner = turn == Board.Cross ? "Player 1": "Player 2"
                message = winner + " Wins!!"
                
                draw = true
            }
            // if the board is full and the player didn't win diagonally then it is a draw
            else
            {
                message = "It is a draw!"
                draw = true
            }
        }
        
    }
    
    // the function determines if it was a draw based on if the board is full or blank
    func playerDraw() -> Bool
    {
        for row in game
        {
            for cell in row
            {
                if cell.board == Board.Blank
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    // this function determines each possible win across the board
    func playerWon() -> Bool
    {
        // vertical wins
        if (isTurn(0, 0) && isTurn(1, 0) && isTurn(2, 0))
        {
            return true
        }
        if (isTurn(0, 1) && isTurn(1, 1) && isTurn(2, 1))
        {
            return true
        }
        if (isTurn(0, 2) && isTurn(1, 2) && isTurn(2, 2))
        {
            return true
        }
        
        // horizontal wins
        if (isTurn(0, 0) && isTurn(0, 1) && isTurn(0, 2))
        {
            return true
        }
        if (isTurn(1, 0) && isTurn(1, 1) && isTurn(1, 2))
        {
            return true
        }
        if (isTurn(2, 0) && isTurn(2, 1) && isTurn(2, 2))
        {
            return true
        }
        
        // diagonal wins
        if (isTurn(0, 0) && isTurn(1, 1) && isTurn(2, 2))
        {
            return true
        }
        if (isTurn(0, 2) && isTurn(1, 1) && isTurn(2, 0))
        {
            return true
        }
       
        
        return false
    }
    
    // determines the turn of the player
    func isTurn(_ row: Int,_ column: Int) -> Bool
    {
        return game[row][column].board == turn
    }
    
    // displays who's turn it is
    func turnText() -> String
    {
         return turn == Board.Cross ? "Player 1's Turn": "Player 2's Turn"
    }
    
    // loads a new game once the board is full 
    func resetGame()
    {
        var newGame = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            
            for _ in 0...2
            {
                row.append(Cell(board: Board.Blank))
            }
            
            newGame.append(row)
        }
        
        game = newGame
        
    }
}
