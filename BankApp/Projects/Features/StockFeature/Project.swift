//
//  Project.swift
//  StockFeature
//
//  Created by devxsby on 2023/05/21.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "StockFeature",
    targets: [.unitTest, .staticFramework, .interface],
    internalDependencies: [],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
