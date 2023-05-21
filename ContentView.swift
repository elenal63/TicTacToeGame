import SwiftUI

struct ContentView: View
{
    @StateObject var gameState = GameState()
    
    var body: some View
    {
        
            let borderSize = CGFloat(5)
            
            // this displays the score aligned left
            Text(String(format: "Player 1's Score: %d", gameState.crossScore))
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Text(String(format: "Player 2's Score: %d", gameState.circleScore ))
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            // this displays the current player's turn
            Text(gameState.turnText())
                .font(.title)
                .bold()
                .padding()
            
            // this displays the tic tac toe board
            
            VStack(spacing: borderSize)
            {
                ForEach(0...2, id: \.self)
                {
                    row in
                    HStack(spacing: borderSize)
                    {
                        ForEach(0...2, id: \.self)
                        {
                            column in
                            
                            let cell = gameState.game[row][column]
                            
                            Text(cell.displayBoard())
                                .font(.system(size:60))
                                .foregroundColor(cell.boardColor())
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white)
                                .onTapGesture{
                                    gameState.placeItem(row, column)
                                }
                        }
                    }
                }
            }
            
            
            .background(Color.black)
            .padding()
            .alert(isPresented: $gameState.draw)
            {
                // this displays a message (the result of the game), then a button to restart the game
                Alert(title: Text(gameState.message), dismissButton: .default(Text("Restart"))
                      {
                    gameState.resetGame()
                }
                )
            }
        }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
