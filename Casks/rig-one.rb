cask "rig-one" do
  version "1.22.1"
  sha256 "9104f92e9a0a0f8f0e33746b757938e29c1e8f65f8f2359b9a2b6bf20ec28dce"

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
