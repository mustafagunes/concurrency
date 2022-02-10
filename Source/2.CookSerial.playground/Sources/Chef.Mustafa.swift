import Foundation

public class Mustafa: Chef {
    
    public init() {}
    
    public var v: String = ""
    
    public func merge() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "🛗 Mustafa Merged Vegetables: \(v)")
    }
    
    public func send() {
        print("\n", Officer.currentQueueName(), "\n", "Food: 🥘🥗🍟")
    }
    
    public func make() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "✅ Mustafa is Ready")
    }
    
    public func prepare(_ c: String) {
        sleep(1)
        v = c
        print("\n", Officer.currentQueueName(), "\n", "☘️ Mustafa Prepared Vegetables")
    }
    
    public func control() {
        print("\n", Officer.currentQueueName(), "\n", "🚀 Passed Control")
    }
    
    public func start() {
        print("=== Start Team ===")
    }
    
    public func finish() {
        print("\n", "=== Finish Team ===")
    }
}
