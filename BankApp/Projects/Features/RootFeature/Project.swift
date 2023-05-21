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
        .Features.Splash.Feature,
        .Features.Main.Feature,
        .Features.Service.Feature,
        .Features.Banking.Feature,
        .Features.Stock.Feature,
        .Features.Setting.Feature
    ]
)
