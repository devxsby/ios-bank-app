//
//  Project.swift
//  Data
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Data",
    targets: [.unitTest, .staticFramework],
    internalDependencies: [
        .Modules.network,
        .Modules.database
    ]
)
