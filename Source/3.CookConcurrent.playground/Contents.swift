import UIKit


/**
 * Burada concurrency'nin ilk ayağı olan `concurrent` şekilde bir lüks restaurantın mutfakta yemeğin hazırlanmasından
 * müşteriye gönderilmesine kadar olan kısımları ele alacağız.
 *
 * Bu playground'da concurrent çalışmanın getirdiği bazı sorunları ele alacağız.
 * Bu sorunları bir sonraki playground'da çözeceğiz.
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

#warning("Aşağıdaki sorunu çözelim")
/**
 * `wait()` ile önceden gönderilen çalışmanın bitmesini eşzamanlı olarak bekliyoruz.
 * Bir sonraki playground'da wait yerine `barrier` ile çözeceğiz. (thread safety)
 */
controlGroup.wait()
workQueue.async(execute: chef.finish)

controlGroup.notify(queue: workQueue, execute: chef.control)

workQueue.async {
    chef.prepare("\(ahmet.v)\(derya.v)\(mesut.v)")
    chef.merge()
    chef.make()
    chef.send()

    let diff = CFAbsoluteTimeGetCurrent() - start
    print("\n===", "⏱", "Took \(diff) seconds", "===\n\n")
}
