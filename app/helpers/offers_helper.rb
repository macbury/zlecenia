module OffersHelper
	def offer_label(offer)
		html = ""
		html += content_tag :span, ETAT_LABELS[offer.etat], :class => "etykieta #{ETAT_LABELS[offer.etat]}"
		html += content_tag :span, "Praca zdalna", :class => "etykieta zdalnie" if offer.zdalnie
		
		return html
	end
end
