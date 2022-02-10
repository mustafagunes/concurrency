import UIKit


func program() {
    print("=====", "⚙️", currentQueueName(), "⚙️", "Program", "====")
}

func currentQueueName() -> String {
  let label = __dispatch_queue_get_label(.none)
  return String(cString: label)
}


/**
 * ``.main`` Main thread'i temsil eder.
 * ``.main`` aslında Apple'ın bize sağladığı bir DispatchQueue sınıfıdır.
 * ``DispatchQueue`` sınıfı hem `sync` hemde `async` olarak handle edebilir.
 */
DispatchQueue.main.async(execute: program)


/**
 * ``.global()`` Apple'ın eşzamanlı bir `DispatchQueue` sınıfı döndürdüğü methottur.
 * Eş zamanlı yani concurrent çalışır.
 */

DispatchQueue.global().sync(execute: program)
DispatchQueue.global().async(execute: program)


/**
 * Main Thread'i temsil eder.
 * İşlemci için en önemli önceliğe sahiptir.
 */
DispatchQueue.global().async(qos: .userInteractive, execute: program)

/**
 * Hızlı sonuçların istendiği yerlerde kullanılır.
 * İşlemci için önemli önceliğe sahiptir.
 */
DispatchQueue.global().async(qos: .userInitiated, execute: program)

/**
 * Uzun süren işlemler bu kalite servisinde handle edilir.
 * İşlemci için önemsiz önceliğe sahiptir.
 */
DispatchQueue.global().async(qos: .utility, execute: program)

/**
 * Kullanıcı için önemi olmayan işlemler burada yapılır.
 * İşlemci için en önemsiz önceliğe sahiptir.
 */
DispatchQueue.global().async(qos: .background, execute: program)
