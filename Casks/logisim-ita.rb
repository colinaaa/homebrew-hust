cask 'logisim-ita' do
  version '2.16.1.2'
  sha256 '5841e8c4adfe3363b845c34eebbe2a2eceaac36ba49f5ef58d773808e4aa95d4'
  desc 'The logisim fork'

  url "https://github.com/LogisimIt/Logisim/releases/download/v#{version}/Logisim-ITA.jar"
  appcast 'https://github.com/LogisimIt/Logisim/releases.atom'
  name 'Logisim ITA'
  homepage 'https://github.com/LogisimIt/Logisim'

  container type: :naked

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/logisim-ita.wrapper.sh"

  preflight do
    IO.write shimscript, <<~EOS
      #!/bin/bash
      java "${@}" -jar '/Applications/Logisim-ITA.jar'
    EOS
  end

  app "Logisim-ITA.jar", target: "Logisim-ITA.jar"
  binary shimscript, target: 'logisim-ita'

  caveats do
    depends_on_java "8+"
  end

  zap trash: '~/Library/Preferences/com.cburch.logisim.plist'
end
