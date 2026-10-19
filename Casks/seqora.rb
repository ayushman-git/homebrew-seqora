cask "seqora" do
  version "0.4.1"
  sha256 "3e4b9c203d21529b2ea04d3fde9a8f510d0751549473a086ac808de9ec7a00f6"

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
