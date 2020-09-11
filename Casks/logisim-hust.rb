cask 'logisim-hust' do
  version '2.15.0.2'
  sha256 'e445889bcc2e812ef27d41e47bccfd51c336ad4123bd69c75e745d1600b0941a'
  desc 'The logisim fork of HUST'

  url "https://github.com/colinaaa/homebrew-logisim-hust/releases/download/v#{version}/Logisim-hust.jar"
  appcast 'https://github.com/colinaaa/homebrew-logisim-hust/releases.atom'
  name 'Logisim HUST'
  homepage 'https://github.com/colinaaa/homebrew-logisim-hust'

  container type: :naked

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/logisim-hust.wrapper.sh"
  binary shimscript, target: 'logisim-hust'

  preflight do
    IO.write shimscript, <<~EOS
      #!/bin/bash
      cd "$(dirname "$(readlink -n "${0}")")" && \
        java "${@}" -jar 'Logisim-hust.jar'
    EOS
  end
end
