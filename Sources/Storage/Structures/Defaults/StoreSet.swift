import protocol Core.Infallible
import SwiftUI

@available(macOS 10.15, iOS 13.0, *)
public extension Store {
 /// A `UserDefaults` wrapper for any array of objects that conform to `AutoCodable`.
 /// If no value is found it simply returns an empty array instead of `nil`
 @available(macOS 10.15, iOS 13.0, *)
 @propertyWrapper
 struct Set: DefaultsWrapper {
  public var store: UserDefaults = .standard
  public let key: String

  public var wrappedValue: [Value] {
   get {
    do {
     if let data = store.data(forKey: key) {
      return try Value.decoder.decode([Value].self, from: data)
     }
     return []
    } catch {
     debugPrint(
      Error<Value>.read(
       description: error.localizedDescription
      )
     )
    }
    return []
   }
   nonmutating set {
    do {
     let data = try Store.encoder.encode(newValue)
     store.set(data, forKey: key)
    } catch {
     debugPrint(
      Error<Value>.write(
       description: error.localizedDescription
      )
     )
    }
   }
  }

  @available(iOS 13.0, *)
  public var projectedValue: Binding<[Value]> {
   Binding<[Value]>(
    get: { self.wrappedValue },
    set: { self.wrappedValue = $0 }
   )
  }

  public init(
   wrappedValue: [Value] = [],
   _ key: String, store: UserDefaults? = nil
  ) {
   self.key = key
   if let store =
    store { self.store = store }
   if self.store.object(forKey: key) == nil {
    self.wrappedValue = wrappedValue
   }
  }
 }
}
