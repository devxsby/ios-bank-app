//
//  Project.swift
//  BankApp
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: "BankApp",
    targets: [.app, .unitTest],
    internalDependencies: [
        .data,
        .Features.RootFeature
    ]
)
