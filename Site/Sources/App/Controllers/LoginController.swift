//
//  LoginController
//  Site
//
//  Created by Kjell Nilsson on 2019-01-07.
//

import Foundation
import Vapor

final class LoginController {

    func login(request: Request) throws -> Future<View>  {
        var name = " till Oops - Var vänlig logga in"
        let hasParameters = request.parameters.values.count > 0

        if hasParameters {
            let parameter = try request.parameters.next(String.self)
            let parameterEncoded = parameter.removingPercentEncoding!
        
            name = parameterEncoded
        }

        let view = try request.view()
        let result = view.render("login", ["name": name])

        return result
    }
}
