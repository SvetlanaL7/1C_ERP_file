import Foundation
import ColorizeSwift

class CommandLineArguments {
    public var valueKey: String? = nil
    public var valueLanguage: String? = nil
    public var argumentCount: Int = -1
    
    func commandArgs() -> (Int, String?, String?) {
        switch CommandLine.arguments.count {
            case 1:
                argumentCount = 0
                break
            case 3:
                argumentCount = 1
                ReadArguments2()
            case 5:
                argumentCount = 2
                ReadArguments3()
            default:
                print("не удалось распознать введенное значение".lightRed())
        }

        //кортеж
        return (
        argumentCount: argumentCount,    
        valueKey: valueKey,
        valueLanguage: valueLanguage
        )
    }

    func ReadArguments2() {
        guard CommandLine.arguments[1] == "-k" || CommandLine.arguments[1] == "-l" else {
            print("Ошибка ввода ключа!".lightRed())
            exit(0)
        }

        if CommandLine.arguments[1] == "-k" {
            valueKey = CommandLine.arguments[2]
        }
        
        if CommandLine.arguments[1] == "-l" {
            valueLanguage = CommandLine.arguments[2]
        }
    }

    func ReadArguments3() {
        if CommandLine.arguments[1] == "-k" && CommandLine.arguments[3] == "-l" {
            valueKey = CommandLine.arguments[2]
            valueLanguage = CommandLine.arguments[4]
        }
        if CommandLine.arguments[1] == "-l" && CommandLine.arguments[3] == "-k" {
            valueKey = CommandLine.arguments[4]
            valueLanguage = CommandLine.arguments[2]
        }

        guard valueKey != nil && valueLanguage != nil else {
            print("Ошибка ввода данных!".lightRed())
            exit(0)
        }

        guard valueKey != "" && valueLanguage != "" else {
            print("Ошибка ввода данных!".lightRed())
            exit(0)
        }
    }
}

//считывание аргументов из командой строки ---------------------
//from main() (Linux_Goodline_Project)
/*let argumentsLine  = CommandLineArguments()
let (argumentCount, key, language) = argumentsLine.commandArgs()
if argumentCount < 0 {exit(0)}*/
//-------------------------------------------------------------