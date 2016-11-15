//
//  Sound.swift
//  ParkPassGenerator
//
//  Created by Alexey Papin on 15.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import AudioToolbox

enum Sound: String {
    case AccessDenied
    case AccessGranted
    
    func play() {
        var soundId: SystemSoundID = 0
        let path = Bundle.main.path(forResource: self.rawValue, ofType: "wav")!
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: path), &soundId)
        AudioServicesPlaySystemSound(soundId)
    }
}
