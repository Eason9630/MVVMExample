
import UIKit

// 定義一個協議，用於處理 cell 點擊事件
protocol PersonFollowingTableViewCellDelegate: AnyObject {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

// 自定義的 UITableViewCell 類別
class PersonFollowingTableViewCell: UITableViewCell {
    // 設定 cell 的標識符
    static let identifier = "PersonFollowingTableViewCell"
    
    // 儲存代理，用於處理 cell 點擊事件
    weak var delegate: PersonFollowingTableViewCellDelegate?
    
    // 儲存 viewModel，用於配置 cell 的內容
    private var viewModel: PersonFollowingTableViewCellViewModel?
    
    // 用來顯示使用者頭像的 UIImageView
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 用來顯示姓名的 UILabel
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    // 用來顯示使用者名稱的 UILabel
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    // 用來執行 Follow / Unfollow 操作的按鈕
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // 初始化 cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(button)
        //將 contentView 的裁剪（clipping）功能打開
        contentView.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // 按鈕被點擊時的處理方法
    @objc private func didTapButton() {
        guard let viewModel = viewModel else {
            return
        }
        
        // 創建新的 viewModel，表示已變更的狀態
        var newViewModel = viewModel
        newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
        
        // 呼叫代理的方法，處理 cell 點擊事件
        delegate?.personFollowingTableViewCell(self, didTapWith: newViewModel)
        
        // 重置 cell 的狀態並重新配置
        prepareForReuse()
        configure(with: newViewModel)
    }
    
    // 使用 viewModel 來配置 cell 的內容
    func configure(with viewModel: PersonFollowingTableViewCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        userNameLabel.text = viewModel.userName
        userImageView.image = viewModel.image
        
        if viewModel.currentlyFollowing {
            button.setTitle("Unfollow", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
        } else {
            button.setTitle("Follow", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .link
        }
    }
    
    // 設定 cell 的 layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageWidth = contentView.frame.size.height - 10
        userImageView.frame = CGRect(x: 5, y: 5, width: imageWidth, height: imageWidth)
        nameLabel.frame = CGRect(x: imageWidth + 10, y: 0, width: contentView.frame.size.width - imageWidth, height: contentView.frame.size.height / 2)
        userNameLabel.frame = CGRect(x: imageWidth + 10, y: contentView.frame.size.height / 2, width: contentView.frame.size.width - imageWidth, height: contentView.frame.size.height / 2)
        button.frame = CGRect(x: contentView.frame.size.width - 120, y: 10, width: 110, height: contentView.frame.size.height - 20)
    }
    
    // 重置 cell 的狀態
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        userNameLabel.text = nil
        userImageView.image = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle("", for: .normal)
    }
}
