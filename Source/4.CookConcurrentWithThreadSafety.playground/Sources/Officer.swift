import Foundation

public class Officer {
    public class func currentQueueName() -> String {
        let label = __dispatch_queue_get_label(.none)
        return String(cString: label)
    }
}
