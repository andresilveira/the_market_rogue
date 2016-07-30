module ApplicationHelper
  def link_to_back options
    url = options.fetch(:url, :back)
    label = "← " + options.fetch(:label, 'back')
    link_to label, url 
  end
end
