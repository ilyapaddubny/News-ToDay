//
//  OnboardingModel.swift
//  News ToDay
//
//  Created by admins on 24.03.2024.
//

import UIKit

//MARK: - MockData

struct OnboardingMockData {
    static var firstMainLabel: String { NSLocalizedString("First to know", value: "First to know", comment: "First to know").localized }
    static var secondMainLabel: String { NSLocalizedString("World News", value: "World News", comment: "World News").localized }
    static var thirdMainLabel: String { NSLocalizedString("Customization", value: "Customization", comment: "Customization").localized }
    
    static var firstDescriptionlabel: String { NSLocalizedString("All news in one place, be the first to know last news", value: "All news in one place, be the first to know last news", comment: "All news in one place, be the first to know last news").localized }
    static var secondDescriptionlabel: String { NSLocalizedString("The most important news in different categories from different countries", value: "The most important news in different categories from different countries", comment: "The most important news in different categories from different countries").localized }
    static var thirdDescriptionlabel: String { NSLocalizedString("Customize your feeds to get anly topics you are interested in", value: "Customize your feeds to get anly topics you are interested in", comment: "Customize your feeds to get anly topics you are interested in").localized }
    
    static var nextButton: String { NSLocalizedString("nextButton", value: "Next", comment: "Next Button").localized }
    static var getStartedButton: String { NSLocalizedString("Get Started", value: "Get Started", comment: "FGet Started").localized }
    
}


//MARK: - Model

struct OnboardingModel {
    let mainImage: UIImage?
}
