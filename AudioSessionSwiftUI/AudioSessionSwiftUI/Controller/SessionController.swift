//
//  SessionController.swift
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

class SessionController: ObservableObject {
    @Published var activation: Activation = .deactive
    @Published var category: Category = .playback
    @Published var categoryOptions: Set<CategoryOption> = []
    @Published var mode: Mode = .default
    
    private var cancellable: AnyCancellable!
    
    init() {
        self.cancellable = self.$activation.sink { [weak self] activation in
            switch activation {
            case .active:
                self?.activate()
            case .deactive:
                self?.deactivate()
            case .deactiveWithNotifyOthers:
                self?.deactivateAndNotifyOthers()
            }
        }
    }
    
    private var session: AVAudioSession { return AVAudioSession.sharedInstance() }
    
    func toggleCategoryOption(_ option: CategoryOption) {
        var options = self.categoryOptions
        
        if options.contains(option) {
            options.remove(option)
        } else {
            options.insert(option)
        }
        
        self.categoryOptions = options
    }
    
    private func activate() {
        try? self.session.setCategory(self.category.sessionCategory, mode: self.mode.sessionMode, options: self.categoryOptions.sessionOptions)
        try? self.session.setActive(true, options: [])
    }
    
    private func deactivate() {
        try? self.session.setActive(false, options: [])
    }
    
    private func deactivateAndNotifyOthers() {
        try? self.session.setActive(false, options: [.notifyOthersOnDeactivation])
    }
}
