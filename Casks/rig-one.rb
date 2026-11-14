cask "rig-one" do
  version "1.24.0"
  sha256 "ef0642c7d95c9072265030b73dc2b80b610a1438b9be3ed264f0d20a478476f4"

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
