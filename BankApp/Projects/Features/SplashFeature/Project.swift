//
//  Project.swift
//  SplashFeature
//
//  Created by devxsby on 2023/05/21.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "SplashFeature",
    targets: [.unitTest, .staticFramework, .interface],
    internalDependencies: [
        .Features.Main.Interface
    ],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
