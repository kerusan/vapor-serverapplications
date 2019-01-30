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
    
        return view.render("start", [
                "name": " till Boplats"
            ])
    }

}
