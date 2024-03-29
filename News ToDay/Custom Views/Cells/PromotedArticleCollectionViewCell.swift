//
//  PromotedNewsCollectionViewCell.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 19.03.2024.
//

import UIKit
import Combine

class PromotedArticleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier  = "PromotedArticleCollectionViewCell"
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    private var article: Article? = nil
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = UIColor.random
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let bookmarkView: UIImageView = {
        let imageView = UIImageView(image: Icons.bookmarkStroke)
        return imageView
    }()
    
//    var isBookmarked: Bool = false {
//        didSet {
//            let bookmarkImage = isBookmarked ? Icons.bookmarkFilled : Icons.bookmarkStroke
//            bookmarkView.image = bookmarkImage
//            
//        }
//    }
    
    let dimmerView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .black
        imageView.layer.opacity = 0.5
        return imageView
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 17)
        label.textColor = .textOnImageSecondaryColor
        label.numberOfLines = 2
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 13)
        label.textColor = .textOnImageSecondaryColor
        label.numberOfLines = 1
        
        return label
    }()
    
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelStackView.addArrangedSubview(categoryLabel)
        labelStackView.addArrangedSubview(headlineLabel)
        bookmarkView.image = (article?.isBookmarked ?? false) ? Icons.bookmarkFilled : Icons.bookmarkStroke
        configureLayout()
        
        bookmarkView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped))
        bookmarkView.addGestureRecognizer(tapGesture)
    }
    
    func configureLayout() {
        addSubview(imageView)
        addSubview(dimmerView)
        addSubview(bookmarkView)
        addSubview(labelStackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dimmerView.translatesAutoresizingMaskIntoConstraints = false
        bookmarkView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            dimmerView.topAnchor.constraint(equalTo: topAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            bookmarkView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            bookmarkView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bookmarkView.heightAnchor.constraint(equalToConstant: 30),
            bookmarkView.widthAnchor.constraint(equalTo: bookmarkView.heightAnchor),
            
            labelStackView.heightAnchor.constraint(equalToConstant: 70),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
    }
    
    @objc func bookmarkTapped() {
        //TODO: implement bookmark logic here
        article?.isBookmarked.toggle()
//        isBookmarked.toggle()
        
        bookmarkView.image = (article?.isBookmarked ?? false) ? Icons.bookmarkFilled : Icons.bookmarkStroke
    }
    
    
    func configureCellWith(_ article: Article) {
        self.article = article
        bookmarkView.image = article.isBookmarked ? Icons.bookmarkFilled : Icons.bookmarkStroke
//        categoryLabel.text = article.description ?? "no description"
        categoryLabel.text = "entertainment".capitalized
        headlineLabel.text = article.title
        cancellable = loadImage(for: article).sink(receiveValue: { [unowned self] image in
            showImage(image: image)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
