class Paletter < Formula
	desc "Convert tinty YAML color palettes to macOS .clr files"
	homepage "https://github.com/ceejbot/paletter"
	license "Parity-7.0.0"
	version "latest"

	if OS.mac?
	    url    "{{ UNIV_URL }}"
	    sha256 "{{ UNIV_SHA256 }}"
	end

	def target_triple
	    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
	    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
	    "#{cpu}-#{os}"
	end

    def install
        bin.install "paletter" if OS.mac? && Hardware::CPU.arm?
        bin.install "paletter" if OS.mac? && Hardware::CPU.intel?
        bin.install "paletter" if OS.linux? && Hardware::CPU.intel?
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
