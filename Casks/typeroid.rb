cask "typeroid" do
  version "0.2.0"
  sha256 "5d9cbbaaba0b8e7bf5b7f53e168ebc17cbaa3a398c50ccdfaeeb7e0b76d33040"

  url "https://github.com/chadwittman/typeroid/releases/download/v#{version}/typeROID.dmg"
  name "typeROID"
  desc "Performance-enhancing drugs for your typing. AI text cleanup in any app."
  homepage "https://github.com/chadwittman/typeroid"

  depends_on macos: ">= :sonoma"

  app "typeROID.app"

  zap trash: [
    "~/Library/Preferences/com.typeroid.app.plist",
    "~/.typeroid",
  ]
end
