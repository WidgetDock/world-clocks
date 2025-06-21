import Foundation
import AppKit
import PockKit

class wcWidget: PKWidget {
    static let identifier: String = "widgetdock.World‑Clocks"
    var customizationLabel: String {
        get { "World Clocks" }
        set { /* optionally handle set */ }
    }

    private var timeZones: [TimeZone] = [.current, TimeZone(secondsFromGMT: 0)!]
    private let stack = NSStackView()
    var view: NSView! {
        get { stack }
        set { /* optionally handle set */ }
    }

    required init() {
        buildUI()
        view = stack
        updateTimes()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimes()
        }
    }

    private func buildUI() {
        stack.orientation = .vertical
        stack.spacing = 4

        for _ in 0..<2 {
            let label = NSTextField(labelWithString: "--:--:--")
            label.alignment = .center
            label.font = .monospacedDigitSystemFont(ofSize: 10, weight: .medium)
            stack.addArrangedSubview(label)
        }
    }

    @objc private func saveSettings(_ sender: NSButton) {
        guard let stack = sender.superview as? NSStackView else { return }
        let combos = stack.arrangedSubviews.compactMap { $0 as? NSComboBox }
        for (i, cb) in combos.enumerated() {
            if let tz = TimeZone(identifier: cb.stringValue) {
                timeZones[i] = tz
            }
        }
        NSApp.stopModal()
        updateTimes()
    }

    private func updateTimes() {
        let date = Date()
        for (index, view) in stack.arrangedSubviews.enumerated() {
            guard let label = view as? NSTextField, index < timeZones.count else { continue }
            let formatter = DateFormatter()
            formatter.timeZone = timeZones[index]
            formatter.dateFormat = "HH:mm:ss"
            label.stringValue = formatter.string(from: date)
        }
    }
}
