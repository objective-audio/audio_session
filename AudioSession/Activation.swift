import Foundation

enum Activation: Int, CaseIterable {
    case active
    case deactive
    
    var isActive: Bool {
        switch self {
        case .active:
            return true
        case .deactive:
            return false
        }
    }
    
    var name: String {
        switch self {
        case .active:
            return "Active"
        case .deactive:
            return "Deactive"
        }
    }
}
