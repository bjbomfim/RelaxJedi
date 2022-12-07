//
//  ContentView.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 01/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Relax force")
                    .font(.title2)
                    .padding()
                VStack(alignment: .leading){
                    Text("Select your")
                        .font(.largeTitle)
                    Text("favorite color")
                        .font(.largeTitle)
                }.padding()
                featured
                
            }.frame(maxHeight: .infinity)
                .foregroundColor(.white)
                .background(Color("Back"))
        }
    }
    
    var featured: some View{
        TabView{
            ForEach(sabres){ sabre in
                GeometryReader { proxy in
                    NavigationLink(destination: Test(sabre: sabre)){
                        let minX = Double(proxy.frame(in: .global).minX)
                        SabreDeLuz(sabre: sabre)
                            .padding(.vertical, 40)
                            .rotation3DEffect(.degrees(minX / 10), axis: (x: 0, y: 0, z: 1))
                            .blur(radius: abs(minX/10))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
