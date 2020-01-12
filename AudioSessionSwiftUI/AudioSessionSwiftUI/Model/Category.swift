import Foundation
import AVFoundation

enum Category: CaseIterable {
    case ambient
    case soloAmbient
    case playback
    case record
    case playAndRecord
    case multiRoute
    
    var name: String {
        switch self {
        case .ambient:
            return "Ambient"
        case .soloAmbient:
            return "SoloAmbient"
        case .playback:
            return "Playback"
        case .record:
            return "Record"
        case .playAndRecord:
            return "PlayAndRecord"
        case .multiRoute:
            return "MultiRoute"
        }
    }
    
    var sessionCategory: AVAudioSession.Category {
        switch self {
        case .playback:
            return .playback
        case .playAndRecord:
            return .playAndRecord
        case .ambient:
            return .ambient
        case .soloAmbient:
            return .soloAmbient
        case .record:
            return .record
        case .multiRoute:
            return .multiRoute
        }
    }
}
