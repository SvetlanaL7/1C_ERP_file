public protocol ManagerProtocol {
   func managerValueForSearch(key: String?, language: String?) -> Result<ManagerResult, ManagerResultError> 
   func managerValueForUpdate(word: String, key: String, language: String) -> Result<ManagerResult, ManagerResultError> 
   func managerValueForDelete(key: String?, language: String?) -> Result<ManagerResult, ManagerResultError>    
}