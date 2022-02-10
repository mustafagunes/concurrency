import Foundation

public protocol Skill {
    var v: String { get set }
    
    func make()
    func prepare(_ c: String)
    func control()
}

public protocol Chef: Skill {
    func start()
    func merge()
    func finish()
    func send()
}

public protocol Assistant: Skill {
    func takeToChef()
}
