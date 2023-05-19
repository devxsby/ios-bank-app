//
//  Project.swift
//  Domain
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Domain",
    targets: [.unitTest, .dynamicFramework],
    internalDependencies: [
        .core
    ]
)
