import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // Your code here
    let sessionController = SessionController.shared
    sessionController.startTimer(app: app)
}
