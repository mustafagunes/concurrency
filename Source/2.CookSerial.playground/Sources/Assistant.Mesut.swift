import Foundation

public class Mesut: Assistant {
    
    public init() {}
    
    public var v: String = ""
    
    public func make() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "๐งค Mesut Vegetables are Ready")
    }
    
    public func prepare(_ c: String) {
        sleep(2)
        v = c
        print("\n", Officer.currentQueueName(), "\n", "โ๏ธ Mesut Prepared Vegetables")
    }
    
    public func control() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "๐ Mesut Checked")
    }
    
    public func takeToChef() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "๐ Mesut was Delivered")
    }
}
