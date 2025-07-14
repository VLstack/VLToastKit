import VLstackNamespace

extension VLstack.Toast
{
 public enum ItemType: Int, Identifiable
 {
  public var id: Self.RawValue { self.rawValue }

  case danger = 0
  case info = 1
  case success = 2
  case warning = 3
 }
}
