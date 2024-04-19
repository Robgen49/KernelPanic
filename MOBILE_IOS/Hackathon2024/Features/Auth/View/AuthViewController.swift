import UIKit

class AuthViewController: UIViewController {

//MARK: - Properties
    weak var viewModel: AuthViewModelProtocol?
    
// MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
    }
}

// MARK: - private extension
private extension AuthViewController {
    func configure() {
        view.backgroundColor = .green
    }
    
    func addViews() {
        
    }
    
    func layoutViews() {
        
    }
}

// MARK: - objc extension
@objc private extension AuthViewController {
    
}

/// AuthViewModelProtocol?
