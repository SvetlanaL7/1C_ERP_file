import Linux_Goodline_Project
import Vapor
import Leaf

struct ManagerInputFormControllerWeb: RouteCollection {
    let manager: ManagerProtocol

    init(manager: ManagerProtocol) {
        self.manager = manager
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("Search")
        group.get(use: searchInputForm)
        let groupUpdate = routes.grouped("Update")
        groupUpdate.get(use: updateInputForm)
        let groupDelete = routes.grouped("Delete")
        groupDelete.get(use: deleteInputForm)
    }

    func searchInputForm(req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("Search")
    }

    func updateInputForm(req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("Update")
    }

    func deleteInputForm(req: Request) throws -> EventLoopFuture<View> {
        return req.view.render("Delete")   
    }

}