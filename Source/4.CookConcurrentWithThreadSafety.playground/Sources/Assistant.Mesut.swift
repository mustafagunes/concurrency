import Foundation

public class Mesut: Assistant {
    
    public init() {}
    
    public var v: String = ""
    
    public func make() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "🧤 Mesut Vegetables are Ready")
    }
    
    public func prepare(_ c: String) {
        sleep(2)
        v = c
        print("\n", Officer.currentQueueName(), "\n", "☘️ Mesut Prepared Vegetables")
    }
    
    public func control() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "👌 Mesut Checked")
    }
    
    public func takeToChef() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "👌 Mesut was Delivered")
    }
}
