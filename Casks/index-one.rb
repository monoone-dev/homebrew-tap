cask "index-one" do
  version "3.23.0"
  sha256 "c758da5e190b42ad74276a62a03d01a90d1c9fb79a54c04c9bd906c8fa5e00fb"

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
