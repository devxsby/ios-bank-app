import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Core",
    targets: [.unitTest, .dynamicFramework],
    internalDependencies: [
        .Modules.thirdPartyLibs
    ]
)
