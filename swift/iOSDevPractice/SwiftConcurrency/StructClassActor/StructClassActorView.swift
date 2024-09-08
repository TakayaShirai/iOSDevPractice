import SwiftUI

/*
 - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Links:
 https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language
 https://medium.com/@vinayakkini/swift-basics-struct-vs-class-31b44ade28ae
 https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language/59219141#59219141
 https://stackoverflow.com/questions/27441456/swift-stack-and-heap-understanding
 https://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
 https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
 https://medium.com/doyeona/automatic-reference-counting-in-swift-arc-weak-strong-unowned-925f802c1b99

 - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack
 - Faster
 - Thread safe
 - Whenn you assign or pass value type a new copy of data is created

 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in Heap
 - Slower, but synchronized
 - Not Thread safe
 - When you assign or pass reference type a new reference to original instance will be created (pointer)

 - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 STACK:
 - Stored Value types
 - Variable allocated on the stack are stored directly to the memory, and access to this memory is very fast.
 - Each thread has its own stack

 HEAP:
 - Stored Reference types
 - Shated across threads!

 - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 STRUCT:
 - Based on VALUES
 - Not affected by ARC
 - Can be mutated
 - Stored in the Stack

 CLASS:
 - Based on REFERECES (INSTANCES)
 - Stored in HEAP
 - Inherit from other classes

 Actor:
 - Same as Class, but thread safe
 - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 */

struct StructClassActorView: View {
  var body: some View {
    Text("Hello, World!")
      .onAppear {
        runTest()
      }
  }
}

#Preview {
  StructClassActorView()
}

// MARK: Struct vs Class
extension StructClassActorView {

  private func runTest() {
    print("Test started")
    //    structTest1()
    //    printDivider()
    //    classTest1()

    structTest2()
    printDivider()
    classTest2()
    printDivider()
    actorTest1()
  }

  private func printDivider() {
    print(
      """
        - - - - - - - - - - - - - - - - - - - -
      """)
  }

  private func structTest1() {
    let objectA = MyStruct(title: "Starting title!")
    print("ObjectA: ", objectA.title)

    /// Struct is a VALUE type.
    print("Pass the VALUES of objectA to objectB.")
    /// onjectB is totally seperate from objectA. it's distinct.
    var objectB = objectA
    print("ObjectB: ", objectB.title)

    /// when we are changing the title for the struct, we are actually mutating
    /// creating a totally new struct. That's why we have to set onjectB as var.
    objectB.title = "Second title!"
    print("ObjectB title changed.")

    print("ObjectA: ", objectA.title)  // Starting Title!
    print("OnjectB: ", objectB.title)  // Second Title!
  }

  private func classTest1() {
    let objectA = Myclass(title: "Starting title!")
    print("ObjectA: ", objectA.title)

    /// Class is a REFERENCE type.
    /// Both objectA and objectB are pointing the same object in memory.
    let objectB = objectA
    print("OnjectB: ", objectB.title)

    print("Pass the REFERENCE of objectA to objectB.")
    objectB.title = "Second title!"
    print("ObjectB title changed.")

    print("ObjectA: ", objectA.title)  // Second Title!
    print("ObjectB: ", objectB.title)  // Second Title!
  }

  /// When we need to access to objects, we need to await as actors need to be thread safe.
  private func actorTest1() {
    Task {
      let objectA = MyActor(title: "Starting title!")
      await print("ObjectA: ", objectA.title)

      let objectB = objectA
      await print("OnjectB: ", objectB.title)

      print("Pass the REFERENCE of objectA to objectB.")
      await objectB.updateTitle(newTitle: "Second Title!")
      /// We can't to operate the below line as we need to make this thread safe function.
      //      objectB.title = "Second title!"
      print("ObjectB title changed.")

      await print("ObjectA: ", objectA.title)  // Second Title!
      await print("ObjectB: ", objectB.title)  // Second Title!
    }

  }
}

// MARK: Struct
extension StructClassActorView {
  private func structTest2() {
    print("structTest2")

    /// These all function in the same way.
    var struct1 = MyStruct(title: "Title1")
    print("Struct1: ", struct1.title)
    struct1.title = "Title2"
    print("Struct1: ", struct1.title)

    var struct2 = CustomStruct(title: "Title1")
    print("Struct2: ", struct2.title)
    struct2 = CustomStruct(title: "Title2")
    print("Struct2: ", struct2.title)

    var struct3 = CustomStruct(title: "Title1")
    print("Struct3: ", struct3.title)
    struct3 = struct3.updateTitle(newTitle: "Title2")
    print("Struct3: ", struct3.title)

    var struct4 = MutatingStruct(title: "Title4")
    print("Struct4: ", struct4.title)
    struct4.updateTitle(newTitle: "Title2")
    print("Struct4: ", struct4.title)
  }
}

extension StructClassActorView {
  private func classTest2() {
    print("classTest2")

    let class1 = Myclass(title: "Title1")
    print("Class1: ", class1.title)
    class1.title = "Title2"
    print("Class1: ", class1.title)

    let class2 = Myclass(title: "Title1")
    print("class2: ", class2.title)
    class2.updateTitle(newTitle: "Title2")
    print("class2: ", class2.title)
  }
}
