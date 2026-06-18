# homebrew-typeroid

Homebrew tap for [typeROID](https://github.com/chadwittman/typeroid) — AI text cleanup in any app.

## Install

```bash
brew install --cask chadwittman/typeroid/typeroid
```

## Verify

Every release is signed with a Developer ID certificate and notarized by Apple. The cask pins the exact SHA-256 of the DMG — Homebrew checks this automatically on install.

To verify yourself:

```bash
# Download the DMG and check it matches the sha256 in Casks/typeroid.rb
shasum -a 256 ~/Downloads/typeROID.dmg

# Check the app is properly signed and notarized
codesign -dv --verbose=4 /Applications/typeROID.app
spctl -a -v /Applications/typeROID.app
```

## Update

```bash
brew reinstall --cask --force chadwittman/typeroid/typeroid
```

This downloads the current cask and replaces the installed app, including a manually installed copy already in `/Applications`. The menu bar version should match the latest release after relaunch.

## Uninstall

```bash
brew uninstall --cask typeroid
```

To also remove preferences and config:

```bash
brew uninstall --zap --cask typeroid
```

## Audit the cask

The full cask definition is [Casks/typeroid.rb](Casks/typeroid.rb). The `verified:` field on the URL asserts the download must come from `github.com/chadwittman/typeroid/` — any change to that is visible in this repo's git history.
