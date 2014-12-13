class ApplicationController < ActionController::Base
	  # Prevent CSRF attacks by raising an exception.
	  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	def redirect_to(options = {}, response_status = {})
	  raise ActionControllerError.new("Cannot redirect to nil!") unless options
	  raise AbstractController::DoubleRenderError if response_body

	  self.status        = _extract_redirect_to_status(options, response_status)
	  #self.status        = "308 Permanent Redirect"

	  self.location      = _compute_redirect_to_location(options)
	  self.response_body = <<TEXT
<HTML>
<HEAD>
<TITLE>Permanent Redirect</TITLE>
</HEAD>
<BODY>
<H1>Permanent Redirect</H1>
You are going to redirect <A HREF=\"#{ERB::Util.h(location)}\">here</A>.
</BODY>
</HTML>
TEXT

	end
end
