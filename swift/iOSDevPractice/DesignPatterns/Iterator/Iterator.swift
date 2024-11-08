///// Motivation:
///// Iteration (traversal) is a core functionality of various data structures
///// An iterator is a class that facilitates the traversal
///// - Keeps a reference to the current element
///// - Knows how to move to a different element
///// Iterator is an implicit construct
///// - for x in y: no obvious iterator construction
/////
///// Iterator: An object (or a method) that facilitates the traversal of a data structure.
//
//import Foundation
//
//class Node<T> {
//  var value: T
//  var left: Node<T>? = nil
//  var right: Node<T>? = nil
//  var parent: Node<T>? = nil
//
//  init(_ value: T) {
//    self.value = value
//  }
//
//  init(_ value: T, _ left: Node<T>, _ right: Node<T>) {
//    self.value = value
//    self.left = left
//    self.right = right
//
//    left.parent = self
//    right.parent = self
//  }
//}
//
//class InOrderIterator<T>: IteratorProtocol {
//
//  var current: Node<T>?
//  var root: Node<T>
//  var yieldedStart = false
//
//  init(_ root: Node<T>) {
//    self.root = root
//    current = root
//    while current!.left != nil {
//      current = current!.left!
//    }
//  }
//
//  func reset() {
//    current = root
//    yieldedStart = false  // really?
//  }
//
//  func next() -> Node<T>? {
//    if !yieldedStart {
//      yieldedStart = true
//      return current
//    }
//
//    if current!.right != nil {
//      current = current!.right
//      while current!.left != nil {
//        current = current!.left
//      }
//      return current
//    } else {
//      var p = current!.parent
//      while (p != nil) && (current === p!.right) {
//        current = p!
//        p = p!.parent
//      }
//      current = p
//      return current
//    }
//  }
//}
//
//class BinaryTree<T>: Sequence {
//  private let root: Node<T>
//
//  init(_ root: Node<T>) {
//    self.root = root
//  }
//
//  func makeIterator() -> InOrderIterator<T> {
//    return InOrderIterator<T>(root)
//  }
//}
//
//func main() {
//  //      1
//  //    /   \
//  //   2     3
//
//  // inorder: 213
//  // preorder: 123
//  // postorder: 231
//
//  let root = Node(1, Node(2), Node(3))
//
//  let it = InOrderIterator(root)
//
//  while let element = it.next() {
//    print(element.value, terminator: " ")  // 2 1 3
//  }
//
//  print()
//
//  let nodes = AnySequence { InOrderIterator(root) }
//  print(nodes.map { $0.value })  // [2, 1, 3]
//
//  let tree = BinaryTree(root)
//  print(tree.map { $0.value })  // [2, 1, 3]
//}
//
//main()
