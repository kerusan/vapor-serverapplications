/// Available Frontbase storage methods.
public enum FrontbaseStorage {
    case db(name: String, onHost: String, username: String, password: String)
    /// File-based storage, persisted between application launches.
    case file(path: String)
}
