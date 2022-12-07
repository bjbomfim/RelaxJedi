//
//  Test.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 06/12/22.
//

import SwiftUI

struct Test: View {
    var sabre:Sabre
    var body: some View {
        ZStack{
            Color(sabre.cor)
                .ignoresSafeArea()
            Text("Você escolheu o sabre \(sabre.cor)")
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test(sabre: sabres[0])
    }
}
