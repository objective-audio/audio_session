//
//  Mode.swift
//  AudioSession
//
//  Created by Yuki Yasoshima on 2020/01/01.
//  Copyright © 2020 八十嶋祐樹. All rights reserved.
//

import Foundation
import AVFoundation

enum Mode: CaseIterable {
    case `default`
    case voiceChat
    case gameChat
    case videoRecording
    case measurement
    case moviePlayback
    case videoChat
    case spokenAudio
    case voicePrompt
    
    var sessionMode: AVAudioSession.Mode {
        switch self {
        case .default:
            return .default
        case .voiceChat:
            return .voiceChat
        case .gameChat:
            return .gameChat
        case .videoRecording:
            return .videoRecording
        case .measurement:
            return .measurement
        case .moviePlayback:
            return .moviePlayback
        case .videoChat:
            return .videoChat
        case .spokenAudio:
            return .spokenAudio
        case .voicePrompt:
            return .voicePrompt
        }
    }
}
