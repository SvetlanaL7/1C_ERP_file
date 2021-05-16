import Linux_Goodline_Project
import Vapor
import Leaf
import Fluent
import Foundation
//import Core

struct ManagerOutputFormControllerWeb: RouteCollection {
    let manager: ManagerProtocol
    // var KeyOutput: [String] = []
    // var LanguageOutput: [String] = []
    // var TranslateOutpur: [String] = []

    init(manager: ManagerProtocol) {
        self.manager = manager
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("SearchOutput")
        group.get(use: search)
        let groupUpdate = routes.grouped("UpdateOutput")
        groupUpdate.get(use: update)
        let groupDelete = routes.grouped("DeleteOutput")
        groupDelete.get(use: delete)
    }

    func search(req: Request) throws -> EventLoopFuture<View> {
        // var keyOutput: [String] = []
        // var languageOutput: [String] = []
        var translateOutpur: [String] = []
        var transl = ""
        var resultSearchj: [String: [String: String]] = ["ru": ["house": "Домище"]]  //[:]
        let parameters = try? req.query.decode(Parameters.self)
       
        var keyValue = parameters?.key
        var languageValue = parameters?.language
        
        /*if (parameters?.key?.isEmpty != nil) { 
            keyValue = nil
        }
        if (parameters?.language?.isEmpty != nil) {
            languageValue = nil
        }*/
        if (parameters?.key == "") { 
            keyValue = nil
        }
        if (parameters?.language == "") { 
            languageValue = nil
        }


        req.logger.info("Parameters Web: \(parameters?.key ?? "") \(parameters?.language ?? "")")
       req.logger.info("Parameters Web: \(keyValue ?? "") \(languageValue ?? "")")
        
        /*if keyValue == nil {
            keyValue = nil
            if languageValue == nil {
                //let result = manager.managerValueForSearch(key: nil, language: nil).mapError{$0 as Error}
                languageValue = nil
            }
           // else {
                //let result = manager.managerValueForSearch(key: nil, language: parameters?.language).mapError{$0 as Error}
            //}
        }*/
       //else {
            //let result = manager.managerValueForSearch(key: parameters?.key, language: parameters?.language).mapError{$0 as Error}
       // }
        
        //let result = manager.managerValueForSearch(key: parameters?.key, language: parameters?.language).mapError{$0 as Error}
        let result = manager.managerValueForSearch(key: keyValue, language: languageValue).mapError{$0 as Error}
        

        if case .success(let value) = result {
            if case .search(let keywords, let dictionary) = value {
                resultSearchj = dictionary
               switch keywords {
                    case .keyL:
                        //PrintOutputKeyL(dictionary: resultSearchj)
                        for dict in dictionary {  
                            for dictionaryValue in dict.value {
                                transl = dictionaryValue.key + "       " + dictionaryValue.value
                                //keyOutput.append(dictionaryValue.key)
                                translateOutpur.append(transl)
                                //translateOutpur.append(dictionaryValue.value)
                            }   
                        }
                    case .keysKL:
                        //PrintOutputKeysKL(dictionary: resultSearchj)
                        for dict in dictionary {  
                            for dictionaryValue in dict.value {
                                transl = dictionaryValue.key + "        " + dict.key + "       " + dictionaryValue.value
                                //keyOutput.append(dictionaryValue.key)
                                //languageOutput.append(dict.key)
                                //translateOutpur.append(dictionaryValue.value)
                                translateOutpur.append(transl)
                            //print(dictionaryValue.value.white())
                            }
                        }
                    case .keyK, .keysNil: 
                       // PrintOutput(dictionary: resultSearchj) 
                    var keyLanguage: [String] = []
            
                    for dict in dictionary {  //ищет значение словаря среди значений словарей в массиве словарей и выводит язык (ru/en/pt)
                        for dictionaryValue in dict.value {
                            keyLanguage.append(String(dictionaryValue.key))
                        }
                    }

                    keyLanguage = Array(Set(keyLanguage))
                    
                    for i in 0...keyLanguage.count-1 {
                       // languageOutput.append(keyLanguage[i])

                        for dict in dictionary {
                            if let dictStr = dict.value[keyLanguage[i]] {
                                //keyOutput.append(dict.key)
                                //translateOutpur.append(dictStr)
                                 transl = keyLanguage[i] + "       " + dict.key + "       " + dictStr
                                 translateOutpur.append(transl)
                                
                            }
                        }
                    }
               }
                /*let resultSearch = resultSearchj.map { value in
                    Response(
                        results: value.map { value in
                            Response.SearchResult(
                                key: value.key,
                                elements: value.value.map {
                                    Response.SearchResult.Element(
                                        language: $0.key,
                                        value: $0.value
                                    )
                                }
                            )
                        }
                    )
                }*/

               // return req.view.render("SearchOutput", SearchView(title: "Результаты по вашему запросу", results: resultSearchj))
        
            }
        } 
        else {
            //resultSearchj = ["ru": ["house": "Дом"]]
            transl = "Данное значение не найдено!"
            translateOutpur.append(transl)
        //    resultSearch = result.mapError{$0 as Error}
        }
        //req.logger.info("Parameters Web: \(resultSearch ?? "") ")
       
     //return req.view.render("SearchOutput", resultSearchj)   
     return req.view.render("SearchOutput", DataOutputView(TranslateOutpur: translateOutpur))    

//return req.view.render("SearchOutput", DataOutputView(resultSearchj: resultSearchj, KeyOutput: keyOutput, LanguageOutput: languageOutput, TranslateOutpur: translateOutpur))    
//return req.view.render("SearchOutput", DataOutputView(resultSearchj: resultSearchj))
    //return req.view.render("SearchOutput", SearchView(title: "Результаты по вашему запросу", results: resultSearchj))
        
        
        
        //return req.view.render("Search")
        //return req.eventLoop.future(resultSearch)    
    }

