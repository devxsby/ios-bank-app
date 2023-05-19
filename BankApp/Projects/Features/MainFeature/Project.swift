//
//  Project.swift
//  MainFeature
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "MainFeature",
    targets: [.unitTest, .staticFramework, .interface],
    internalDependencies: [
        .Features.Waiting.Interface,
        .Features.Banking.Interface,
        .Features.Setting.Interface
    ],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
