import Foundation
import Chaining

class SessionController {
    let category = ValueHolder<Category>(.ambient)
    let mode = ValueHolder<Mode>(.default)
}
