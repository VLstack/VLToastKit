import Foundation
import SwiftUI
import Testing
@testable import VLToastKit

@MainActor
@Suite("Toast manager")
struct ManagerTests
{
 private struct SampleError: LocalizedError
 {
  var errorDescription: String? { "Sample error" }
 }

 /// Counts the calls of `onDismiss`
 @MainActor
 private final class Counter
 {
  var value = 0
  func increment() { value += 1 }
 }

 private func messages(_ manager: VLToast.Manager) -> [String]
 {
  manager.items.map(\.message)
 }

 // MARK: - Shortcuts
 @Test("Default type and duration of each shortcut")
 func shortcutDefaults()
 {
  let manager = VLToast.Manager()
  manager.success("success")
  manager.info("info")
  manager.warning("warning")
  manager.danger("danger")

  let items = manager.items.reversed().map { ($0.type, $0.duration) }
  #expect(items.map(\.0) == [ .success, .info, .warning, .danger ])
  #expect(items.map(\.1) == [ 2, 2, 3, 5 ])
  #expect(manager.items.allSatisfy { $0.feedback == nil })
 }

 @Test("Error shows its description without duration")
 func errorShortcut() throws
 {
  let manager = VLToast.Manager()
  manager.error(SampleError())

  let item = try #require(manager.items.first)
  #expect(item.type == .danger)
  #expect(item.duration == nil)
  #expect(item.message == "Sample error")
 }

 @Test("Duration and feedback given by the caller are kept")
 func customValues() throws
 {
  let manager = VLToast.Manager()
  manager.warning("warning", duration: 7, feedback: .success)

  let item = try #require(manager.items.first)
  #expect(item.duration == 7)
  #expect(item.feedback == .success)
 }

 // MARK: - Stack
 @Test("Newest toast comes first and every toast stays")
 func stackOrder()
 {
  let manager = VLToast.Manager()
  manager.info("A")
  manager.success("B")
  manager.warning("C")

  #expect(messages(manager) == [ "C", "B", "A" ])
 }

 @Test("Latest is the last toast shown and survives its dismissal")
 func latest() throws
 {
  let manager = VLToast.Manager()
  manager.info("A")
  manager.info("B")

  let latest = try #require(manager.latest)
  #expect(latest.message == "B")

  manager.dismiss(id: latest.id)
  #expect(manager.latest?.message == "B")
 }

 @Test("Dismiss removes only the toast with this identifier")
 func dismissOne()
 {
  let manager = VLToast.Manager()
  manager.info("A")
  manager.info("B")
  manager.info("C")

  manager.dismiss(id: manager.items[1].id)
  #expect(messages(manager) == [ "C", "A" ])
 }

 @Test("Dismissing an unknown identifier does nothing")
 func dismissUnknown()
 {
  let manager = VLToast.Manager()
  manager.info("A")

  manager.dismiss(id: UUID())
  #expect(messages(manager) == [ "A" ])
 }

 @Test("onDismiss is called once")
 func onDismissOnce() throws
 {
  let manager = VLToast.Manager()
  let counter = Counter()
  manager.info("A", onDismiss: counter.increment)

  let id = try #require(manager.items.first?.id)
  manager.dismiss(id: id)
  manager.dismiss(id: id)
  #expect(counter.value == 1)
 }

 @Test("Beyond the maximum, the oldest toast leaves, even a persistent one")
 func maximumCount()
 {
  let manager = VLToast.Manager()
  let counter = Counter()
  manager.error(SampleError(), onDismiss: counter.increment)
  (1...VLToast.Manager.maximumCount).forEach { manager.info("\($0)") }

  #expect(manager.items.count == VLToast.Manager.maximumCount)
  #expect(messages(manager) == [ "5", "4", "3", "2", "1" ])
  #expect(counter.value == 1)
 }

 // MARK: - Timers
 @Test("A toast closes by itself after its duration")
 func autoDismiss() async throws
 {
  let manager = VLToast.Manager()
  let counter = Counter()
  manager.success("A", duration: 0.1, onDismiss: counter.increment)

  try await Task.sleep(for: .milliseconds(500))
  #expect(manager.items.isEmpty)
  #expect(counter.value == 1)
 }

 @Test("A toast without duration, or with a zero duration, stays")
 func noDuration() async throws
 {
  let manager = VLToast.Manager()
  manager.info("nil", duration: nil)
  manager.info("zero", duration: 0)

  try await Task.sleep(for: .milliseconds(300))
  #expect(messages(manager) == [ "zero", "nil" ])
 }

 @Test("A persistent toast stays while the others expire")
 func persistentStays() async throws
 {
  let manager = VLToast.Manager()
  manager.error(SampleError())
  manager.success("A", duration: 0.1)
  manager.info("B", duration: 0.1)

  try await Task.sleep(for: .milliseconds(500))
  #expect(messages(manager) == [ "Sample error" ])
 }

 @Test("An expiring toast never removes a newer one")
 func expiringKeepsNewer() async throws
 {
  let manager = VLToast.Manager()
  manager.info("old", duration: 0.1)
  manager.info("new", duration: 60)

  try await Task.sleep(for: .milliseconds(500))
  #expect(messages(manager) == [ "new" ])
 }

 @Test("Closing a toast by hand cancels its timer")
 func manualDismissCancelsTimer() async throws
 {
  let manager = VLToast.Manager()
  let counter = Counter()
  manager.info("A", duration: 0.2, onDismiss: counter.increment)

  let id = try #require(manager.items.first?.id)
  manager.dismiss(id: id)

  try await Task.sleep(for: .milliseconds(500))
  #expect(counter.value == 1)
 }
}
