import Foundation

public class Ahmet: Assistant {
    
    public init() {}
    
    public var v: String = ""
    
    public func make() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "🧤 Ahmet Vegetables are Ready")
    }
    
    public func prepare(_ c: String) {
        sleep(2)
        v = c
        print("\n", Officer.currentQueueName(), "\n", "☘️ Ahmet Prepared Vegetables")
    }
    
    public func control() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "👌 Ahmet Checked")
    }
    
    public func takeToChef() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "👌 Ahmet was Delivered")
    }
}
