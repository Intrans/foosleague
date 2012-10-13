module ApplicationHelper

  def display_score(score, options = {})
    content_tag :span, :class => :score do
      "#{content_tag :span, score / 10, :class => :first}#{content_tag :span, "#{score % 10}", :class => :last}".html_safe
    end
  end

end
