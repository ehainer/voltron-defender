require 'voltron/defender/command'

module Voltron
  class Defender
    class Defender < Command

      def responds_to
        ['defender']
      end

      def respond_with(adapter)
        output = "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMNdMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMdNMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMm+.-MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..+mMMMMMMMMMMMMM\nMMMMMMMMMMMMm`---MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.--`mMMMMMMMMMMMM\nMMMMMMMMMMMMh ...mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm`.. hMMMMMMMMMMMM\nMMMMMMMMMMMM:.--`sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMo`--.:MMMMMMMMMMMM\nMMMMMMMMMMMM:.--.oMMMMMMmhhhhhhhho/ooooo/ohhhhhhhhmMMMMMMo.--.:MMMMMMMMMMMM\nMMMMMMMMMMMM:.--.oMMMMMy.--------.:MMMMM-.--------.oNMMMMo.--.:MMMMMMMMMMMM\nMMMMMMMMMMMM:.---.odmd/..::::::::-yNNNNNy-::::::::..:dmdo.---.:MMMMMMMMMMMM\nMMMMMMMMMMMMh:.-------..sNNNNNNNNNMhhhhhNNNNNNNNNNh-.-------.:hMMMMMMMMMMMM\nMMMMMMMMMMMMMNd/..---.-dMMMMMMMMMMNyyyyymMMMMMMMMMMN/.---..+dNMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMm+`-.:NMMMMMMMMMMMmhhhhhdMMMMMMMMMMMMo`-`/mMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMm`--./MMMsydmNNMMMMNNNNNMMMMNNmmhomMMh`--`yMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMM/.:smMMMh+/+++odMMMMMMMMMMoo++/+oMMMNh/..NMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMM.hNMMMMMMNmdhyshMMMMMMMMMNosyhdmNMMMMMMm-dMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMM-dMNmMMmddhhysooMMMMMMMMMdosyhhddmMMdmMM`NMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMM/yNooMM+`       mMMMMMMMM+      `+MMoodN`MMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMooNoodMm-`      ymdNMNmdM-     `-NMmoomd-MMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMy:Mo+sMMNho+/:-.smhhhhyhM--:/+oo/mMh++my/MMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMm.MsoomMMN...-:/+yhmmmdyo/:-.`` .MMsooMooMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMM`Ny++hMMMo       `:No.        `oMN++oM:yMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMs/msooNyMdo/:-...shdhh:`..-:+odyMyooms/NMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMy/dsodyyymooooohNdhhmNooooohydoNooho+NMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMh:msoN-mMMhysomMh//smssyyydM:msom++MMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMh:dsdo-NMy/+omMy ./ho+/+NMs:msh+oMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMdoss-`/md//+yMy .oy///dNs`.+ssyMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMs..`ydymMMdoss////h-`--NMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMM:-``dMMMNdhyyss/s: :`dMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMm`:`.hmMh///+yh+o --+MMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMs.:  -/`    .:` .:-NMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:::::`      -::/`dMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNs/-:`-::::..:-+hMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNhyyyyyyyydMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM\nMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
        adapter.message("```#{output.gsub('`', '\'')}```")
      end

    end
  end
end