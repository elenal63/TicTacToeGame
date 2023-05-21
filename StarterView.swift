import SwiftUI

struct StartView: View
{
    @StateObject var welcomePage = Welcome()
    
    var body: some View
    {
        
        //let borderSize = CGFloat(5)
        
        Text(welcomePage.welcomeText())
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        
        NavigationView{
            
            VStack{
                NavigationLink(destination: ContentView(), label: {Text("Start Game")})
            }
        }
    }
}
