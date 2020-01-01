import Foundation
import AVFoundation
import Chaining

class SessionController {
    let category = ValueHolder<Category>(.playback)
    let mode = ValueHolder<Mode>(.default)
    
    private var session: AVAudioSession { return AVAudioSession.sharedInstance() }
    
    func activate() {
        try? self.session.setCategory(self.category.value.sessionCategory)
        try? self.session.setActive(true, options: [])
    }
    
    func deactivate() {
        try? self.session.setActive(false, options: [])
    }
}
