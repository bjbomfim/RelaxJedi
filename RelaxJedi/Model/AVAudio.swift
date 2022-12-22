//
//  AVAudio.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 22/12/22.
//

import Foundation
import AVFAudio
import UIKit

class AVAudio{
    static var audioPlay: AVAudioPlayer?
    
    static func AudioPlay(_ assetName:String) {
        guard let audioData = NSDataAsset(name: assetName)?.data else {
            fatalError("Unable to find asset \(assetName)")
        }
        
        do{
            audioPlay = try AVAudioPlayer(data: audioData)
            if !(audioPlay!.isPlaying){
                audioPlay?.play()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
