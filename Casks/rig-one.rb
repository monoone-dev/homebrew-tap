cask "rig-one" do
  version "1.22.0"
  sha256 "4e3c7daa114e0699b08e28a3955aa42ca00ac90a0056722f29c1e4c8436bfaab"

  url "https://github.com/monoone-dev/rig-one-landing-page/releases/download/v#{version}/RigOne_#{version}_aarch64.dmg",
      verified: "github.com/monoone-dev/rig-one-landing-page/"
  name "RigOne"
  desc "Control room for coding agents"
  homepage "https://rig-one.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "RigOne.app"
end
