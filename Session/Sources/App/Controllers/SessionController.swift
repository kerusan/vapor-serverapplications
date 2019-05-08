import Vapor
import Fluent
import Dispatch
import DatabaseKit

/// Controls basic CRUD operations on `Session`s.
final class SessionController {

    static let shared = SessionController()

    var sessionArray: Array<Session>
    var timer: DispatchSourceTimer

    /// Initialize the controller
    init() {
        self.timer = DispatchSource.makeTimerSource()
        self.sessionArray = []
    }

    // *** Function for cancel old sessions ****************************************

    ///Cancel sessions that has has timed out
    func fetchSessions(app: Application) throws -> Array<Session> {
        var sessions: Array<Session> = []
        do {
            let conn = try app.requestPooledConnection(to: .free).wait()
            
            sessions = try Session.query(on: conn).all().wait()
            try app.releasePooledConnection(conn, to: .free)
        } catch {
            print("Fetching sessions did report an error.")
            print(error)
        }

        return sessions
    }

    // *** Function for configure and activatetimer ********************************

    /// Configure & activate timer
    func startTimer(app: Application) {
        timer.setEventHandler() {
            self.cancelSessions(app: app)
        }

        timer.schedule(deadline: .now() + .seconds(10), repeating: .seconds(10), leeway: .seconds(10))
        if #available(OSX 10.14.3, *) {
            timer.activate()
        }
        
        do {
            self.sessionArray = try fetchSessions(app: app)
        } catch {
            print(error)
        }
    }


    // *** Function for cancel old sessions ****************************************

    ///Cancel sessions that has has timed out
    func cancelSessions(app: Application) {
        print("Canceling")
        do {
            let conn = try app.requestPooledConnection(to: .free).wait()
               print(self.sessionArray.count)

            for i in stride(from: self.sessionArray.count - 1, to: -1, by: -1) {
                print(i)
                let sessionObject = self.sessionArray[i]
                let now = Date().addingTimeInterval(1)
                
                print(sessionObject.expires.string(format: "yyyy-MM-dd HH:mm:ss"))
                print(now.string(format: "yyyy-MM-dd HH:mm:ss"))
                if sessionObject.expires < now {
                    let representation = sessionObject.representation
                    print(representation)
                    self.removeFromSessionArray(session: sessionObject)
                    let _ = sessionObject.delete(on: conn)
                }
            }

            try app.releasePooledConnection(conn, to: .free)
        } catch {
            print(error)
        }
    }


    // *** Functions for routes *****************************************************

    /// Returns a list of all `Session`s.
    func all(_ request: Request) throws -> Future<[Session]> {
        return Session.query(on: request).all()
    }

    /// Returns a list of `Session`s that has a representation equal to the parameter. Triggers expiering date.
    func trigger(_ request: Request) throws -> Future<[Session]> {
        let sessionRepresentation = try request.parameters.next(String.self)
        let sessions = Session.query(on: request).filter(\.representation == sessionRepresentation).all()

        return sessions.flatMap { sessions in
            // Trigger session so it does get a new expiering date
            self.updateExpires(sessions: sessions, request: request)
            return request.future(sessions)
        }
    }

    /// Saves a decoded `Session` to the database.
    func create(_ request: Request) throws -> Future<Session> {
        return try request.content.decode(Session.self).flatMap { session in
            var newSession: Session
            
            newSession = Session(id: nil, exp: session.expires, representation: session.representation)

            self.sessionArray.append(newSession)
            print(self.sessionArray.count)
            return newSession.save(on: request)
        }
    }

    /// Deletes a parameterized `Session`.
    func delete(_ request: Request) throws -> Future<HTTPStatus> {
        let parameter = try request.parameters.next(Session.self)
        
        return parameter.flatMap { session -> Future<Void> in
            self.removeFromSessionArray(session: session)
            return session.delete(on: request)
        }.transform(to: .ok)
    }


    // *** Private functions for routes *********************************************

    // Updates the expires date
    func updateExpires(sessions: Array<Session>, request: Request) {
        if sessions.count == 1 {
            let sessionToUpdate: Session = sessions[0]
            sessionToUpdate.updateExpires()
            let _ = sessionToUpdate.save(on: request)
        }
    }

    // Removes session from the sessionArray
    func removeFromSessionArray(session: Session) {
        for i in stride(from: sessionArray.count - 1, to: -1, by: -1) {
            let sessionObject = sessionArray[i]
            if sessionObject.representation == session.representation {
                sessionArray.remove(at: i)
            }
        }
    }

}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
