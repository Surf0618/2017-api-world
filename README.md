# 2017-api-world
this is a repo for 2017 Api World with TJBot hacks. If you like it - give me a star


If you work with [IBM Kitura](http://kitura.io) please update the ```Package.swift`` with the following line relative to calling:
```swift
import PackageDescription

let package = Package(
  name: "Kitura-Starter",
  targets: [
    Target(name: "Kitura-Starter",
      dependencies: [.Target(name: "Controller")]),
    Target(name: "Controller")
  ],
  dependencies: [
    .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 7),
    .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 7),
    .Package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", majorVersion: 4),
    .Package(url: "https://github.com/IBM-Bluemix/cf-deployment-tracker-client-swift.git", majorVersion: 4),
    .Package(url: "https://github.com/IBM-Swift/Health.git", majorVersion: 0),
    .Package(url: "https://github.com/IBM-Swift/Kitura-Request.git", majorVersion: 0)
  ]
)
```

Then add the response to the wave command:

```swift
// Basic application tjbot wave
    router.get("/wave", handler: getTjbotWave)
```

and the implementation:
```swift
public func getTjbotWave(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        Log.debug("GET - /wave route handler...")
        
        KituraRequest.request(.post,
                              "https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/8b432466d8e127b8331a6f753d98f7008ba87c4fe679b50e238cd03b555f0ab8/api/tjbot/wave?id=january",
                              parameters: ["id":"january"],
                              encoding: JSONEncoding.default)
            .response {
                                request, response, data, error in
                Log.debug("GET - /wave route handler...")
                //try response.status(.OK).send(json: jsonResponse).end()
        }
        
        response.headers["Content-Type"] = "application/json; charset=utf-8"
        var jsonResponse = JSON([:])
        jsonResponse["framework"].stringValue = "Kitura"
        jsonResponse["applicationName"].stringValue = "Kitura-Starter"
        jsonResponse["company"].stringValue = "IBM"
        jsonResponse["organization"].stringValue = "Swift @ IBM"
        jsonResponse["location"].stringValue = "Austin, Texas"
        try response.status(.OK).send(json: jsonResponse).end()
        
    }
```
