module ApplicationHelper
  def header(name)
    content_for :h2 do
      name
    end
  end
end
