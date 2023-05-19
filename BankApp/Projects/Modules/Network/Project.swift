import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Network",
    targets: [.unitTest, .staticFramework],
    internalDependencies: [
        .core
    ]
)
