//
//  AccountInformationModel.swift
//  Domain
//
//  Created by devxsby on 2023/05/25.
//  Copyright © 2023 BankApp. All rights reserved.
//

import UIKit

public struct AccountInformation {
    public let image: UIImage
    public let title: String
    public let subtitle: String
    public let buttonTitle: String?
    
    public init(image: UIImage, title: String, subtitle: String, buttonTitle: String?) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }
}
