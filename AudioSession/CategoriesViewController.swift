import UIKit
import Chaining

class CategoriesViewController: UITableViewController {
    enum Section: Int, CaseIterable {
        case category
        case mode
        
        var name: String {
            switch self {
            case .category:
                return "Category"
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
        
        controller.mode.chain().do { [weak self] _ in
            self?.tableView.reloadSections(.init(integer: Section.mode.rawValue), with: .fade)
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
        case .category:
            return Category.allCases.count
        case .mode:
            return Mode.allCases.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        switch section {
        case .category:
            let category = Category.allCases[indexPath.row]
            cell.textLabel?.text = category.name
            cell.accessoryType = (self.controller?.category.value == category) ? .checkmark : .none
        case .mode:
            let mode = Mode.allCases[indexPath.row]
            cell.textLabel?.text = mode.name
            cell.accessoryType = (self.controller?.mode.value == mode) ? .checkmark : .none
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
        case .category:
            let category = Category.allCases[indexPath.row]
            self.controller?.category.value = category
        case .mode:
            let mode = Mode.allCases[indexPath.row]
            self.controller?.mode.value = mode
        }
    }
}
