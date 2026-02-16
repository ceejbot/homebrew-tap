class Paletter < Formula
    desc "Convert tinty YAML color palettes to macOS .clr files"
    homepage "https://github.com/ceejbot/paletter"
    version "1.0.1"
    license "Parity-7.0.0"

    if OS.mac?
        url    "https://github.com/ceejbot/paletter/releases/download/v1.0.1/paletter-universal-apple-darwin.tar.gz"
        sha256 "9c8737410269804fbc696f608f0adf6d7cbbe7d85cbc4b04ae14dcf5e6537226"
    end

    BINARY_ALIASES = {
        "aarch64-apple-darwin":     {},
        "x86_64-apple-darwin":      {},
    }.freeze

    def target_triple
        cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
        os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
        "#{cpu}-#{os}"
    end

    def install_binary_aliases!
        BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
            dests.each do |dest|
            bin.install_symlink bin/source.to_s => dest
            end
        end
    end

    def install
        bin.install "paletter" if OS.mac?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end

    test do
        # Create a simple test YAML file
        (testpath/"test.yaml").write <<~EOS
            system: "base16"
            name: "Test"
            author: "Test"
            variant: "dark"
            palette:
            base00: "#000000"
            base01: "#111111"
            base02: "#222222"
            base03: "#333333"
            base04: "#444444"
            base05: "#555555"
            base06: "#666666"
            base07: "#777777"
            base08: "#888888"
            base09: "#999999"
            base0A: "#aaaaaa"
            base0B: "#bbbbbb"
            base0C: "#cccccc"
            base0D: "#dddddd"
            base0E: "#eeeeee"
            base0F: "#ffffff"
        EOS

        system "#{bin}/paletter", testpath.to_s
        assert_predicate testpath/"test.clr", :exist?
    end
end
