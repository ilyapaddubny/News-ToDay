//
//  NewsVC.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 23.03.2024.
//

import UIKit
import Combine

class NewsViewController: BaseController {
    
    private var cancellable: AnyCancellable?
    
    let headerImageView = NewsHeaderImageView(frame: .zero)
    let dimmedView      = UIView()
    let newsTextView    = UITextView()
    let subtitleLabel   = NTDLabel(font: Font.interSemiBold(with: 16), textColor: .textPrimaryColor)
    let backButton      = UIButton()
    let bookmarkButton  = UIButton()
    let shareButton     = UIButton()
    let headerTextView  = NewsHeaderTextView()
    
    let category: String
    let article: Article
    
    
    init(category: String, article: Article) {
        self.category = category
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems(article: article, category: category)
        addTarget()
    }
    
    
    func configureItems(article: Article, category: String) {
        cancellable = loadImage(for: article).sink(receiveValue: { [unowned self] image in
            headerImageView.image = image
        })
        subtitleLabel.text  = article.description
        newsTextView.text   = article.content
        headerTextView.configure(category: category, article: article)
    }
    
    
    private func addTarget() {
        backButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    
    @objc private func dismissViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}


extension NewsViewController {
    
    override func addViews() {
        super.addViews()
        view.addSubviews(
            headerImageView,
            dimmedView,
            backButton,
            bookmarkButton,
            shareButton,
            headerTextView,
            newsTextView,
            subtitleLabel
        )
    }
    
    
    override func constraintViews() {
        super.constraintViews()
        
        let border: CGFloat = 24
        let offset: CGFloat = 20
        
        [subtitleLabel, newsTextView].forEach {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset)
            ])
        }
        
        [backButton, bookmarkButton, shareButton].forEach {
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: border),
                $0.widthAnchor.constraint(equalToConstant: border)
            ])
        }
        
        [headerImageView, headerTextView].forEach {
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),

            
            bookmarkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            bookmarkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            
            
            shareButton.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor, constant: 24),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            
            
            headerTextView.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: border),
            headerTextView.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            
            
            subtitleLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: border),
            
            
            newsTextView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            newsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        dimmedView.pinToEdges(of: headerImageView)
    }
    
    
    override func configureViews() {
            super.configureViews()
        navigationController?.navigationBar.isHidden = true
        
        dimmedView.backgroundColor = .black.withAlphaComponent(0.4)
        
        [backButton, bookmarkButton, shareButton].forEach {
            $0.backgroundColor = .clear
        }
       
        backButton.setImage(Image.arrowBackWhite, for: .normal)
        bookmarkButton.setImage(Image.bookmarkWhite, for: .normal)
        shareButton.setImage(Image.shareArrow, for: .normal)
        
        subtitleLabel.numberOfLines = 0
        
        newsTextView.textColor = .textSecondaryColor
        newsTextView.font = Font.interRegular(with: 16)
        newsTextView.isEditable = false
        newsTextView.textContainer.lineFragmentPadding = 0
    }
    
    private func loadImage(for article: Article) -> AnyPublisher<UIImage?, Never> {
        return Just(article.urlToImage)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: article.urlToImage ?? "") ?? URL(fileURLWithPath: "")
                return ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
        }
}
