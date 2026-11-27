cask "index-one" do
  version "3.31.0"
  sha256 "78ef5645fc6d481aae5f79d052451ba2168992b3815b6ec86278cda1682902b1"

  url "https://github.com/monoone-dev/index-one-landing-page/releases/download/v#{version}/IndexOne-#{version}.dmg"
  name "IndexOne"
  desc "Meeting notes, transcription and personal knowledge notebook"
  homepage "https://index-one.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "IndexOne.app"

  caveats <<~EOS
    IndexOne requires macOS 13.4 or later.
  EOS
end
