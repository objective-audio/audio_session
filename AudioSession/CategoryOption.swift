import Foundation
import AVFoundation

enum CategoryOption: Int, CaseIterable {
    case mixWithOthers
    case duckOthers
    case allowBluetooth
    case defaultToSpeaker
    case interruptSpokenAudioAndMixWithOthers
    case allowBluetoothA2DP
    case allowAirPlay
    
    var name: String {
        switch self {
        case .mixWithOthers:
            return "MixWithOthers"
        case .duckOthers:
            return "DuckOthers"
        case .allowBluetooth:
            return "AllowBluetooth"
        case .defaultToSpeaker:
            return "DefaultToSpeaker"
        case .interruptSpokenAudioAndMixWithOthers:
            return "InterruptSpokenAudioAndMixWithOthers"
        case .allowBluetoothA2DP:
            return "AllowBluetoothA2DP"
        case .allowAirPlay:
            return "AllowAirPlay"
        }
    }
    
    var sessionOption: AVAudioSession.CategoryOptions {
        switch self {
        case .mixWithOthers:
            return .mixWithOthers
        case .duckOthers:
            return .duckOthers
        case .allowBluetooth:
            return .allowBluetooth
        case .defaultToSpeaker:
            return .defaultToSpeaker
        case .interruptSpokenAudioAndMixWithOthers:
            return .interruptSpokenAudioAndMixWithOthers
        case .allowBluetoothA2DP:
            return .allowBluetoothA2DP
        case .allowAirPlay:
            return .allowAirPlay
        }
    }
}

extension Set where Element == CategoryOption {
    var sessionOptions: AVAudioSession.CategoryOptions {
        return self.map { $0.sessionOption }.reduce(into: AVAudioSession.CategoryOptions()) { $0.insert($1) }
    }
}
