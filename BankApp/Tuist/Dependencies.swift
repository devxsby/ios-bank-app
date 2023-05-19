//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

import ConfigPlugin

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.0"))
], baseSettings: Settings.settings(
    configurations: XCConfig.framework
))

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: spm,
    platforms: [.iOS]
)
