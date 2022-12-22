//
//  HelpPlay.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 20/12/22.
//

import SwiftUI

struct HelpPlay: View {
    @State var goPlay = false
    var body: some View {
        TabView{
            VStack{
                Text("Relax Force foi criado para que você possa relaxar utilizando a Força.")
                    .padding()
                Image("inicio")
                    .resizable()
                    .scaledToFit()
                Text("Inicialmente você deve escolher uma cor que preferir.")
                    .padding()
            }
            .padding(30)
            VStack(alignment: .center){
                HStack{
                    Image("Celular1")
                        .resizable()
                        .scaledToFit()
                        //.padding(20)
                    Image("Mao1")
                        .resizable()
                        .scaledToFit()
                }
                .padding()
                Text("Após escolher a cor, posicione a mão da Força na frente do celular até que seja marcado os pontos da força nos quatro dedos da mão.")
                    .padding()
            }
            .padding(30)
            VStack(alignment: .center){
                HStack{
                    Image("Celular2")
                        .resizable()
                        .scaledToFit()
                        //.padding(20)
                    Image("Mao2")
                        .resizable()
                        .scaledToFit()
                }
                .padding()
                Text("Quando os pontos de força estiverem marcados em seus dedos, movimente a mão de forma circular na frente do celular.")
                    .padding()
                Button{
                    UserDefaults.standard.set(true, forKey: "FirstA")
                    goPlay.toggle()
                } label: {
                    Text("Iniciar")
                        .padding()
                }
                .foregroundColor(.black)
                .background(.yellow)
                .cornerRadius(90)
                .fullScreenCover(isPresented: $goPlay) {
                    ContentView()
                }
            }
            .padding(30)
        }
        .font(.system(size: 20))
        .multilineTextAlignment(.center)
        .foregroundColor(Color.white)
        .background(Color.black)
        .tabViewStyle(.page)
    }
}

struct HelpPlay_Previews: PreviewProvider {
    static var previews: some View {
        HelpPlay()
    }
}
