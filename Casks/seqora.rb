cask "seqora" do
  version "0.3.1"
  sha256 "41da3a9c4de96d2ce50000192fecf344be7a3bc6d85e6756f76bd25d19e95db3"

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
