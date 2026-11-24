cask "rig-one" do
  version "1.28.0"
  sha256 "dcb3dd1930124f38d8b292be7be66d8da71097d7135365e03df7cef8844dedc9"

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
