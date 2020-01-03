import Foundation
import AVFoundation
import Chaining

class SessionController {
    let category = ValueHolder<Category>(.playback)
    let categoryOptions = ValueHolder<Set<CategoryOption>>([])
    let mode = ValueHolder<Mode>(.default)
    let activation = ValueHolder<Activation>(.deactive)
    
    private var session: AVAudioSession { return AVAudioSession.sharedInstance() }
    private let pool = ObserverPool()
    
    init() {
        self.activation.chain().do { [weak self] value in
            switch value {
            case .active:
                self?.activate()
            case .deactive:
                self?.deactivate()
            case .deactiveWithNotifyOthers:
                self?.deactivateAndNotifyOthers()
            }
        }.end().addTo(self.pool)
    }
    
    func toggleCategoryOption(_ option: CategoryOption) {
        var options = self.categoryOptions.value
        
        if options.contains(option) {
            options.remove(option)
        } else {
            options.insert(option)
        }
        
        self.categoryOptions.value = options
    }
    
    private func activate() {
        try? self.session.setCategory(self.category.value.sessionCategory, mode: self.mode.value.sessionMode, options: self.categoryOptions.value.sessionOptions)
        try? self.session.setActive(true, options: [])
    }
    
    private func deactivate() {
        try? self.session.setActive(false, options: [])
    }
    
    private func deactivateAndNotifyOthers() {
        try? self.session.setActive(false, options: [.notifyOthersOnDeactivation])
    }
}
