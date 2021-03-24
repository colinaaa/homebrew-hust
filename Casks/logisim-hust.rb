cask 'logisim-hust' do
  version '2.15.0.2'
  sha256 'e445889bcc2e812ef27d41e47bccfd51c336ad4123bd69c75e745d1600b0941a'
  desc 'The logisim fork of HUST'

  url "https://github.com/colinaaa/homebrew-hust/releases/download/v#{version}/Logisim-hust.jar"
  appcast 'https://github.com/colinaaa/homebrew-hust/releases.atom'
  name 'Logisim HUST'
  homepage 'https://github.com/colinaaa/homebrew-hust'

  container type: :naked

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/logisim-hust.wrapper.sh"

  preflight do
    IO.write shimscript, <<~EOS
      #!/bin/bash
      java "${@}" -jar '/Applications/Logisim-hust.jar'
    EOS
  end

  app "Logisim-hust.jar", target: "Logisim-hust.jar"
  binary shimscript, target: 'logisim-hust'
  caveats do
    depends_on_java "8+"
  end

  zap trash: '~/Library/Preferences/com.cburch.logisim.plist'
end
