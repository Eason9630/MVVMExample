
import Foundation

// 列舉不同的性別選項
enum Gender {
    case male, female, unspecified
}

// 代表一個人的結構體
struct Person {
    let name: String  // 姓名
    let birthday: Date?  // 生日，可選項
    let middleName: String?  // 中間名字，可選項
    let address: String?  // 住址，可選項
    let gender: Gender  // 性別，使用上面定義的列舉
    
    var userName = "Hello"  // 使用者名稱預設為 "Hello"
    
    // 初始化方法，可以指定不同的屬性值
    init(name: String, birthday: Date? = nil, middleName: String? = nil, address: String? = nil, gender: Gender = .unspecified) {
        self.name = name
        self.birthday = birthday
        self.middleName = middleName
        self.address = address
        self.gender = gender
    }
}