    func update(req: Request) throws -> EventLoopFuture<View> {
        var translateOutpur: [String] = []
        var resultUpdate = ""
        var transl = ""
        let parametersUpdate = try req.query.decode(ParametersUpdate.self)

        req.logger.info("Parameters: \(parametersUpdate.word ?? "") \(parametersUpdate.key) \(parametersUpdate.language)")
       //managerValueForUpdate(word: String, key: String, language: String)
        let result = manager.managerValueForUpdate(word: parametersUpdate.word, key: parametersUpdate.key, language: parametersUpdate.language).mapError{$0 as Error}
        
        if case .success(let value) = result {
            resultUpdate = "Данные успешно обновлены/добавлены"
        }
        else {
            resultUpdate = "Ошибка! Не удалось изменить данные в словаре! Команда 'update' не выполнена!"
        }
        translateOutpur.append(resultUpdate)
        //return req.eventLoop.future(resultUpdate) //.flatMapResult()
        return req.view.render("UpdateOutput", DataOutputView(TranslateOutpur: translateOutpur)) 
    }

    func delete(req: Request) throws -> EventLoopFuture<View> {
        var translateOutpur: [String] = []
        var resultDelete = ""
        var transl = ""
        let parameters = try? req.query.decode(Parameters.self)
       
        req.logger.info("Parameters: \(parameters?.key ?? "") \(parameters?.language ?? "")")
       
        let result = manager.managerValueForDelete(key: parameters?.key, language: parameters?.language).mapError{$0 as Error}
        //resultSearch = [:]
        
        if case .success(let value) = result {
            resultDelete = "Данные успешно удалены"
        }
        else {
            resultDelete = "Ошибка! Не удалось изменить данные в словаре! Команда 'delete' не выполнена!"
        }
        translateOutpur.append(resultDelete)
        //return req.eventLoop.future(resultDelete)
        return req.view.render("DeleteOutput", DataOutputView(TranslateOutpur:translateOutpur))    
    }

//}

   /* mutating func PrintOutputKeyL(dictionary: [String: [String: String]]) {
        //var KeyOutput: [String]
        //var LanguageOutput: [String]
        //var TranslateOutpur: [String]
        // KeyOutput = []
        // LanguageOutput = []
        // TranslateOutpur = []

        for dict in dictionary {  
            for dictionaryValue in dict.value {
                KeyOutput.append(dictionaryValue.key)
                //LanguageOutput = []
                TranslateOutpur.self.append(dictionaryValue.value)
                //print(dictionaryValue.key.lightCyan(),"=",dictionaryValue.value.white())
            }
        }

    }

    mutating func PrintOutputKeysKL(dictionary: [String: [String: String]]) {
        // KeyOutput = []
        // LanguageOutput = []
        // TranslateOutpur = []

        for dict in dictionary {  
            for dictionaryValue in dict.value {
                KeyOutput.append(dictionaryValue.key)
                LanguageOutput.append(dict.key)
                TranslateOutpur.append(dictionaryValue.value)
               //print(dictionaryValue.value.white())
            }
        }

    }


    mutating func PrintOutput(dictionary: [String: [String: String]]) {
        // KeyOutput = []
        // LanguageOutput = []
        // TranslateOutpur = []
        var keyLanguage: [String] = []
            
        for dict in dictionary {  //ищет значение словаря среди значений словарей в массиве словарей и выводит язык (ru/en/pt)
            for dictionaryValue in dict.value {
                 keyLanguage.append(String(dictionaryValue.key))
            }
        }

        keyLanguage = Array(Set(keyLanguage))
        
        for i in 0...keyLanguage.count-1 {
            //print(keyLanguage[i].lightMagenta())
            LanguageOutput.append(keyLanguage[i])

            for dict in dictionary {
                if let dictStr = dict.value[keyLanguage[i]] {
                    KeyOutput.append(dict.key)
                    //LanguageOutput.append(dict.key)
                    TranslateOutpur.append(dictStr)
                    //print(dict.key.lightCyan(),": ",dictStr.white())
                }
            }
        }
    }*/

}  

struct DataOutputView: Content {
   //var resultSearchj: ManagerOutputFormControllerWeb.Response //[String: [String: String]] //ManagerControllerWeb.Response
    /*var resultSearchj: [SearchResultV]

        struct SearchResultV: Codable {
            let key: String
            let elements: [ElementV]

            struct ElementV: Codable {
                let language: String
                let value: String
            }
        }*/
   // var KeyOutput: [String]
   // var LanguageOutput: [String]
    var TranslateOutpur: [String] 
}

private extension ManagerOutputFormControllerWeb {
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

struct SearchView: Content {
    var title: String
    var results: ManagerOutputFormControllerWeb.Response //[String: [String: String]] //ManagerControllerWeb.Response
}

/*extension ManagerOutputFormControllerWeb {
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
*/

extension ManagerOutputFormControllerWeb {
    struct Response: Content {
        let resultSearchj: [SearchResultV]

      struct SearchResultV: Codable {
            let key: String
            let elements: [ElementV]

            struct ElementV: Codable {
                let language: String
                let value: String
            }
        }
    }
}