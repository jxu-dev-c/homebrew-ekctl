# Homebrew Tap for ekctl

This is jxu-dev-c’s personal Homebrew tap for [ekctl](https://github.com/jxu-dev-c/ekctl) - a native macOS CLI tool for managing Calendar events and Reminders via EventKit.

## Installation

```bash
# Add the tap
brew tap jxu-dev-c/ekctl

# Install ekctl
brew install jxu-dev-c/ekctl/ekctl
```

The stable formula preserves version 1.4.0 during migration and builds from the personal fork. The `--HEAD` option builds the fork’s `main` branch.

Upstream: [schappim/ekctl](https://github.com/schappim/ekctl).

## Quick Start

```bash
# List all calendars and get their IDs
ekctl list calendars

# Set up aliases for easier use (recommended)
ekctl alias set work "YOUR_CALENDAR_ID"
ekctl alias set personal "YOUR_REMINDERS_ID"
ekctl alias set groceries "YOUR_GROCERY_LIST_ID"

# Now use friendly names instead of long IDs!
ekctl list events --calendar work --from "2026-01-01T00:00:00Z" --to "2026-01-31T23:59:59Z"
ekctl add event --calendar work --title "Team Meeting" --start "2026-01-15T09:00:00Z" --end "2026-01-15T10:00:00Z"
ekctl add reminder --list groceries --title "Buy milk"
```

## Usage

```bash
# List all calendars and reminder lists
ekctl list calendars

# Manage aliases
ekctl alias set work "CA513B39-1659-4359-8FE9-0C2A3DCEF153"
ekctl alias list
ekctl alias remove work

# List events (using alias or ID)
ekctl list events \
  --calendar work \
  --from "2026-01-01T00:00:00Z" \
  --to "2026-01-31T23:59:59Z"

# Add an event
ekctl add event \
  --calendar work \
  --title "Team Meeting" \
  --start "2026-01-15T09:00:00Z" \
  --end "2026-01-15T10:00:00Z"

# List incomplete reminders
ekctl list reminders --list personal --completed false

# Add a reminder with due date
ekctl add reminder \
  --list personal \
  --title "Call dentist" \
  --due "2026-01-20T09:00:00Z"

# Mark reminder as completed
ekctl complete reminder "REMINDER_ID"
```

## Permissions

On first run, macOS will prompt you to grant access to Calendars and Reminders. You can manage these permissions in:

- **System Settings → Privacy & Security → Calendars**
- **System Settings → Privacy & Security → Reminders**

## Documentation

For complete documentation and more examples, see the [ekctl README](https://github.com/jxu-dev-c/ekctl).

## License

MIT License
