import Vapor

func routes(_ app: Application) throws {
    //app.get { req in
    //    return "It works!"
    //}
    app.get() { req -> EventLoopFuture<View> in
        return req.view.render("Input_Main") //открывать главную при входе в приложение
    }
    
    try app.register(collection: app.container.managerController)
    //Web
    try app.register(collection: app.container.managerInputFormControllerWeb)
    try app.register(collection: app.container.managerOutputFormControllerWeb)
}
