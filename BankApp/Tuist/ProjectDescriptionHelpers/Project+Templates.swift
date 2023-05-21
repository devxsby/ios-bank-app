import ProjectDescription
import DependencyPlugin
import EnvPlugin

public extension Project {
    
    static func makeModule(
        name: String,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest]),
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        dependencies: [TargetDependency] = [],
        hasResources: Bool = false
    ) -> Project {
        
        let hasDynamicFramework = targets.contains(.dynamicFramework)
        let deploymentTarget = Environment.deploymentTarget
        let platform = Environment.platform
        
        let baseSettings: SettingsDictionary = SettingsDictionary.baseSettings

//        let settings: Settings = .settings(
//            base: [:],
//            configurations: [
//                .debug(name: .debug),
//                .release(name: .release)
//            ], defaultSettings: .recommended)

        var projectTargets: [Target] = []
        var schemes: [Scheme] = []
        
        // MARK: - App Target
        
        if targets.contains(.app) {
            let infoPlist = Project.appInfoPlist
            
            let target = Target(
                name: name,
                platform: platform,
                product: .app,
                bundleId: "\(Environment.bundlePrefix).\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Sources/**/*.swift"],
                resources: [.glob(pattern: "Resources/**", excluding: [])],
//                scripts: [.SwiftLintShell],
                dependencies: [
                    internalDependencies,
                    externalDependencies
                ]
                    .flatMap { $0 },
                settings: .settings(base: baseSettings)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Feature Interface

        if targets.contains(.interface) {
            
            let target = Target(
                name: "\(name)Interface",
                platform: platform,
                product:.framework,
                bundleId: "\(Environment.bundlePrefix).\(name)Interface",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Interface/Sources/*.swift"],
                scripts: [],
                dependencies: interfaceDependencies,
                settings: .settings(base: baseSettings)
            )
            
            projectTargets.append(target)
        }

        // MARK: - Framework

        if targets.contains(where: { $0.hasFramework }) {
            let deps: [TargetDependency] = targets.contains(.interface)
            ? [.target(name: "\(name)Interface")]
            : []
            
            let target = Target(
                name: name,
                platform: platform,
                product: hasDynamicFramework ? .framework : .staticFramework,
                bundleId: "\(Environment.bundlePrefix).\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**/*.swift"],
                resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
//                scripts: [.SwiftLintShell],
                dependencies: deps + internalDependencies + externalDependencies,
                settings: .settings(base: baseSettings)
            )
            
            projectTargets.append(target)
        }

        // MARK: - Unit Tests
        
        if targets.contains(.unitTest) {
            
            let target = Target(
                name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "\(Environment.bundlePrefix).\(name)Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                dependencies: dependencies,
                settings: .settings(base: baseSettings)
            )
            
            projectTargets.append(target)
        }
        
        return Project(
            name: name,
            organizationName: Environment.workspaceName,
            packages: packages,
            settings: .settings(base: baseSettings),
            targets: projectTargets,
            schemes: schemes
        )
    }
}

extension Scheme {
    
    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }
}
