require 'minitest/autorun'
require 'sonarqube-client.rb'

class TestSonarQube < Minitest::Test
  def test_initialize
    test_connector = RestClient::Resource.new("http://localhost:9000", "username", "password")
    sonarqube_connector = SonarQube::SonarQube.new("http://localhost:9000", "username", "password")
    assert_equal test_connector.url, sonarqube_connector.instance_variable_get('@connector'.to_sym).url
    assert_equal test_connector.options, sonarqube_connector.instance_variable_get('@connector'.to_sym).options
  end
end
