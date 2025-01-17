import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "DSKit",
    targets: [.unitTest, .dynamicFramework],
    internalDependencies: [
        .core
    ],
    hasResources: true
)
