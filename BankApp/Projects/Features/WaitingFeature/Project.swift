//
//  Project.swift
//  WaitingFeature
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "WaitingFeature",
    targets: [.unitTest, .staticFramework, .interface],
    internalDependencies: [],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
