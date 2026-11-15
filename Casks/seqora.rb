cask "seqora" do
  version "0.6.2"
  sha256 "16c22575435c14f47678808a9b0dfbf727bee2cc9e2d4b7821e0263a8a8c22da"

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
