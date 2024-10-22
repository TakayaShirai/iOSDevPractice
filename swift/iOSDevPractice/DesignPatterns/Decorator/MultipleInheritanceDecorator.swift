//import Foundation
//
//protocol ICanFly {
//  func fly()
//}
//
//protocol ICanCrawl {
//  func crawl()
//}
//
//class Bird: ICanFly {
//  func fly() {}
//}
//
//class Lizard: ICanCrawl {
//  func crawl() {}
//}
//
///// We can't simply do this as this doesn't conform to the Swift rules. X Multiple Inheritance
////class Dragon: Bird, Lizard {
////
////}
//
//class Dragon: ICanFly, ICanCrawl {
//  private let bird = Bird()
//  private let lizard = Lizard()
//
//  func fly() {
//    bird.fly() // delegation
//  }
//
//  func crawl() {
//    lizard.crawl() // delegation
//  }
//}
