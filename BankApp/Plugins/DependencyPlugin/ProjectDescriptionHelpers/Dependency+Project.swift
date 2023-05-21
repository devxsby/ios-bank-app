//
//  Dependency+Project.swift
//  MyPlugin
//
//  Created by devxsby on 2023/05/19.
//

import ProjectDescription

public typealias Dep = TargetDependency

public extension Dep {
    struct Features {
        public struct Main {}
        public struct Service {}
        public struct Banking {}
        public struct Stock {}
        public struct Setting {}
    }
    
    struct Modules {}
}

// MARK: - Root

public extension Dep {
    static let data = Dep.project(target: "Data", path: .data)

    static let domain = Dep.project(target: "Domain", path: .domain)
        
    static let core = Dep.project(target: "Core", path: .core)
}

// MARK: - Modules

public extension Dep.Modules {
    static let dsKit = Dep.project(target: "DSKit", path: .relativeToModules("DSKit"))
    
    static let network = Dep.project(target: "Network", path: .relativeToModules("Network"))
    
    static let database = Dep.project(target: "DataBase", path: .relativeToModules("DataBase"))
    
    static let thirdPartyLibs = Dep.project(target: "ThirdPartyLibs", path: .relativeToModules("ThirdPartyLibs"))
}

// MARK: - Features

public extension Dep.Features {
    static func project(name: String, group: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }
    
    static let BaseFeatureDependency = TargetDependency.project(target: "BaseFeatureDependency", path: .relativeToFeature("BaseFeatureDependency"))
    
    static let RootFeature = TargetDependency.project(target: "RootFeature", path: .relativeToFeature("RootFeature"))
}

public extension Dep.Features.Main {
    static let group = "Main"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.Service {
    static let group = "Service"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.Banking {
    static let group = "Banking"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.Stock {
    static let group = "Stock"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.Setting {
    static let group = "Setting"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}
