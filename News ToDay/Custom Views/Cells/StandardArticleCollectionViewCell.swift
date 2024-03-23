//
//  RowNewsCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit
import Combine

class StandardArticleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "StandardArticleCollectionViewCell"
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 17
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12.0
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageView.backgroundColor = UIColor.random
        
        return imageView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 17)
        label.textColor = .textPrimaryColor
        label.numberOfLines = 2
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 15)
        label.textColor = .textSecondaryColor
        label.numberOfLines = 1
        
        return label
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.addArrangedSubview(imageView)
        labelStackView.addArrangedSubview(categoryLabel)
        labelStackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(labelStackView)
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellWith(_ article: Article) {
        headlineLabel.text = article.title
        categoryLabel.text = article.description ?? "no description"
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0
        cancellable = loadImage(for: article).sink(receiveValue: { [unowned self] image in
            showImage(image: image)
        })
        
    }
    
    
    private func showImage(image: UIImage?) {
        imageView.alpha = 0.0
        animator?.stopAnimation(false)
        imageView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.imageView.alpha = 1.0
        })
    }
    
    private func loadImage(for article: Article) -> AnyPublisher<UIImage?, Never> {
        return Just(article.urlToImage)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: article.urlToImage ?? "") ?? URL(fileURLWithPath: "")
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
        }
    
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
}
