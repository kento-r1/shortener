#require "json_spec/cucumber"
require 'rails_helper'


RSpec.describe ApiController, :type => :controller do

	describe 'GET /api/v1/shortenurl' do #, type: :request do
		
    	it "200がかえってくる。" do
			get :shorten , {:LongUrl=>"http://www.recruit.jp/"}
	        expect(response.status).to eq 200
		end
		#subject { response.body }

		#it{ should include_json("DBMci7xy").at_path("ShortUrl") }

		it 'リクルートのURLが正しく変換される' do
			get :shorten , {:LongUrl=>"http://www.recruit.jp/"}
			json = JSON.parse(response.body)
			expect(json['ShortUrl']).to include("DBMci7xy")
		end


	end

	describe 'まとめてテスト。' , type: :request do
		it 'URLを短くしておくと、そのURLにリダイレクトされるようになる。' do
			get '/api/v1/shortenurl' , {:LongUrl=>"http://www.recruit.jp/"}
			json = JSON.parse(response.body)
			base64 =  json['ShortUrl'].match(/\/[^\/]+$/)
			get base64[0]
			response.should redirect_to "http://www.recruit.jp/"
		end
	end
end
=begin
Scenario: Create new authorization
    Given an existing user and merchant
    And I post to "/api/v1/authorizations.json" with:
    """
    {"email":"user@email.com", "code": "43434", "merchant_account_id":1, "amount": 45.00}
    """
    And I keep the JSON response at "authorization/id" as "AUTH_ID"
    When I get from "/api/v1/authorizations/last.json"
    Then the JSON response at "authorization/id" should be %{AUTH_ID}

=end