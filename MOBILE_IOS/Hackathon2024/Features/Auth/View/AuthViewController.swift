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
    private lazy var registrView = RegisterView()
    
    private lazy var currView: UIView = UIView()
    
    private let backgroundView = RadialGradientView()
    
// MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
    }
}

// MARK: - public extension
extension AuthViewController {
    func logInTapped() {
        
    }
    
    func registerTapped() {
        
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
                make.height.equalTo(600)
            }
        }
    }
    
    
}

// MARK: - objc extension
@objc private extension AuthViewController {
}

/// AuthViewModelProtocol?
