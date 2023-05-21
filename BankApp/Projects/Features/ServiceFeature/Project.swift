//
//  Project.swift
//  ServiceFeature
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ServiceFeature",
    targets: [.unitTest, .staticFramework, .interface],
    internalDependencies: [],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
