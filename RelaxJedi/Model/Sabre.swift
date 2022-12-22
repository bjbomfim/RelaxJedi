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
    var tag: Int
    
    static let moved = Notification.Name("moved")
}

var sabres = [
    Sabre(cor: .Verde, tamanho: 500, tag: 1),
    Sabre(cor: .Azul, tamanho: 500, tag: 2),
    Sabre(cor: .Vermelho, tamanho: 500, tag: 3),
    Sabre(cor: .Roxo, tamanho: 500, tag: 4)
]
