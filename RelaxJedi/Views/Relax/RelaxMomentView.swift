//
//  RelxaMomentView.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 08/12/22.
//

import SwiftUI

extension CGPoint: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

struct RelaxMomentView: View {
    @State private var overlayPoints: [CGPoint] = [CGPoint(x: 0.0, y: 0.0)]
    @State private var x1 = (UIScreen.main.bounds.width / 2 + cos(CGFloat(0.0)) * 50)
    @State private var y1 = (UIScreen.main.bounds.height / 2 + sin(CGFloat(0.0)) * 50)
    @State private var x2 = (UIScreen.main.bounds.width / 2 + cos(CGFloat(Double.pi)) * 50)
    @State private var y2 = (UIScreen.main.bounds.height / 2 + sin(CGFloat(Double.pi)) * 50)
    @State private var a = 0.0
    @State private var old = CGPoint(x: 0, y: 0)
    var color: cores
    var body: some View {
        VStack{
            ZStack {
                ImagePicker {
                    overlayPoints = $0
                }
                .overlay(
                    FingersOverlay(with: overlayPoints)
                        .foregroundColor(.orange)
                )
                .edgesIgnoringSafeArea(.all)
                Color(.black).opacity(0.7).ignoresSafeArea()
                Circle()
                    .fill(Color(color.rawValue))
                    .opacity(0.95)
                    .shadow(color: Color(color.rawValue), radius: 50)
                    .frame(width: 100, height: 100)
                    .position(x: x1,y: y1)
                Circle()
                    .fill(Color(color.rawValue))
                    .opacity(0.95)
                    .shadow(color: Color(color.rawValue), radius: 50)
                    .frame(width: 100, height: 100)
                    .position(x: x2,y: y2)
            }
        }.onChange(of: overlayPoints[0]){newValue in
            if ((newValue.x + 5 < old.x || newValue.y + 5 < old.y) || (newValue.x - 5 > old.x || newValue.y - 5 > old.y)){
                x1 = (UIScreen.main.bounds.width / 2 + cos(CGFloat(a)) * 50)
                y1 = (UIScreen.main.bounds.height / 2 + sin(CGFloat(a)) * 50)
                x2 = (UIScreen.main.bounds.width / 2 + cos(CGFloat(a+Double.pi)) * 50)
                y2 = (UIScreen.main.bounds.height / 2 + sin(CGFloat(a+Double.pi)) * 50)
                a = a + 0.01
                if a >= (Double.pi+Double.pi){
                    a = 0
                }
                old = newValue
            }
        }
    }
}

struct RelxaMomentView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxMomentView(color: .Roxo)
    }
}
