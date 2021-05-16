import Linux_Goodline_Project
import Vapor
//import Core

struct ManagerControllerWeb: RouteCollection {
    let manager: ManagerProtocol

    init(manager: ManagerProtocol) {
        self.manager = manager
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("SearchOutput")
        group.get(use: search)
        /*let groupUpdate = routes.grouped("update")
        groupUpdate.post(use: update)
        let groupDelete = routes.grouped("delete")
        groupDelete.delete(use: delete)*/
    }

    func search(req: Request) throws -> EventLoopFuture<View> {
        var resultSearch: [String: [String: String]] = [:]
        let parameters = try? req.query.decode(Parameters.self)
       
        req.logger.info("Parameters: \(parameters?.key ?? "") \(parameters?.language ?? "")")
       
        let result = manager.managerValueForSearch(key: parameters?.key, language: parameters?.language).mapError{$0 as Error}
        
        if case .success(let value) = result {
            if case .search(let keywords, let dictionary) = value {
                resultSearch = dictionary
            }
        } 
        //else {
        //    resultSearch = result.mapError{$0 as Error}
        //}
        return req.view.render("SearchOutput", SearchView(title: "Результаты по вашему запросу", results: resultSearch))
        //return req.view.render("Search")
        //return req.eventLoop.future(resultSearch)    
    }

    /*func update(req: Request) throws -> EventLoopFuture<String> {
        var resultUpdate = ""
        let parametersUpdate = try req.query.decode(ParametersUpdate.self)

        req.logger.info("Parameters: \(parametersUpdate.word ?? "") \(parametersUpdate.key) \(parametersUpdate.language)")
       //managerValueForUpdate(word: String, key: String, language: String)
        let result = manager.managerValueForUpdate(word: parametersUpdate.word, key: parametersUpdate.key, language: parametersUpdate.language).mapError{$0 as Error}
        
        if case .success(let value) = result {
            resultUpdate = "Данные успешно обновлены/добавлены"
        }

        return req.eventLoop.future(resultUpdate) //.flatMapResult()
    }

    func delete(req: Request) throws -> EventLoopFuture<String> {
        var resultDelete = ""
        let parameters = try? req.query.decode(Parameters.self)
       
        req.logger.info("Parameters: \(parameters?.key ?? "") \(parameters?.language ?? "")")
       
        let result = manager.managerValueForDelete(key: parameters?.key, language: parameters?.language).mapError{$0 as Error}
        //resultSearch = [:]
        
        if case .success(let value) = result {
            resultDelete = "Данные успешно удалены"
        }

        return req.eventLoop.future(resultDelete)    
    }*/

}

private extension ManagerControllerWeb {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }

    /*struct ParametersUpdate: Content {
        let word: String
        let key: String
        let language: String
    }*/
}

struct SearchView: Content {
    var title: String
    var results: [String: [String: String]] //ManagerControllerWeb.Response
}

extension ManagerControllerWeb {
    struct Response: Content {
        let results: [SearchResult]

        struct SearchResult: Codable {
            let key: String
            let elements: [Element]

            struct Element: Codable {
                let language: String
                let value: String
            }
        }
    }
}
