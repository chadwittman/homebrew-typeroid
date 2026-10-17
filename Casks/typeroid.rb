cask "typeroid" do
  version "0.2.25"
  sha256 "37edeaabc6907557c6693adc2e16876a7d1e5bd7263d4334e1f80a37e482d44f"

  url "https://github.com/chadwittman/typeroid/releases/download/v#{version}/typeROID.dmg",
      verified: "github.com/chadwittman/typeroid/"
  name "typeROID"
  desc "AI text cleanup in any app — type like a goblin, send like a grown-up"
  homepage "https://github.com/chadwittman/typeroid"

  depends_on macos: :sonoma
  depends_on formula: "whisper-cpp"

  app "typeROID.app"

  uninstall quit: "com.typeroid.app"

  zap trash: [
    "~/Library/Preferences/com.typeroid.app.plist",
    "~/.typeroid",
  ]

  postflight do
    model_dir = Pathname("#{Dir.home}/.typeroid/models")
    model_path = model_dir/"ggml-tiny.en.bin"

    FileUtils.mkdir_p(model_dir)
    unless model_path.exist?
      system_command "/usr/bin/curl",
                     args: [
                       "-L",
                       "--fail",
                       "-o", model_path,
                       "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en.bin",
                     ]
    end
  end

  caveats <<~EOS
    To update an existing or manually installed copy:
      brew reinstall --cask --force chadwittman/typeroid/typeroid

    Fn dictation and voice brief use local Whisper. This cask installs whisper-cpp
    and downloads the tiny English model to:
      ~/.typeroid/models/ggml-tiny.en.bin

    Hold fn to talk. Double-tap fn for hands-free. Type ,, for a voice brief.
    // never starts voice.
  EOS

  livecheck do
    url :url
    strategy :github_latest
  end
end
