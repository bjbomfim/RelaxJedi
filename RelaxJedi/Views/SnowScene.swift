//
//  SnowScene.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 07/12/22.
//

import Foundation
import SpriteKit

class SnowScene: SKScene {
    let snowEmitterNode = SKEmitterNode(fileNamed: "Snow.sks")
    
    var snowSpeed: CGFloat = 300
    var birthrate: CGFloat = 300
    var lifeTime: CGFloat = 0.4
    
    override func didMove(to view: SKView) {
        guard let snowEmitterNode = snowEmitterNode else { return }
        addChild(snowEmitterNode)
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(sabreMoved), name: Sabre.moved, object: nil)
    }
    
    @objc func sabreMoved(_ n:Notification) {
        snowSpeed = snowSpeed == 50 ? 300 : 50
        birthrate = birthrate == 300 ? 600 : 300
        lifeTime = lifeTime == 1 ? 0.4 : 1
        snowEmitterNode?.particleSpeed = snowSpeed
        //snowEmitterNode?.particleBirthRate = birthrate
        snowEmitterNode?.particleLifetime = lifeTime
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        guard let snowEmitterNode = snowEmitterNode else { return }
        snowEmitterNode.particlePosition = CGPoint(x: size.width/2, y: size.height/1.5)
        snowEmitterNode.particlePositionRange = CGVector(dx: size.width, dy: size.height)
    }
}
