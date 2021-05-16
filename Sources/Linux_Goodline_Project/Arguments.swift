enum Arguments {
    case search(key: String?, language: String?)
    case update(word: String, key: String, language: String)
    case delete(key: String?, language: String?)
}