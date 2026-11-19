cask "seqora" do
  version "0.6.3"
  sha256 "67da0667ec7efb781b1d27af21b770e07f4956195b6f6aaa7ed22d9eeedc1241"

  url "https://releases.seqora.dev/releases/#{version}/downloads/Seqora_#{version}_universal.dmg"
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
  depends_on macos: :monterey

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
