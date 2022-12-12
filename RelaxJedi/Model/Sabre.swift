//
//  Sabre.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 06/12/22.
//

import Foundation
import SwiftUI

struct Sabre: Identifiable{
    var id = UUID()
    var cor: cores
    var tamanho: Int
    
    
    static let moved = Notification.Name("moved")
}

var sabres = [
    Sabre(cor: .Verde, tamanho: 500),
    Sabre(cor: .Azul, tamanho: 500),
    Sabre(cor: .Vermelho, tamanho: 500),
    Sabre(cor: .Roxo, tamanho: 500)
]
