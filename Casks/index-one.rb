cask "index-one" do
  version "3.24.0"
  sha256 "f3131ab1a6b98e49833fcd7b77f1cdecc1cb6999562c03b19e31e0e624c67111"

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
