//
//  OnboardingModel.swift
//  News ToDay
//
//  Created by admins on 24.03.2024.
//

import UIKit

//MARK: - MockData

enum OnboardingMockData {
    
    static let firstMainLabel = "First to know"
    static let secondMainLabel = "World News"
    static let thirdMainLabel = "News today"
    
    static let firstDescriptionlabel = "All news in one place, be the first to know last news"
    static let secondDescriptionlabel = "The most important news in different categories"
    static let thirdDescriptionlabel = "Read what is interesting and like"
    
    static let nextButton = "Next"
    static let getStartedButton = "Get Started"
}


//MARK: - Model

struct OnboardingModel {
    let mainImage: UIImage
}
