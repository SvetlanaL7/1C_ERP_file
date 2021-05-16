import Linux_Goodline_Project
import Vapor

struct ManagerController: RouteCollection {
    let manager: ManagerProtocol

    init(manager: ManagerProtocol) {
        self.manager = manager
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("search")
        group.get(use: search)
        let groupUpdate = routes.grouped("update")
        groupUpdate.post(use: update)
        let groupDelete = routes.grouped("delete")
        groupDelete.delete(use: delete)
    }

    func search(req: Request) throws -> EventLoopFuture<[String: [String: String]]> {
        var resultSearch: [String: [String: String]] = [:]
        let parameters = try? req.query.decode(Parameters.self)
       
        req.logger.info("Parameters: \(parameters?.key ?? "") \(parameters?.language ?? "")")
       
        let result = manager.managerValueForSearch(key: parameters?.key, language: parameters?.language).mapError{$0 as Error}
        
        if case .success(let value) = result {
            if case .search(let keywords, let dictionary) = value {
                resultSearch = dictionary
            }
        } 
        
        return req.eventLoop.future(resultSearch)    
    }

    func update(req: Request) throws -> EventLoopFuture<String> {
        var resultUpdate = ""
        let parametersUpdate = try req.query.decode(ParametersUpdate.self)

        req.logger.info("Parameters: \(parametersUpdate.word ?? "") \(parametersUpdate.key) \(parametersUpdate.language)")
      
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
        
        if case .success(let value) = result {
            resultDelete = "Данные успешно удалены"
        }

        return req.eventLoop.future(resultDelete)    
    }

}

private extension ManagerController {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }

    struct ParametersUpdate: Content {
        let word: String
        let key: String
        let language: String
    }
}