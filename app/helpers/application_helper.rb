module ApplicationHelper

  def gravatar_for(chef, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(chef.email.downcase)
    size = options[:size]
    # see http://en.gravatar.com/site/implement/images/ for details
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?size=#{size}"
    image_tag(gravatar_url, alt: chef.chefname, class: "gravatar")
  end
end
