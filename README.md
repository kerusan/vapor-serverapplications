## A Generalized micro service server environment in Swift Vapor

Version 0.1

Here are some applications written in Swift / Vapor that will make up a generalized environment 
for a micro services system.

Right now there is a dummy Site generator application, a REST based datafetching Backend application and 
a Session application. Later there will be more services added, like a Password quality application, an 
autorization/login Application, a Geo coding application and probably several more.

The communication between the services is all done with the http protocol.

The Site process is a HTML generator that uses the Backend Application API for data retrieval. 

A Backend Application that uses FrontBase SQL92 server as its datastore. This is easy changable to 
SQLite or some other Fluent-based data store. It has the systems main Rest API for 
client access.

Then there is a Session application that is responsible for handling the sessions. It is supposed to be 
used a singeton instance process . Sessions are short lived (configurable) and database stored. This 
application has its own memory based local datastore but also one using FrontBase for persistance. Database 
storage is handled asynchronous for faster access to this service.

Since this is 0.1 it's not yet an integrated working solution. 
The FrontBase database adaptor/frameworks are also not public open source either, but will be later. 
It is now working in our private developer environment with Vapor 3.0 but we are waiting for Vapor 4.0 
before we release it open sourced. 
DM me for more information.

