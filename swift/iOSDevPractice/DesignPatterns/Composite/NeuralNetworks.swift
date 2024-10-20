//import Foundation
//
///// Overview
///// Neuron and NeuronLayer are defined as sequences of neurons.
///// Connections between entities (Neuron ↔ Neuron or Neuron ↔ Layer) are enabled through a generic extension of Sequence.
///// The core idea is that you can treat both individual neurons and collections of neurons uniformly when connecting them.
//
//class Neuron: Sequence {
//  var inputs = [Neuron]()
//  var outputs = [Neuron]()
//
//  func makeIterator() -> IndexingIterator<[Neuron]> {
//    return IndexingIterator(_elements: [self])
//  }
//
//  //  func connect(_ to: Neuron) {
//  //    outputs.append(to)
//  //    to.inputs.append(self)
//  //  }
//}
//
//class NeuronLayer: Sequence {
//  private var neurons: [Neuron]
//
//  func makeIterator() -> IndexingIterator<[Neuron]> {
//    return IndexingIterator(_elements: neurons)
//  }
//
//  init(_ count: Int) {
//    neurons = Array(repeating: Neuron(), count: count)
//  }
//}
//
///// This is very concise, very pretty, and it's just a single function which allows two different elements,
///// two different classes of elements to connect to one another in any configuration.
//extension Sequence {
//  func connect<Seq: Sequence>(to other: Seq) where Self.Element == Neuron, Seq.Element == Neuron {
//    for from in self {
//      for t in other {
//        from.outputs.append(t)
//        t.inputs.append(from)
//      }
//    }
//  }
//}
//
//func main() {
//  let neuron1 = Neuron()
//  let neuron2 = Neuron()
//  let layer1 = NeuronLayer(10)
//  let layer2 = NeuronLayer(20)
//
//  neuron1.connect(to: neuron2)
//  neuron1.connect(to: layer1)
//  layer1.connect(to: neuron1)
//  layer1.connect(to: layer2)
//}
//
//main()
