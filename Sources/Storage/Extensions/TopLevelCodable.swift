import Combine

@available(macOS 10.15, iOS 13.0, *)
public extension TopLevelDecoder {
  func decode<T>(
    _ type: T.Type,
    fromArray array: [Input]
  ) throws -> [T] where T: Decodable {
    try array.map { try self.decode(type, from: $0) }
  }
}

@available(macOS 10.15, iOS 13.0, *)
public extension TopLevelEncoder {
  func encode<T>(
    set: [T]
  ) throws -> [Output] where T: Encodable {
    try set.map { try self.encode($0) }
  }
}
