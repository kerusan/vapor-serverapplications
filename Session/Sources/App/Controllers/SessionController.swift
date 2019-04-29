import Vapor
import Fluent
import Dispatch
import DatabaseKit

/// Controls basic CRUD operations on `Session`s.
final class SessionController {

    var sessionArray: Array<Session>
    var timer: DispatchSourceTimer

    /// Initialize the controller
    init() {
        do {
            self.timer = DispatchSource.makeTimerSource()
            self.sessionArray = []
            self.sessionArray = try fetchSessions()
        } catch {
            print("Problem fetching sessions")
        }

        startTimer()
        print("Timer created")
    }

    // *** Function for cancel old sessions ****************************************

    ///Cancel sessions that has has timed out
    func fetchSessions() throws -> Array<Session> {
        let app = try Application()
        let conn = try app.requestPooledConnection(to: .uaf).wait()

        let sessions = try Session.query(on: conn).all().wait()

        do {
            try app.releasePooledConnection(conn, to: .uaf)
        } catch {
            print("Outch")
        }

        return sessions
    }

    // *** Function for configure and activatetimer ********************************

    /// Configure & activate timer
    func startTimer() {
        timer.setEventHandler() {
            self.cancelSessions()
        }

        timer.schedule(deadline: .now() + .seconds(5), repeating: .seconds(10), leeway: .seconds(10))
        if #available(OSX 10.14.3, *) {
            timer.activate()
        }
    }


    // *** Function for cancel old sessions ****************************************

    ///Cancel sessions that has has timed out
    func cancelSessions() {
        print("Cancel sessions")

        do {
            print("Find pooled connection")
           let app = try Application()
            let conn = try app.newConnection(to: .sqlite).wait()
            print("Done pooled connection")

            for i in stride(from: sessionArray.count - 1, to: 0, by: -1) {
                let sessionObject = sessionArray[i]
                let now = Date().addingTimeInterval(100)
                if sessionObject.expires < now {
                    let representation = sessionObject.representation
                    print(representation)
                    self.removeFromSessionArray(session: sessionObject)
                    let _ = sessionObject.delete(on: conn)
                }
            }

            try app.releasePooledConnection(conn, to: .uaf)
        } catch {
            print(error)
        }
    }


    // *** Functions for routes *****************************************************

    /// Returns a list of all `Session`s.
    func all(_ request: Request) throws -> Future<[Session]> {
        return Session.query(on: request).all()
    }

    /// Returns a list of `Session`s that has a representation equal to the parameter.
    func trigger(_ request: Request) throws -> Future<[Session]> {
        let sessionRepresentation = try request.parameters.next(String.self)
        let sessions = Session.query(on: request).filter(\.representation == sessionRepresentation).all()

        return sessions.flatMap { sessions in
            print("Trigger session")
            self.updateExpires(sessions: sessions, request: request)
            return request.future(sessions)
        }
    }

    /// Saves a decoded `Session` to the database.
    func create(_ request: Request) throws -> Future<Session> {
        return try request.content.decode(Session.self).flatMap { session in
            print("Creating session")
            var newSession = session
            if (newSession.id != nil) {
                let stringRepresentation = self.hashString()
                newSession = Session(id: nil, representation: stringRepresentation)
            }
            self.sessionArray.append(newSession)
            return newSession.save(on: request)
        }
    }

    /// Deletes a parameterized `Session`.
    func delete(_ request: Request) throws -> Future<HTTPStatus> {
        let parameter = try request.parameters.next(Session.self)
        return parameter.flatMap { session -> Future<Void> in
            print("Deleting session")
            self.removeFromSessionArray(session: session)
            return session.delete(on: request)
        }.transform(to: .ok)
    }


    // *** Private functions for routes *********************************************

    // Creates a string hashvalue
    func hashString() -> String {
        var stringRepresentation = "\(Date().hashValue)"
        if stringRepresentation.hasPrefix("-") {
            stringRepresentation.remove(at: stringRepresentation.startIndex)
        }
        return stringRepresentation
    }

    // Updates the expires date
    func updateExpires(sessions: Array<Session>, request: Request) {
        if sessions.count == 1 {
            let sessionToUpdate: Session = sessions[0]
            sessionToUpdate.updateExpires()
            let _ = sessionToUpdate.save(on: request)
        }
        print("Array: \(sessionArray)")
    }

    // Removes session from the sessionArray
    func removeFromSessionArray(session: Session) {
        for i in stride(from: sessionArray.count - 1, to: 0, by: -1) {
            let sessionObject = sessionArray[i]
            if sessionObject.representation == session.representation {
                sessionArray.remove(at: i)
            }
        }
    }

}

