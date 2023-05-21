import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "ThirdPartyLibs",
    targets: [.dynamicFramework],
    externalDependencies: [.external(name: "SnapKit")]
//    dependencies: [.external(name: "SnapKit")]
)
