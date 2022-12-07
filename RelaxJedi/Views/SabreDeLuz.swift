//
//  SabreDeLuz.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 01/12/22.
//

import SwiftUI

struct SabreDeLuz: View {
    var sabre: Sabre = sabres[0]
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color(sabre.cor))
                    .frame(width: 20, height: CGFloat(sabre.tamanho))
                    .overlay(Color(sabre.cor).opacity(0.1))
                    .cornerRadius(CGFloat(90))
                    .shadow(color: Color(sabre.cor), radius: 50)
                    .opacity(0.9)
                Rectangle()
                    .fill(.white)
                    .frame(width: 18, height: CGFloat(sabre.tamanho))
                    .cornerRadius(CGFloat(90))
                    .shadow(color: Color(sabre.cor), radius: 20)
                    .opacity(0.5)
                Rectangle()
                    .fill(.white)
                    .frame(width: 10, height: CGFloat(sabre.tamanho))
                    .cornerRadius(CGFloat(90))
                    .opacity(0.3)
                Rectangle()
                    .fill(.white)
                    .frame(width: 5, height: CGFloat(sabre.tamanho))
                    .cornerRadius(CGFloat(90))
                    .opacity(0.3)
            }
            ZStack{
                Ellipse()
                    .fill(Color(sabre.cor).opacity(0.01))
                    .frame(width: 70, height: 10)
                    .shadow(color: Color(sabre.cor), radius: 50)
                Ellipse()
                    .fill(.white.opacity(0.01))
                    .frame(width: 70, height: 10)
                    .shadow(color: Color(sabre.cor), radius: 50)
            }
        }
    }
}

struct SabreDeLuz_Previews: PreviewProvider {
    static var previews: some View {
        SabreDeLuz(sabre: sabres[0])
    }
}
