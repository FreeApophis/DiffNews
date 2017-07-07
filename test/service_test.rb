require 'minitest'
require 'diff_news'

class ServiceTest < Minitest::Test
  def test_create_providers
    providers = {
      'http://www.tagesanzeiger.ch/sport/tennis/aufschlag-smash-und-tschuess/story/10062709' => 'tagesanzeiger.ch',
      'https://www.nzz.ch/international/europa/abstimmung-im-eu-parlament-xxx-fuer-beitrittsverhandlungen-mit-der-tuerkei-ld.1304606' => 'nzz.ch',
      'http://www.20min.ch/digital/news/story/Wi-Fi-Luecke-gefaehrdet-Millionen-von-Handys-12672249' => '20min.ch',
    }

    providers.each do |url, provider|
      service = DiffNews::Service.create url
      assert_equal service.provider, provider
    end
  end
end
