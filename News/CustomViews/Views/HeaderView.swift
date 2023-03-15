

import UIKit

final class HeaderView: UIView {
    private var fontSize: CGFloat
    private var sideMenuContainerView = UIView()
    
    private lazy var headingLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "News"
        v.font = UIFont.boldSystemFont(ofSize: fontSize)
        v.textColor = .black
        return v
    }()
    
    private lazy var menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuBarButtonItemTapped))
    
    @objc func menuBarButtonItemTapped() {
        
    }
    
    private lazy var headerCircleImage: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        v.image = UIImage(systemName: "circle.inset.filled", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        return v
    }()
    
    private lazy var pencilImage: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        v.image = UIImage(systemName: "pencil", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        return v
    }()
    
    private lazy var headerStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [headerCircleImage, headingLabel, pencilImage, sideMenuContainerView])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        return v
    }()
    
    
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(headerStackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        
        //News Header
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor, constant: 8),
            headerStackView.topAnchor.constraint(equalTo: topAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            /*
            sideMenuContainerView.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor, constant: 8),
            sideMenuContainerView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor, constant: -8),
            sideMenuContainerView.bottomAnchor.constraint(equalTo: headerStackView.bottomAnchor)
             */
        ])
        
    }
}
