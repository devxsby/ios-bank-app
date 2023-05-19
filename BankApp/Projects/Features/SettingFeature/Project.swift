//
//  Project.swift
//  SettingFeature
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "SettingFeature",
    targets: [.unitTest, .staticFramework, .interface],
    internalDependencies: [
        
    ],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)
