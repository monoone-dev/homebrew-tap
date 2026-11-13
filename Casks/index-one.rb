cask "index-one" do
  version "3.18.0"
  sha256 "5e2b493fe4928db3373a79d1ba74dd33a35a8356cc5b3c7d2c3671a3dad3fca9"

  url "https://github.com/monoone-dev/index-one-landing-page/releases/download/v#{version}/IndexOne-#{version}.dmg",
      verified: "github.com/monoone-dev/index-one-landing-page/"
  name "IndexOne"
  desc "Meeting notes, transcription and personal knowledge notebook"
  homepage "https://index-one.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= 13.4"

  app "IndexOne.app"
end
