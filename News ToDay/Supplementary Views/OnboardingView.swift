//
//  OnboardingViewController.swift
//  News ToDay
//
//  Created by admins on 22.03.2024.
//

import UIKit

//MARK: - OnboardingVC Delegate

protocol OnboardingViewProtocol: AnyObject {
    func actionButtonPressed()
}


final class OnboardingView: UIView {
    
    
    //MARK: - UI

    private let collectionView: UICollectionView = {
        let layout = CarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 288, height: 336)
        layout.sideItemAlpha = 1
        layout.sideItemScale = 0.68
        layout.spacingMode = .fixed(spacing: 28)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.idOnboardingCell)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        pageControl.isEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    private let mainLabel = CustomLabel(text: OnboardingMockData.firstMainLabel,
                                        textColor: .black,
                                        font: UIFont.size(Constants.textSize, weight: .bold))
//                                        font: Font.getFont(.bold, size: 24))
    
    private let descriptionLabel = CustomLabel(text: OnboardingMockData.firstDescriptionlabel)
    
    private lazy var actionButton = BlueButton(text: OnboardingMockData.nextButton)
    
    private enum Constants {
      static let textSize: CGFloat = 14
    }
    
    
    //MARK: - Properties
    
    private var collectionItem = 0
    private var onboardingArray = [OnboardingModel]()
    weak var delegate: OnboardingViewProtocol?
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingView: UICollectionViewDelegate {
    
}


//MARK: - UICollectionViewDataSource

extension OnboardingView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.idOnboardingCell, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        
        let model = onboardingArray[indexPath.row]
        cell.cellConfigure(model: model)
        
        return cell
    }
}


//MARK: - Public Methods

extension OnboardingView {
    
    @objc func actionButtonPressed() {
        switch collectionItem {
        case 0:
            nextPage()
            mainLabel.text = OnboardingMockData.secondMainLabel
            descriptionLabel.text = OnboardingMockData.secondDescriptionlabel
        case 1:
            nextPage()
            mainLabel.text = OnboardingMockData.thirdMainLabel
            descriptionLabel.text = OnboardingMockData.thirdDescriptionlabel
            actionButton.setTitle(OnboardingMockData.getStartedButton, for: .normal)
        case 2:
            delegate?.actionButtonPressed()
        default: break
        }
    }
}


//MARK: - Private Methods

private extension OnboardingView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        configureCollectionView()
        configurePageControl()
        setDelegates()
        setConstraints()
    }
    
    
    func configureCollectionView() {
        
        let firstScreen = OnboardingModel(mainImage: .firstScreen)
        let secondScreen = OnboardingModel(mainImage: .secondScreen)
        let thirdScreen = OnboardingModel(mainImage: .firstScreen)

        onboardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    
    
    func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    func setupViews() {
        let views = [collectionView, pageControl, mainLabel, descriptionLabel, actionButton]
        views.forEach { addSubview($0) }
        
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
    
    
    func nextPage() {
        collectionItem += 1
        let index: IndexPath = [0, collectionItem]
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = collectionItem
    }
    
    
    func configurePageControl() {
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .textSecondaryColor
        pageControl.currentPageIndicatorTintColor = .buttonActiveColor
        
//        if #available(iOS 14.0, *) {
//            pageControl.preferredIndicatorImage = .largeIndicator
//        }
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            
            mainLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 34),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
