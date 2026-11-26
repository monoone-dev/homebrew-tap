cask "index-one" do
  version "3.28.0"
  sha256 "99df14fbcf1ff288839855ef2abcf13921e782354e43bde0b30bb83149eadb70"

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
