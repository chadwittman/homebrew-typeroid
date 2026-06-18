cask "typeroid" do
  version "0.2.11"
  sha256 "d0b449e063906481dd89a2b9c1c6d50859a4b8acbdc7cb8646a5162aa68b1081"

  url "https://github.com/chadwittman/typeroid/releases/download/v#{version}/typeROID.dmg",
      verified: "github.com/chadwittman/typeroid/"
  name "typeROID"
  desc "AI text cleanup in any app — type like a goblin, send like a grown-up"
  homepage "https://github.com/chadwittman/typeroid"

  depends_on macos: :sonoma
  depends_on formula: "whisper-cpp"

  auto_updates true

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

    Voice brief mode uses local Whisper. This cask installs whisper-cpp and
    downloads the tiny English model to:
      ~/.typeroid/models/ggml-tiny.en.bin
  EOS

  livecheck do
    url :url
    strategy :github_latest
  end
end
