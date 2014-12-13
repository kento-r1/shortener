class ApiController < ApplicationController
  def shorten
    url_base = "http://ec2-54-64-157-60.ap-northeast-1.compute.amazonaws.com/"

    base64 = Base64.strict_encode64(Digest::SHA1.digest(params['LongUrl']))
    base64 = base64.gsub(/\//,".").gsub(/\+/,"_")[0..7]
    
    url = Url.new(:base64 => base64, :location => params['LongUrl'])
    url.save


    render json: { 'ShortUrl'=> url_base + base64 ,'Created'=> url.created_at.to_i, 'LongUrl'=> params['LongUrl']}
  end

  def do_redirect
    url = Url.find_by('base64' => params['base64'])
    
    if url.nil?
        render :status => 404, :text => <<TEXT
<h1>404 Not Found</h1> The page #{request.url} does not exist.
TEXT
    else
      redirect_to url.location, status: :permanent_redirect
    end

  end
end

