import Foundation
import SwiftUI

struct Cell
{
    var board: Board
    
    // displays X and O
    func displayBoard() -> String
    {
        switch(board)
        {
        case Board.Cross:
            return "X"
        case Board.Circle:
            return "O"
        default:
            return " "
        }
    }
    
    // displays colors for X, O, and board
    func boardColor() -> Color
    {
        switch(board)
        {
        case Board.Cross:
            return Color.blue
        case Board.Circle:
            return Color.green
        default:
            return Color.black
        }
    }
}

enum Board
{
    case Cross
    case Circle
    case Blank
}
