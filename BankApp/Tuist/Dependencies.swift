//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0"))
], baseSettings: Settings.settings())

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: spm,
    platforms: [.iOS]
)
