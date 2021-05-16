import Foundation
   
class DbConnect: DbProtocol  {
    
    private var dictionaryValue: [String: [String: String]] = [:]
    private let pathUrl: String
    
    init() {    
        //объявляем путь к файлу с данными из словаря    
        self.pathUrl = Bundle.module.path(forResource:"dictionary", ofType: "json") ?? "dictionary.json"
    }

    func GetValueFromDb() -> [String: [String: String]]? {
        //считывание данных (словаря) из файла -------------------------
        let fileManager = FileManager.default
        if let dataFile = fileManager.contents(atPath: pathUrl) {
            dictionaryValue = (try? JSONDecoder().decode([String: [String: String]].self, from: dataFile)) ?? [:]
            return dictionaryValue
        }
        else {
            return nil
        } 
        
    }    

    func WriteDictionaryToDb(dictionaryValue: [String: [String: String]]) -> Bool { 
        do {
            JSONEncoder().outputFormatting = .prettyPrinted
            let json = try JSONEncoder().encode(dictionaryValue.self)
            try json.write(to: URL(fileURLWithPath: pathUrl))
            return true
        } 
        catch {
            return false
        }    
            
    }
    
}
