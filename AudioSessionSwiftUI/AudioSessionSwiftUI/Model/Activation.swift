import Foundation

enum Activation: Int, CaseIterable {
    case active
    case deactive
    case deactiveWithNotifyOthers
    
    var isActive: Bool {
        switch self {
        case .active:
            return true
        case .deactive:
            return false
        case .deactiveWithNotifyOthers:
            return false
        }
    }
    
    var name: String {
        switch self {
        case .active:
            return "Active"
        case .deactive:
            return "Deactive"
        case .deactiveWithNotifyOthers:
            return "Deactive with notify others"
        }
    }
}
