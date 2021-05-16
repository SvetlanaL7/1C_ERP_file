protocol WriteProtocol {
    func DisplayAnError(keywords: ManagerResultError) -> Int
    func PrintResultKeyL(dictionary: [String: [String: String]])
    func PrintResultKeysKL(dictionary: [String: [String: String]])
    func PrintResult(dictionary: [String: [String: String]])
}