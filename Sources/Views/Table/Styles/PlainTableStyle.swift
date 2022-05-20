import SwiftUI

@available(macOS 11.0, *)
public struct PlainTableStyle: TableStyle {
 public func body(content: Body) -> some View {
  content
 }

 public func content(content: Content) -> some View {
  content
 }

 public func row(content: Row) -> some View {
  content
   .rowStyle(PlainRowStyle())
 }

 public init() {}
}
