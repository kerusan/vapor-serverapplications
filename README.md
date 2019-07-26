## A Generalized micro service server environment in Swift Vapor

Version 0.1

This is some applications written in Swift / Vapor that will make up a generalized environment for a micro services
system. 

Right now there is a dummy Site generator, an datafetching Backend application and a Session application.
Later a Password quality application, an autorization/login Application, a Geo coding application and more.

The Site process is a HTML generator that uses the Backend Application for data retrieval. 

A Backend Application that uses FrontBase SQL92 server for its datastore. Was before and is easy
changable to SQLite or some other Fluent-based data store.

Then there is a Session application that is responsible for handling the sessions. 

Since this is 0.1 its not yet an integrated working soulutions. 
Also the FrontBase database adaptor/frameworks are not public open source either, but will be later. 
It is now working in our private developer environment with Vapor 3.0 but we are waiting for Vapor 4.0 
before we release it. The FrontBase Database Adaptor will then be open sourced.
