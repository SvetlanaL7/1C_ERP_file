import Foundation
   
class DataOutput: WriteProtocol {
    
    func DisplayAnError(keywords:ManagerResultError) -> Int {
        switch keywords {
            case .notFound:
                print("Not found".lightRed())
                return 1
            case .notFoundKey:
                print("Такого слова в словаре нет".lightRed())
                return 2
            case .notFoundLanguage:
                print("Такого языка для перевода в словаре нет".lightRed())
                return 3
            case .emptyDictionary:
                print("Словарь пуст!".lightRed())
                return 4
            case .updateFailed:
                print("Ошибка! Не удалось изменить данные в словаре! Команда 'update' не выполнена!".lightRed())
                return 5
            case .deleteFailed:
                print("Ошибка! Не удалось изменить данные в словаре! Команда 'delete' не выполнена!".lightRed())
                return 6
            case .deleteArgumentsFailed:
                print("Ошибка! Неверный ввод аргументов!".lightRed())
                return 7
            case .dbConectFailed:
                print("Ошибка соединения с базой данных!".lightRed())
                return 8
            case .deleteNotFound:
                print("Такого слова для удаления в словаре нет!".lightRed())  
                return 9
            case .deleteNotFoundKey:
                print("По данному ключу слова для удаления в словаре нет!".lightRed()) 
                return 10
            case .deleteNotFoundLanguage:
                print("Такого языка для удаления в словаре нет!".lightRed()) 
                return 11  
        }    
    }    
          
    func PrintResultKeyL(dictionary: [String: [String: String]]) {
        for dict in dictionary {  
            for dictionaryValue in dict.value {
                print(dictionaryValue.key.lightCyan(),"=",dictionaryValue.value.white())
            }
        }

    }

    func PrintResultKeysKL(dictionary: [String: [String: String]]) {
        for dict in dictionary {  
            for dictionaryValue in dict.value {
               print(dictionaryValue.value.white())
            }
        }

    }


    func PrintResult(dictionary: [String: [String: String]]) {
        var keyLanguage: [String] = []
            
        for dict in dictionary {  //ищет значение словаря среди значений словарей в массиве словарей и выводит язык (ru/en/pt)
            for dictionaryValue in dict.value {
                 keyLanguage.append(String(dictionaryValue.key))
            }
        }

        keyLanguage = Array(Set(keyLanguage))
        
        for i in 0...keyLanguage.count-1 {
            print(keyLanguage[i].lightMagenta())
                            
            for dict in dictionary {
                if let dictStr = dict.value[keyLanguage[i]] {
                    print(dict.key.lightCyan(),": ",dictStr.white())
                }
            }
        }
    }

}
