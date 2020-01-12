import SwiftUI

struct RowView: View {
    let text: String
    let isChecked: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    init(text: String, isChecked: Bool, isDisabled: Bool, action: @escaping () -> Void) {
        self.text = text
        self.isChecked = isChecked
        self.isDisabled = isDisabled
        self.action = action
    }
    
    init(text: String, isChecked: Bool, action: @escaping () -> Void) {
        self.text = text
        self.isChecked = isChecked
        self.isDisabled = false
        self.action = action
    }
    
    init(text: String, isSelected: Bool, action: @escaping () -> Void) {
        self.text = text
        self.isChecked = isSelected
        self.isDisabled = isSelected
        self.action = action
    }
    
    var body: some View {
        HStack {
            Button(action: self.action) { Text(self.text) }
                .disabled(self.isDisabled)
            
            if self.isChecked {
                Spacer()
                Image(systemName: "checkmark").foregroundColor(.accentColor)
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(text: "Text",
                isChecked: true,
                action: {})
            .previewLayout(.fixed(width: 320, height: 44))
    }
}
