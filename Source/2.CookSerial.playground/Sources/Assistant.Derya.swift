import Foundation

public class Derya: Assistant {
    
    public init() {}
    
    public var v: String = ""
    
    public func make() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "๐งค Derya Vegetables are Ready")
    }
    
    public func prepare(_ c: String) {
        sleep(2)
        v = c
        print("\n", Officer.currentQueueName(), "\n", "โ๏ธ Derya Prepared Vegetables")
    }
    
    public func control() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "๐ Derya Checked")
    }
    
    public func takeToChef() {
        sleep(1)
        print("\n", Officer.currentQueueName(), "\n", "๐ Derya was Delivered")
    }
}
