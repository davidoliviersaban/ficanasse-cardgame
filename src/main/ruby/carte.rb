require 'squib'

deplacements = Squib.csv file: %w(src/resources/deplacements.csv), col_sep: "\t"
lieux = Squib.csv file: %w(src/resources/lieux.csv), col_sep: "\t"
informations = Squib.csv file: %w(src/resources/informations.csv), col_sep: "\t"

def drawDeplacementCards(deck, lieux, dirname)
  rect layout: :bleed
  rect layout: :cut
  rect layout: :inside

  text layout: "Titre", str: "Déplacements"

  %w(1 2 3 4 5).each do |idnum|
    ref = "Lieu" + idnum
    rect layout: ref, x: 100, width: 60
    text layout: ref+"Text", str: idnum, x: 110, width: 30
  end

  %w(Lieu1 Lieu2 Lieu3 Lieu4 Lieu5).each do |key|
    rect layout: key,
      x: 180,
      fill_color: deck[key].map{ |id| lieux["couleur"][id-1] }
    text layout: key+"Text",
      x: 200,
      str: deck[key].map{ |id| lieux["lieu"][id-1] }
  end

  text str: deck["id"].map{|id| id.to_s+"/60"}, layout: "Footer"

  save_png prefix: "deplacements", dir: dirname#dir: '_cards'

end


def drawInformationCards(deck, lieux, dirname)
  rect layout: :bleed
  rect layout: :cut
  rect layout: :inside

  text layout: "Titre", str: deck["titre"]

  text layout: "Message", str: deck["message"]

  text str: deck["id"].map{|id| id.to_s+"/60"}, layout: "Footer"

  save_png prefix: "informations", dir: dirname#dir: '_cards'

end

def drawCutlines(deck,dirname)
    rect layout: :bleed
    rect layout: :cut
    save_png prefix: "cut_deplacements", dir: dirname#dir: '_cards'
end

Squib::Deck.new(cards: deplacements["id"].size,
                layout: %w(src/resources/Vlayout.yml src/resources/carte.yml),
                width: '2.75in', height: '3.75in') do
    drawDeplacementCards(deplacements, lieux,'_cards')
end

Squib::Deck.new(cards: informations["id"].size,
                layout: %w(src/resources/Vlayout.yml src/resources/carte.yml),
                width: '2.75in', height: '3.75in') do
    drawInformationCards(informations, lieux,'_cards')
end
