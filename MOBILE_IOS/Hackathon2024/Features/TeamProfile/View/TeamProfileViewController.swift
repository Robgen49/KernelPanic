import UIKit
import SnapKit

enum profileType {
    case mine
    case other
}

class TeamProfileViewController: UIViewController {

    //MARK: - Properties
    var viewModel: TeamProfileViewModelProtocol?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = false
        
        return scrollView
    }()
    
    private func addLogOutButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.imageView?.tintColor = .black
        button.imageView?.snp.makeConstraints({ make in
            make.width.equalTo(30)
            make.height.equalTo(25)
        })
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        self.view.makeSystem(button)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private lazy var bannerImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Kernel panic"
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
        
        
        let skills = getFAQStack(text: "Стек технологий", placeholder: "Технологии", tag: 2, valueText: "")
        let proffesion = getFAQStack(text: "Направление", placeholder: "направление", tag: 3, valueText: "")
        let memberGrade = getFAQStack(text: "Оцените свой вклад в данной работе", placeholder: "вклад", tag: 4, valueText: "")
        let difficults = getFAQStack(text: "С какими трудностями столкнулись", placeholder: "трудности", tag: 5, valueText: "")
        
        [memberImageView, memberName, skills, proffesion, memberGrade, difficults].forEach {
            view.addSubview($0)
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(450)
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
        
        skills.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(memberImageView.snp.bottom).offset(20)
        }
        
        proffesion.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(skills.snp.bottom).offset(20)
        }
        
        memberGrade.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(proffesion.snp.bottom).offset(20)
        }
        
        difficults.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(memberGrade.snp.bottom).offset(20)
        }
        
        
//        memberCV.snp.makeConstraints { make in
//            make.top.equalTo(memberImageView.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(100)
//        }
        
        return view
    }
    
    func getFAQStack(text: String, placeholder: String, tag: Int, valueText: String) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        
        let textField = EditText()
        textField.textField.text = valueText
        textField.set(placeholder: placeholder)
        textField.textChanged(textField.textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
//        textField.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingDidEnd)
        textField.textField.tag = tag
        textField.isUserInteractionEnabled = false
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(textField)
        
        return stack
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
    
    private lazy var membersTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemberCell.self, forCellReuseIdentifier: "MemberCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()

// MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
        
        Networking.fetchCurrentTeam { result in
            //...
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - private extension
private extension TeamProfileViewController {
    func configure() {
        view.backgroundColor = #colorLiteral(red: 0.9489949346, green: 0.9488729835, blue: 0.9571836591, alpha: 1)
        addLogOutButton()
        
    }

    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(bannerImageView)
        scrollView.addSubview(titleLabel)
        view.addSubview(membersTable)
    }
    
    func layoutViews() {
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.right.equalTo(view).offset(-5)
            make.left.equalTo(view).offset(5)
            make.height.equalTo(view.frame.width * 0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
//        membersLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(10)
//        }
        
        membersTable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(view)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupData() {
        
    }
}

// MARK: - objc extension
@objc private extension TeamProfileViewController {
    func editBanner() {
        
    }
    
    func logout() {
        viewModel?.appCoordinator?.backToAuth()
    }
}

extension TeamProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.data.count //vm.team?.teammates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") as! MemberCell
        cell.setupData(image: vm.data[indexPath.item].0, fio: vm.data[indexPath.item].1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Участники"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MemberInfoViewController()
        self.present(vc, animated: true)
    }
}
