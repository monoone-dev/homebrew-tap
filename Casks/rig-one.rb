cask "rig-one" do
  version "1.26.0"
  sha256 "75ac08ed47d9fec458b01e77f5deb572ee1b6e6a6a168bcfb88d43c6434066d5"

  url "https://github.com/monoone-dev/rig-one-landing-page/releases/download/v#{version}/RigOne_#{version}_aarch64.dmg"
  name "RigOne"
  desc "Control room for coding agents"
  homepage "https://rig-one.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "RigOne.app"
end
