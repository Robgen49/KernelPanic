import UIKit

enum profileType {
    case mine
    case other
}

class TeamProfileViewController: UIViewController {

    //MARK: - Properties
    weak var viewModel: TeamProfileViewModelProtocol?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = false
        
        return scrollView
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let image = UIImage(named: "bannerTest")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Название команды"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var membersLabel: UILabel = {
       let label = UILabel()
        label.text = "Участники"
        label.textColor = .systemGray4
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    func getMemberView(tag: Int) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = tag
        
        let memberImage = UIImage(systemName: "person.crop.circle")
        let memberImageView = UIImageView(image: memberImage)
        memberImageView.translatesAutoresizingMaskIntoConstraints = false
        memberImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        memberImageView.clipsToBounds = true
        memberImageView.layer.cornerRadius = 30
        
        let memberName = UILabel()
        memberName.translatesAutoresizingMaskIntoConstraints = false
        memberName.text = "Фамилия Имя Отчество"
        memberName.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        memberName.numberOfLines = 0
        
        let memberCV = UITextView()
        memberCV.translatesAutoresizingMaskIntoConstraints = false
        memberCV.text = "Резюме тут он рассказывает про разные всякие приколы и штуки интересные ну типо длинный текст и надо качествено проверить размер"
        memberCV.isEditable = false
        memberCV.font = UIFont.systemFont(ofSize: 18)
        
        [memberImageView, memberName, memberCV].forEach {
            view.addSubview($0)
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        memberImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        memberName.snp.makeConstraints { make in
            make.left.equalTo(memberImageView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(memberImageView.snp.centerY)
        }
        
        memberCV.snp.makeConstraints { make in
            make.top.equalTo(memberImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        
        return view
    }
    
    private lazy var membersStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        var members: [UIView] = []
        for i in 1...5 {
            let member = getMemberView(tag: i)
            members.append(member)
        }
        members.forEach {
            stack.addArrangedSubview($0)
        }
        
        
        return stack
    }()
    
    func getEditButton(action: Selector, size: CGFloat) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Edit"), for: .normal)
        view.makeSystem(btn)
        btn.addTarget(self, action: action, for: .touchUpInside)
        
        btn.snp.makeConstraints { make in
            make.height.width.equalTo(size)
        }
        
        return btn
    }

// MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - private extension
private extension TeamProfileViewController {
    func configure() {
        view.backgroundColor = .white
    }

    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(bannerImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(membersLabel)
        scrollView.addSubview(membersStack)
    }
    
    func layoutViews() {
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalTo(view)
            make.height.equalTo(view.frame.width * 0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        membersLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        membersStack.snp.makeConstraints { make in
            make.top.equalTo(membersLabel.snp.bottom).offset(2)
            make.left.right.equalTo(view)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - objc extension
@objc private extension TeamProfileViewController {
    func editBanner() {
        
    }
}
