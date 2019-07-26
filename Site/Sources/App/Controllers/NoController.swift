//
//  NoController.swift
//  Site
//
//  Created by Kjell Nilsson on 2019-01-07.
//

import Foundation
import Vapor

/// Login operations
final class NoController {

    public func noroute(request: Request) throws -> Future<View>  {
        let view = try request.view()
    
        return view.render("login", [
                "name": " till Boplats"
            ])
    }

    public func test(request: Request) throws -> Future<View>  {
        let view = try request.view()
        let result = view.render("test")
    
        return result
    }
}
