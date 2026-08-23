import Foundation
import AgentAudit

/// Module-scoped shadow of Swift.print: every print in this library also
/// lands in the unified log (Console.app) under the Agent audit subsystem's
/// Disk category. In-process GUI use previously lost this output entirely —
/// stdout of a .app goes nowhere. Call sites stay untouched; stdout behavior
/// is preserved for CLI/debug runs.
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    let message = items.map { "\($0)" }.joined(separator: separator)
    Swift.print(message, terminator: terminator)
    let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
    if !trimmed.isEmpty {
        AuditLog.log(.disk, trimmed)
    }
}
