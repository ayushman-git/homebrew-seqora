cask "seqora" do
  version "0.6.1"
  sha256 "efb311a9af8a5e945c4d260158dbe624dbd19ab9e3d9eeec76038b6f3e736bfb"

  url "https://releases.seqora.dev/releases/#{version}/downloads/Seqora_#{version}_aarch64.dmg"
  name "Seqora"
  desc "Database client for PostgreSQL, MySQL, MariaDB and SQLite"
  homepage "https://seqora.dev/"

  livecheck do
    url "https://releases.seqora.dev/channels/tester/latest.json"
    strategy :json do |json|
      latest = json["version"]
      latest unless latest&.include?("-")
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on :macos

  app "Seqora.app"

  zap trash: [
    "~/.seqora",
    "~/Library/Application Support/com.seqora.app",
    "~/Library/Caches/com.seqora.app",
    "~/Library/Caches/seqora",
    "~/Library/WebKit/com.seqora.app",
    "~/Library/WebKit/seqora",
  ]
end
