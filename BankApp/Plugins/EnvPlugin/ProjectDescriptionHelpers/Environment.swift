import ProjectDescription

public enum Environment {
    public static let workspaceName = "BankApp"
}

public extension Project {
    enum Environment {
        public static let workspaceName = "BankApp"
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "15.0", devices: [.iphone])
        public static let platform = Platform.iOS
        public static let bundlePrefix = "com.devxsby"
    }
}
