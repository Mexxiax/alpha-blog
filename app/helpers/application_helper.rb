module ApplicationHelper

  def gravatar_for(user, options = { size: 80})
    email_address = user.email.downcase
    # create the md5 hash
    hash = Digest::MD5.hexdigest(email_address)
    
    size = options[:size]
    # compile URL which can be used in <img src="RIGHT_HERE"...
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

    image_tag(gravatar_url, alt: user.username, class: "rounded-circle z-depth-2 shadow mx-auto d-block")
  end

end
