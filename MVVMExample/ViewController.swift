

import UIKit

// 負責展示一個人列表的視圖控制器
class ViewController: UIViewController, UITableViewDataSource {
    
    // 儲存要展示的人的資料
    private var models = [Person]()
    
    // 建立一個用來顯示人列表的 UITableView
    private let tableView: UITableView = {
        let table = UITableView()
        // 註冊自定義的 cell
        table.register(PersonFollowingTableViewCell.self, forCellReuseIdentifier: PersonFollowingTableViewCell.identifier)
        return table
    }()
    
    // 視圖載入完成時的處理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化人的資料
        configureModels()
        
        // 將 tableView 加到視圖中
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    // 初始化人的資料
    private func configureModels() {
        let names = ["Joe", "Eason", "Sandy", "Allen"]
        for name in names {
            models.append(Person(name: name))
        }
    }
    
    // 設定 tableView 中的 section 的行數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    // 設定 tableView 中每一個 cell 的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        // 取得自定義的 cell，如果無法取得則返回預設的 cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingTableViewCell.identifier,
                                                       for: indexPath) as? PersonFollowingTableViewCell else {
            return UITableViewCell()
        }
        // 使用 cell 的 viewModel 來配置 cell
        cell.configure(with: PersonFollowingTableViewCellViewModel(with: model))
        cell.delegate = self
        
        return cell
    }
}

// 處理 PersonFollowingTableViewCell 的代理方法
extension ViewController: PersonFollowingTableViewCellDelegate {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
        // 這裡可以處理 cell 被點擊的情況
    }
}
