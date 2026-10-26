cask "seqora" do
  version "0.4.6"
  sha256 "5ef6d1bbed81883f95ae581bcf305e73140b20cdd4d766b8fc7b511e84d67e9b"

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
