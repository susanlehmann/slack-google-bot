require 'http'

module SlackGoogleBot
  module Commands
    class Google < SlackRubyBot::Commands::Base
      match(/^(?<bot>\w*)\s(?<expression>.*)$/) do |client, data, match|
        expression = match['expression'].strip
        results = JSON.parse HTTP.get('https://www.googleapis.com/customsearch/v1',
                                      params: {
                                        q: expression,
                                        key: ENV['AIzaSyCZwjFXSUSyNEjixD3-zr67-VcHsqLsCUg'],
                                        cx: ENV['004496796037465980484:brkjipulziw']
                                      })
        result = results['items'].first if results['items']
        if result
          message = result['title'] + "\n" + result['link']
        else
          message = "No search results for `#{expression}`"
        end
        client.say(text: message, channel: data.channel)
      end
    end
  end
end
