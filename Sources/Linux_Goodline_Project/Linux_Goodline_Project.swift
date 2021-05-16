import Foundation
import ColorizeSwift

public func main() -> Int {

    let container = AppContainer.Container()
    let parser = container.argumentsParserProtocol
    guard let arguments = parser.argumentsParser(nil) else {
        return 100
    }
    
    let manager =  AppContainer.Container()  //RepositoryContainer()
    let managerValue = manager.managerProtocol
    
    let write = AppContainer.Container()  //WriteContainer()
    let writeValue = write.writeProtocol
    
    switch arguments {
        case .search(let key, let language):
            let managerResult = managerValue.managerValueForSearch(key: key, language: language) 
            
            switch managerResult {
                case .success(let value):
                    if case .search(let keywords, let dictionary) = value {
                        switch keywords {
                            case .keysKL: 
                                writeValue.PrintResultKeysKL(dictionary:dictionary)
                            case .keyK, .keysNil: 
                                writeValue.PrintResult(dictionary: dictionary)
                            case .keyL:
                                writeValue.PrintResultKeyL(dictionary: dictionary) 
                        }

                        return 0
                    }
                    else {
                        return 200 //пришел результат не из того класса (выполнилась не та подкоманда)
                    }

                case .failure(let value):
                    let errorCode = writeValue.DisplayAnError(keywords: value)  
                    return errorCode
            }
            
        case .update(let word, let key, let language):
            let managerResult = managerValue.managerValueForUpdate(word: word, key: key, language: language)
            
            switch managerResult {
                case .success(let value):
                    if case .updateSuccess = value {
                        print("Данные успешно обновлены/добавлены".lightCyan())
                        return 0
                    }
                    else {
                        return 200 //пришел результат не из того класса (выполнилась не та подкоманда)
                    }

                case .failure(let value):
                    let errorCode = writeValue.DisplayAnError(keywords: value)
                    return errorCode
            }
            
        case .delete(let key, let language):
            let managerResult = managerValue.managerValueForDelete(key: key, language: language) 
            
            switch managerResult {
                case .success(let value):
                    if case .deleteSuccess = value {
                        print("Данные успешно удалены".lightCyan())
                        return 0
                    }
                    else {
                        return 200 //пришел результат не из того класса (выполнилась не та подкоманда)
                    }

                case .failure(let value):
                    let errorCode = writeValue.DisplayAnError(keywords: value)
                    return errorCode
            }
    }    
}