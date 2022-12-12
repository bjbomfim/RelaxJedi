//
//  ContentView.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 01/12/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                SpriteView(scene: scene)
                    .ignoresSafeArea()
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
            }
        }
    }
    
    var scene: SKScene{
        let scene = SnowScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        return scene
    }
    
    @State var isScrolling: Bool = false
    
    var featured: some View{
        TabView{
            ForEach(sabres){ sabre in
                GeometryReader { proxy in
                    NavigationLink(destination: RelaxMomentView(color: sabre.cor)){
                        let minX = Double(proxy.frame(in: .global).minX)
                        SabreDeLuz(sabre: sabre)
                            .padding(.vertical, 40)
                            .rotation3DEffect(.degrees(minX / 10), axis: (x: 0, y: 0, z: 1))
                            .blur(radius: abs(minX/10))
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey.self,
                                    value: -$0.frame(in: .named("scroll")).origin.y)
                            })
                          
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity)
        .onPreferenceChange(ViewOffsetKey.self) {_ in
            // process here update of page origin as needed
            isScrolling.toggle()
        
            NotificationCenter.default.post(name: Sabre.moved, object: self)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
