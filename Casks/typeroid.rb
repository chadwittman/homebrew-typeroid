cask "typeroid" do
  version "0.2.29"
  sha256 "6fe14c9fda205f75da7f3392b8d8bce5fdfc4ddd1054b67f46067856dc942781"

  url "https://github.com/chadwittman/typeroid/releases/download/v#{version}/typeROID.dmg",
      verified: "github.com/chadwittman/typeroid/"
  name "typeROID"
  desc "Hold fn and it types what you said. Then the shortcut stack."
  homepage "https://typeroid.xyz"

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
    Installed typeROID #{version}.

    To update an existing or manually installed copy:
      brew update
      brew reinstall --cask --force chadwittman/typeroid/typeroid

    Fn dictation uses local Whisper. This cask installs whisper-cpp
    and downloads the tiny English model to:
      ~/.typeroid/models/ggml-tiny.en.bin

    Hold the globe key to talk. Double-tap it for hands-free.
    The next press stops and pastes. Arrow keys do not start the microphone.
    // never starts voice.
  EOS

  livecheck do
    url :url
    strategy :github_latest
  end
end
