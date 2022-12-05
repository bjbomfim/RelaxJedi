//
//  ContentView.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 01/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(){
            VStack(alignment: .leading){
                Text("Relax Jebi")
                
                Text("Select your\nfavorite color")
                    .font(.largeTitle)
                
            }.frame(maxWidth: .infinity)
            HStack{
                SabreDeLuz(corSabre: .green, height: CGFloat(400))
                    .padding(.all, 50)
                SabreDeLuz(corSabre: .red, height: CGFloat(500))
                    .padding(.all, 50)
                SabreDeLuz(corSabre: .purple, height: CGFloat(400))
                    .padding(.all, 50)
            }
        }.frame(maxHeight: .infinity)
            .foregroundColor(.white)
            .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
