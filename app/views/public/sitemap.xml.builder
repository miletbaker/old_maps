xml.instruct! :xml, :version=>"1.0" 
xml.tag! 'urlset', "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

	@maps.each do |map|
		xml.tag! 'url' do
			xml.tag! 'loc', map_url(map)
			xml.tag! 'priority', '0.8'
		end
	end

end