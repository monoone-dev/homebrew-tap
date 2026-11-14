cask "rig-one" do
  version "1.25.0"
  sha256 "513c8d016ecd39462079833c3edc835421aed6d93d0a8e5b79e4c61122b98e49"

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
