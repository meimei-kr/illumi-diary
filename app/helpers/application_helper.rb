module ApplicationHelper
  def page_title(title = '')
    base_title = 'illumi diary'
    title.blank? ? base_title : "#{title} | #{base_title}"
  end
end
