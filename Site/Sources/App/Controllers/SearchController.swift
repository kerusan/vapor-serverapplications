//
//  SearchController.swift
//  Site
//
//  Created by Kjell Nilsson on 2019-01-07.
//

import Foundation
import Vapor
import HTTP

struct User: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var password: String
}

final class SearchController {

    func search(request: Request) throws -> Future<View> {
        var query = "Sök användare"
        let hasParameters = request.parameters.values.count > 0

        if hasParameters {
            let parameter = try request.parameters.next(String.self)
            let parameterEncoded = parameter.removingPercentEncoding!

            query = "i " + parameterEncoded

            // Connect a new client to the supplied hostname.
            let httpClientFuture = HTTPClient.connect(hostname: "localhost", port: 8081, on: request)

            // Create an HTTP request: GET /
            let backendRequest = HTTPRequest(method: .GET, url: "/api/users/\(parameterEncoded)")

            return httpClientFuture.flatMap (to: HTTPResponse.self) { httpClient in
                // Send the HTTP request
                return httpClient.send(backendRequest)
            }.flatMap() { backendResponse in
                // Get the HTTP response
                let jsonData = backendResponse.body.description
                
                // Decode the body
                let jsonDecoder = JSONDecoder()
                let users = try jsonDecoder.decode(Array<User>.self, from: jsonData)
                let hasUsers = request.parameters.values.count < 0 || users.count == 1

                // Create the content to the view
                let view = try request.view()
                if hasUsers {
                    let user = users[0]
                    let result = view.render("search", ["user": user])
                    return result
                } else {
                    let error = " • Det finns ingen användare med det nummret •"
                    let result = view.render("search", ["error": error])
                    return result
                }
            }
        } else {
            query = "Fel i sökningen"
            let view = try request.view()
            let error = " • Detta gick fruktansvärt fel, ingen sökparameter •"
            let result = view.render("search", ["query": query, "error": error])
            return result
        }
    }
}

