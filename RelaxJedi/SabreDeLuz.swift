//
//  SabreDeLuz.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 01/12/22.
//

import SwiftUI

struct SabreDeLuz: View {
    let corSabre:Color
    @State var height:CGFloat
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(corSabre)
                    .frame(width: 20, height: height)
                    .overlay(corSabre.opacity(0.1))
                    .cornerRadius(CGFloat(90))
                    .shadow(color: corSabre, radius: 50)
                    .opacity(0.9)
                Rectangle()
                    .fill(.white)
                    .frame(width: 18, height: height)
                    .cornerRadius(CGFloat(90))
                    .shadow(color: corSabre, radius: 20)
                    .opacity(0.5)
                Rectangle()
                    .fill(.white)
                    .frame(width: 10, height: height)
                    .cornerRadius(CGFloat(90))
                    .opacity(0.3)
                Rectangle()
                    .fill(.white)
                    .frame(width: 5, height: height)
                    .cornerRadius(CGFloat(90))
                    .opacity(0.3)
            }
            ZStack{
                Ellipse()
                    .fill(corSabre.opacity(0.01))
                    .frame(width: 70, height: 10)
                    .shadow(color: corSabre, radius: 50)
                Ellipse()
                    .fill(.white.opacity(0.01))
                    .frame(width: 70, height: 10)
                    .shadow(color: corSabre, radius: 50)
            }
        }
    }
}

struct SabreDeLuz_Previews: PreviewProvider {
    static var previews: some View {
        SabreDeLuz(corSabre: .green, height: CGFloat(500))
    }
}
