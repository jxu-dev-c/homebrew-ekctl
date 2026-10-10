class Ekctl < Formula
  desc "macOS CLI tool for managing Calendar events and Reminders via EventKit"
  homepage "https://github.com/jxu-dev-c/ekctl"
  url "https://github.com/jxu-dev-c/ekctl/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "fa82c6c4659c358a97ed042ae962088350f848aba15ebda69c3a3a5497d9885d"
  license "MIT"
  head "https://github.com/jxu-dev-c/ekctl.git", branch: "main"

  depends_on xcode: ["14.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/ekctl"
  end

  def caveats
    <<~EOS
      On first run, macOS will prompt you to grant access to Calendars and Reminders.
      You can manage these permissions in:
        System Settings → Privacy & Security → Calendars
        System Settings → Privacy & Security → Reminders

      Quick start:
        # See what calendars and reminder lists you have
        ekctl list calendars

        # Set up aliases so you don't have to paste UUIDs everywhere
        ekctl alias set work "YOUR_CALENDAR_ID"
        ekctl alias set personal "YOUR_REMINDERS_ID"

        # Quick views (no date arithmetic required)
        ekctl today --calendar work
        ekctl tomorrow --calendar work
        ekctl next --calendar work --count 3

        # Filter and combine — composes with --search, --availability, --format
        ekctl today --calendar work,personal --availability busy --format csv

        # Full CRUD
        ekctl add event --calendar work --title "Meeting" \\
          --start 2026-01-15T09:00:00Z --end 2026-01-15T10:00:00Z
        ekctl add reminder --list personal --title "Call mom"

      For more examples, see: https://github.com/jxu-dev-c/ekctl#usage
    EOS
  end

  test do
    assert_match "1.9.0", shell_output("#{bin}/ekctl --version")
    assert_match "calendars", shell_output("#{bin}/ekctl list --help")
    assert_match "today", shell_output("#{bin}/ekctl --help")
    assert_match "next", shell_output("#{bin}/ekctl --help")
    assert_match "alias", shell_output("#{bin}/ekctl --help")
    # `--format` is on every output-producing command since 1.4.0
    assert_match "--format", shell_output("#{bin}/ekctl list events --help")
    # `update` arrived in 1.4.0; before that `ekctl update event` silently fell
    # through to `list`, so assert the real subcommand and its flags are here.
    assert_match "update", shell_output("#{bin}/ekctl --help")
    assert_match "--notes", shell_output("#{bin}/ekctl update event --help")
    assert_match "--alarms", shell_output("#{bin}/ekctl update event --help")
    # `--urgent` (ring as an alarm at the due time) arrived in 1.9.0
    assert_match "--urgent", shell_output("#{bin}/ekctl update reminder --help")
  end
end
