import UIKit
import Chaining

class CategoriesViewController: UITableViewController {
    weak var controller: SessionController?
    private var pool = ObserverPool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let controller = self.controller else { return }
        
        let observer = controller.category.chain().do { [weak self] _ in
            self?.tableView.reloadSections(.init(integer: 0), with: .fade)
        }.sync()
        
        self.pool.add(observer)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = Category.allCases[indexPath.row]
        cell.textLabel?.text = category.name
        cell.accessoryType = (self.controller?.category.value == category) ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = Category.allCases[indexPath.row]
        self.controller?.category.value = category
    }
}
