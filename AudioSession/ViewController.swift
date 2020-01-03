import UIKit
import Chaining

class ViewController: UITableViewController {
    enum Section: Int, CaseIterable {
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
    
    weak var controller: SessionController?
    private var pool = ObserverPool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let controller = self.controller else { return }
        
        controller.category.chain().do { [weak self] _ in
            self?.tableView.reloadSections(.init(integer: Section.category.rawValue), with: .fade)
        }.sync().addTo(self.pool)
        
        controller.categoryOptions.chain().do { [weak self] _ in
            self?.tableView.reloadSections(.init(integer: Section.categoryOptions.rawValue), with: .fade)
        }.sync().addTo(self.pool)
        
        controller.mode.chain().do { [weak self] _ in
            self?.tableView.reloadSections(.init(integer: Section.mode.rawValue), with: .fade)
        }.sync().addTo(self.pool)
        
        controller.activation.chain().do { [weak self] _ in
            self?.tableView.reloadSections(.init(integer: Section.activation.rawValue), with: .fade)
        }.sync().addTo(self.pool)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError() }
        
        switch section {
        case .activation:
            return Activation.allCases.count
        case .category:
            return Category.allCases.count
        case .categoryOptions:
            return CategoryOption.allCases.count
        case .mode:
            return Mode.allCases.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        switch section {
        case .activation:
            guard let activation = Activation(rawValue: indexPath.row) else { fatalError() }
            
            guard let controller = self.controller else { break }
            let isEnabled = controller.activation.value.isActive != activation.isActive
            
            cell.textLabel?.text = activation.name
            cell.textLabel?.textColor = isEnabled ? .label : .quaternaryLabel
            cell.accessoryType = .none
            cell.selectionStyle = isEnabled ? .default : .none
        case .category:
            let category = Category.allCases[indexPath.row]
            cell.textLabel?.text = category.name
            cell.textLabel?.textColor = .label
            cell.accessoryType = (self.controller?.category.value == category) ? .checkmark : .none
            cell.selectionStyle = .default
        case .categoryOptions:
            let option = CategoryOption.allCases[indexPath.row]
            cell.textLabel?.text = option.name
            cell.textLabel?.textColor = .label
            cell.accessoryType = (self.controller?.categoryOptions.value.contains(option)) ?? false ? .checkmark : .none
            cell.selectionStyle = .default
        case .mode:
            let mode = Mode.allCases[indexPath.row]
            cell.textLabel?.text = mode.name
            cell.textLabel?.textColor = .label
            cell.accessoryType = (self.controller?.mode.value == mode) ? .checkmark : .none
            cell.selectionStyle = .default
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        guard let controller = self.controller else { return }
        
        switch section {
        case .activation:
            controller.activation.value = Activation.allCases[indexPath.row]
        case .category:
            controller.category.value = Category.allCases[indexPath.row]
        case .categoryOptions:
            controller.toggleCategoryOption(CategoryOption.allCases[indexPath.row])
        case .mode:
            controller.mode.value = Mode.allCases[indexPath.row]
        }
    }
}
