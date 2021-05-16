import Foundation
import ArgumentParser


class ArgumentParserKey: ArgumentsParserProtocol {
    func argumentsParser(_ arguments: [String]?) -> Arguments? {
        do {
            let command = try Commands.parseAsRoot(arguments)
           
            switch command {
                case let command as Commands.Search:
                    return .search(key: command.key, language: command.language)
                
                case let command as Commands.Update:
                    return .update(word: command.word, key: command.key, language: command.language)
                
                case let command as Commands.Delete:
                    return .delete(key: command.key, language: command.language)
                default:
                    print(Commands.helpMessage().onRed())
                    return nil
                   
            }
        }
        catch {
            print(Commands.helpMessage().onRed())
            return nil
           
        }
    }
}

private struct Commands: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Search.self, Update.self, Delete.self]
    )
}

extension Commands {
    struct Search: ParsableCommand {
        @Option (name: .shortAndLong, help: ArgumentHelp("Dictionary key", valueName:"key"))
        var key: String?

        @Option (name: .shortAndLong, help: ArgumentHelp("Dictionary language", valueName:"language"))
        var language: String?
    }

    struct Update: ParsableCommand {
        @Argument
        var word: String

        @Option (name: .shortAndLong, help: ArgumentHelp("Dictionary key", valueName:"key"))
        var key: String

        @Option (name: .shortAndLong, help: ArgumentHelp("Dictionary language", valueName:"language"))
        var language: String
    }

    struct Delete: ParsableCommand {
        @Option (name: .shortAndLong, help: ArgumentHelp("Dictionary key", valueName:"key"))
        var key: String?

        @Option (name: .shortAndLong, help: ArgumentHelp("Dictionary language", valueName:"language"))
        var language: String?
    }
}