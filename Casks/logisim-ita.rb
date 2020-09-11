cask 'logisim-ita' do
  version '2.16.1.2'
  sha256 '5841e8c4adfe3363b845c34eebbe2a2eceaac36ba49f5ef58d773808e4aa95d4'

  url "https://github.com/LogisimIt/Logisim/releases/download/v#{version}/Logisim-ITA.jar"
  appcast 'https://github.com/LogisimIt/Logisim/releases.atom'
  name 'Logisim ITA'
  homepage 'https://github.com/LogisimIt/Logisim'

  depends_on cask: 'java'

  container type: :naked

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/logisim-ita.wrapper.sh"
  binary shimscript, target: 'logisim-ita'

  preflight do
    IO.write shimscript, <<~EOS
      #!/bin/bash
      cd "$(dirname "$(readlink -n "${0}")")" && \
        java "${@}" -jar 'Logisim-ITA.jar'
    EOS
  end

  zap trash: '~/Library/Preferences/com.cburch.logisim.plist'
end
