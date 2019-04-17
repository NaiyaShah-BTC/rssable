module RSSable
  module Parsers
    module Items
      class Medium < RSSable::Parsers::Items::Base

        # Returns the article author
        #
        # @return [String]
        def author
          creator_node = node.elements.find { |c| c.name == "creator" }
          node_text(creator_node)
        end

        # Returns the article description
        #
        # @return [String]
        def description
          # node_text(node.at_xpath("//content:encoded"))
          content = Nokogiri::HTML node.search("description").first.content
          content.css("p.medium-feed-snippet").first.try(:content)
        end

        def image
          content = Nokogiri::HTML node.search("description").first.content
          content.css("img").attribute("src").try(:value)
        end
      end
    end
  end
end
