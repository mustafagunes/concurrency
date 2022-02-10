import UIKit


/**
 * Burada concurrency'nin ilk ayağı olan `serial` şekilde bir lüks restaurantın mutfakta yemeğin hazırlanmasından
 * müşteriye gönderilmesine kadar olan kısımları ele alacağız.
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

/**
 * Aşağıda custom bir seri thread oluşturduk.
 */
let workQueue = DispatchQueue(label: "com.cook.work.serial")

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

workQueue.async(execute: chef.finish)

/**
 * `wait()` ile önceden gönderilen çalışmanın bitmesini eşzamanlı olarak bekliyoruz.
 */
controlGroup.wait()
controlGroup.notify(queue: workQueue, execute: chef.control)

workQueue.async {
    chef.prepare("\(ahmet.v)\(derya.v)\(mesut.v)")
    chef.merge()
    chef.make()
    chef.send()
    
    let diff = CFAbsoluteTimeGetCurrent() - start
    print("\n===", "⏱", "Took \(diff) seconds", "===\n\n")
}
