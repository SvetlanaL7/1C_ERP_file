import Foundation

public enum AppContainer {
    private static let container = Container()

    public enum Manager {
        public static func ManagerPtl() -> ManagerProtocol {
            return AppContainer.container.managerProtocol
        } 
    }
}

private extension AppContainer {
    public class Container {
        var argumentsParserProtocol: ArgumentsParserProtocol {
            return ArgumentParserKey()
        }
        
        var dbProtocol: DbProtocol {
            return DbConnect()
        }
    
        var managerProtocol: ManagerProtocol {
            return ManagerGetValue(dictionaryProtocol: dbProtocol)
        }
    
        var writeProtocol: WriteProtocol {
            return DataOutput()
        }
    }
}
