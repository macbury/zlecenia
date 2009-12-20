xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "webpraca.net | Oferty"
    xml.link offers_url(stripped_params(:format => :html))
    
    for offer in @offers
      xml.item do
        xml.title "[#{ETAT_LABELS[offer.etat]}] #{offer.title}"
        xml.description truncate(offer.description, :length => 512)
        xml.pubDate offer.created_at.to_s(:rfc822)
        xml.link offer_url(offer)
        xml.guid offer_url(offer)
      end
    end


  end
end