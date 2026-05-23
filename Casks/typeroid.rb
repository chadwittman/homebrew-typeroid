cask "typeroid" do
  version "0.2.0"
  sha256 "5d9cbbaaba0b8e7bf5b7f53e168ebc17cbaa3a398c50ccdfaeeb7e0b76d33040"

  url "https://github.com/chadwittman/typeroid/releases/download/v#{version}/typeROID.dmg",
      verified: "github.com/chadwittman/typeroid/"
  name "typeROID"
  desc "AI text cleanup in any app — type like a goblin, send like a grown-up"
  homepage "https://github.com/chadwittman/typeroid"

  depends_on macos: ">= :sonoma"

  auto_updates true

  app "typeROID.app"

  uninstall quit: "com.typeroid.app"

  zap trash: [
    "~/Library/Preferences/com.typeroid.app.plist",
    "~/.typeroid",
  ]

  livecheck do
    url :url
    strategy :github_latest
  end
end
