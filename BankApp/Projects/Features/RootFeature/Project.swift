//
//  Project.swift
//  RootFeature
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "RootFeature",
    targets: [.unitTest, .staticFramework],
    internalDependencies: [
        .Features.Main.Feature,
        .Features.Waiting.Feature,
        .Features.Banking.Feature,
        .Features.Setting.Feature
    ]
)
