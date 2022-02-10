import UIKit
import Darwin


/**
 * Burada concurrency içinde `Thread Safety` konusunu ele alacağız. Thread güveliğini sağlayarak
 * `Concurrent` şekilde bir lüks restaurantın mutfakta yemeğin hazırlanmasından müşteriye gönderilmesine
 * kadar olan kısımları ele alacağız.
 */

/**
 * ``Kadro 1 Şef ve 3 Yardımcıdan oluşuyor.``
 * `Chef: Mustafa`
 *      `Assistant: Ahmet`
 *      `Assistant: Derya`
 *      `Assistant: Mesut`
 */

let start = CFAbsoluteTimeGetCurrent()

/**
 * Görevler grubunu yönetmek istediğinizde kulladığımız sınıftır.
 * DispatchQueue sınıfı kullanılırken `sync`yada `async`methotlarının içine verilir.
 */
let controlGroup = DispatchGroup()
let readyGroup = DispatchGroup()

/**
 * Aşağıda custom bir seri thread oluşturduk.
 */
let workQueue = DispatchQueue(label: "com.cook.work.concurrent", attributes: .concurrent)

// MARK: - Cook Space

let chef = Mustafa()

let ahmet = Ahmet()
let derya = Derya()
let mesut = Mesut()

print("⚙️  ", Officer.currentQueueName(), "  ⚙️", "\n")

workQueue.async(execute: chef.start)

workQueue.async(group: controlGroup) {
    ahmet.prepare("🍆🍅")
    ahmet.control()
    ahmet.make()
    ahmet.takeToChef()
}

workQueue.async(group: controlGroup) {
    derya.prepare("🫑🌶🧅")
    derya.control()
    derya.make()
    derya.takeToChef()
}

workQueue.async(group: controlGroup) {
    mesut.prepare("🧄🥩")
    mesut.control()
    mesut.make()
    mesut.takeToChef()
}

/**
 * Oluşturduğumuz `Queue'ya` `flags: .barrier` vererek kendisinden önceki thread'lerin işlemlerinden
 * kendini `izole` etmesini sağlıyoruz, böylelikce güvenli bir çalışma pipline'ı oluşuyor.
 *
 * Aşağıdaki durumu ``NSLock().lock()`` yada ``NSLock().unlock()``
 * ve ``NSRecursiveLock().lock()`` yada ``NSRecursiveLock().unlock()`` ilede bu sorun çözülecektir.
 *
 * Yani yardımcıların işi bitmeden ve şef bitti demeden yardımcılar ellerindeki yemeği hazırlamış olması gerekiyor.
 */
workQueue.async(flags: .barrier, execute: chef.finish)

controlGroup.notify(flags: .barrier, queue: workQueue, execute: chef.control)

workQueue.async(group: readyGroup, flags: .barrier) {
    chef.prepare("\(ahmet.v)\(derya.v)\(mesut.v)")
    chef.merge()
    chef.make()
}

readyGroup.notify(queue: .main) {
    chef.send()

    let diff = CFAbsoluteTimeGetCurrent() - start
    print("\n===", "⏱", "Took \(diff) seconds", "===\n\n")
}
