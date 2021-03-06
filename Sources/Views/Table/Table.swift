import SwiftUI

@resultBuilder
public struct Table: ListView {
 public var content: TableContent
 @State public var axis: Axis.Set = .vertical
 @State public var showsIndicators = true
}

// MARK: Conformances
extension Table: View {
 public var body: some View {
  AnyTable(
   self, content
  )
 }
}

// MARK: Build Blocks
public extension Table {
 static func buildBlock<V>(_ views: V...) -> TableContent.Wrapper
 where V: View {
  ForEach(Array(0 ..< views.count), id: \.self) { element in
   guard let value = element as? Int else {
    return TableRow()
   }
   return TableRow(views[value])
  }
 }
}

// MARK: Intiializers
public extension Table {
 init<E: Hashable, V: View>(
  _ elements: [E],
  @ViewBuilder content: @escaping (E) -> V
 ) {
  self.content = TableContent(data: elements, content: content)
 }

 init(
  @Table content: @escaping () -> TableContent.Wrapper
 ) {
  let wrapper = content()
  self.content = TableContent(data: wrapper.data, wrapper)
 }
}

// MARK: Properties
public extension Table {
 @available(macOS 11.0, *)
 enum SeparatorStyle: View {
  case none,
       plain(Color? = nil),
       dashed(Color? = nil)
  public var body: some View {
   switch self {
   case let .plain(color):
    Divider()
     .background(color ?? .separator)
   case let .dashed(color):
    Separator(
     color: color,
     lineWidth: 0.75, dash: [2]
    )
   default: EmptyView()
   }
  }
 }
}
