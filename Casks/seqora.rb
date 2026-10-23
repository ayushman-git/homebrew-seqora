cask "seqora" do
  version "0.4.4"
  sha256 "7f4dffe1c34a48cb3d49942c8d6c206f436803065e493d0eb19eb8a0405c177d"

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
