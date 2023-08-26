

import UIKit

// 定義一個 ViewModel 來表示 cell 的內容
struct PersonFollowingTableViewCellViewModel {
    let name: String
    let userName: String
    var currentlyFollowing: Bool
    let image: UIImage?
    
    // 初始化 ViewModel，根據傳入的 Person 物件來填充資料
    init(with model: Person) {
        name = model.name
        userName = model.userName
        currentlyFollowing = false // 初始情況下設定為未追蹤
        image = UIImage(systemName: "person") // 使用系統提供的圖片
    }
}
