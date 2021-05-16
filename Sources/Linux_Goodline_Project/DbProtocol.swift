public protocol DbProtocol {
    func GetValueFromDb() -> [String: [String: String]]? 
    func WriteDictionaryToDb(dictionaryValue: [String: [String: String]]) -> Bool
}    