import Foundation
import Chaining

class SessionController {
    let category = ValueHolder<Category>(.playback)
    let mode = ValueHolder<Mode>(.default)
}
