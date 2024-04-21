import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource {

//MARK: - Properties
    var viewModel: HomeViewModelProtocol?
    
    private lazy var teamProfileButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
        btn.setTitle("  Моя команда", for: .normal)
        btn.imageView?.tintColor = .white
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        btn.addTarget(self, action: #selector(openProfileVC), for: .touchUpInside)
        
        view.makeSystem(btn)
        
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowlayout = StackFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()

// MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        layoutViews()
        Networking.fetchTeams{ (teams,result) in
            self.viewModel?.teams = teams ?? []
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(row: 5023, section: 0), at: .centeredVertically, animated: false)
        }
        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10048
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let itemToShow = dataSource[indexPath.row % dataSource.count]
        guard let teams = viewModel?.teams, teams.count > 0 else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
            cell.setupCell(team: nil)
            return cell
        }
        var itemToShow: String = ""
        
        let team = teams[indexPath.row % teams.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        cell.setupCell(team: team)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width - 10, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openProfileVC() 
    }
    
}

// MARK: - private extension
private extension HomeViewController {
    func configure() {
        view.backgroundColor = .black
        
        navigationController?.isNavigationBarHidden = true
    }

    func addViews() {
        view.addSubview(collectionView)
        view.addSubview(teamProfileButton)
    }

    func layoutViews() {
        
        teamProfileButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(teamProfileButton.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}

// MARK: - objc extension
@objc private extension HomeViewController {
    func openProfileVC() {
        viewModel?.appCoordinator?.goToTeamProfile()
    }
}

