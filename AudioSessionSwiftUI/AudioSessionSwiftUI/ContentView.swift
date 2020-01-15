//
//  ContentView.swift
//

import SwiftUI

private enum SessionSection: Int, CaseIterable {
    case activation
    case category
    case categoryOptions
    case mode
    
    var name: String {
        switch self {
        case .activation:
            return "Activation"
        case .category:
            return "Category"
        case .categoryOptions:
            return "CategoryOptions"
        case .mode:
            return "Mode"
        }
    }
}

struct ContentView: View {
    @ObservedObject var manager: SessionController
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(SessionSection.activation.name)) {
                    ForEach(Activation.allCases, id: \.self) { activation in
                        RowView(text: activation.name,
                                isChecked: self.manager.activation == activation,
                                isDisabled: self.manager.activation.isActive == activation.isActive) {
                                    self.manager.activation = activation
                        }
                    }
                }
                Section(header: Text(SessionSection.category.name)) {
                    ForEach(Category.allCases, id: \.self) { category in
                        RowView(text: category.name,
                                isSelected: self.manager.category == category) {
                                    self.manager.category = category
                        }
                    }
                }
                Section(header: Text(SessionSection.categoryOptions.name)) {
                    ForEach(CategoryOption.allCases, id: \.self) { categoryOption in
                        RowView(text: categoryOption.name,
                                isChecked: self.manager.categoryOptions.contains(categoryOption)) {
                                    self.manager.toggleCategoryOption(categoryOption)
                        }
                    }
                }
                Section(header: Text(SessionSection.mode.name)) {
                    ForEach(Mode.allCases, id: \.self) { mode in
                        RowView(text: mode.name,
                                isSelected: self.manager.mode == mode) {
                                    self.manager.mode = mode
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Audio Session", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(manager: SessionController())
    }
}
