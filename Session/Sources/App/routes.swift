import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works"
    router.get { req in
        return "Session service up and running"
    }
    
    // Example of configuring a controller
    let sessionController = SessionController.shared
    router.get("api", "session", use: sessionController.all)
    router.get("api", "session", String.parameter, use: sessionController.trigger)
    router.post("api", "session", use: sessionController.create)
    router.delete("api", "session", Session.parameter, use: sessionController.delete)
}
