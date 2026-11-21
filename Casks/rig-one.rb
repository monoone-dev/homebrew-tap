cask "rig-one" do
  version "1.27.0"
  sha256 "731f72677a1333727db9db62fd871aac09f7668bdb17bac4a8b0833e0afd4ce7"

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
