import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "DataBase",
    targets: [.unitTest, .staticFramework],
    internalDependencies: [
        .domain
    ]
)
