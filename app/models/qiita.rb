module Qiita
  class Item
    attr_accessor :title, :username, :updated_at, :body, :url
    def initialize(data)
      @title      = data['title']
      @username   = data['user']['url_name']
      @updated_at = data['updated_dat_in_words']
      @body       = data['body']
      @url        = data['url']
    end
  end

  class Client
    BASE_URL = 'https://qiita.com/api/v1'
    def self.fetch_tagged_items(tag_name, &block)
      url = BASE_URL + "/tags/#{tag_name}/items"
      BW::HTTP.get(url) do |response|
        items = []
        message = nil
        if response.ok?
          json = BW::JSON.parse(response.body.to_s)
          items = json.map{|data| Qiita::Item.new(data)}
        end
        block.call(items, message)
      end
    end
  end

end
