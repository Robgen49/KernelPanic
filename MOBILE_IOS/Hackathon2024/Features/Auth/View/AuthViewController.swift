import UIKit
import SnapKit

enum ViewType {
    case registration
    case login
}

class AuthViewController: UIViewController {

//MARK: - Properties
    var viewModel: AuthViewModelProtocol?
    
    private var viewType: ViewType = .login
    private lazy var loginView = LoginView()
    public lazy var registrView = RegisterView()
    
    private lazy var currView: UIView = UIView()
    
    private let backgroundView = RadialGradientView()
    
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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - public extension
extension AuthViewController {
    func logInTapped(login: String, password: String) {
        viewModel?.logIn(login: login, password: password, completion: { result in
            result ? (self.viewModel?.appCoordinator?.goToHome()) : nil
        })
    }
    
    func registerTapped(team: Team) {
        
        Networking.signUp(team: team) { [weak self] result in
            if result {
                self?.changeView(to: .login)
            }
        }
    }
    
    func changeView(to: ViewType) {
        viewType = to
        if  to == .login {
           currView = loginView
            registrView.removeFromSuperview()
            addViews()
            layoutViews()
        }  else {
            currView = registrView
            loginView.removeFromSuperview()
            addViews()
            layoutViews()
        }
        view.layoutIfNeeded()
    }
}

// MARK: - private extension
private extension AuthViewController {
    func configure() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        currView = loginView
        backgroundView.frame = view.frame
        backgroundView.InsideColor = #colorLiteral(red: 0.8983470412, green: 0.9355988067, blue: 1, alpha: 0.9872572943)
        backgroundView.OutsideColor = .white
    }
    
    func addViews() {
        view.addSubview(backgroundView)
        [currView].forEach { backgroundView.addSubview($0) }
    }
    
    func layoutViews() {
        currView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            if self.viewType == .login {
                make.height.equalTo(400)
            } else {
                make.height.equalTo(view.frame.height)
            }
        }
    }
    
    
}

// MARK: - objc extension
@objc private extension AuthViewController {
}

/// AuthViewModelProtocol?
