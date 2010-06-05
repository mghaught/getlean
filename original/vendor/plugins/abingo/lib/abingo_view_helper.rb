#Gives you easy syntax to use ABingo in your views.

module AbingoViewHelper

  def ab_test(test_name, alternatives = nil, options = {}, &block)

    if (Abingo.options[:enable_specification] && !params[test_name].nil?)
      choice = params[test_name]
    elsif (Abingo.options[:enable_override_in_session] && !session[test_name].nil?)
      choice = session[test_name]
    elsif (alternatives.nil?)
      choice = Abingo.flip(test_name)
    else
      choice = Abingo.test(test_name, alternatives, options)
    end

    if block
      content_tag = capture(choice, &block)
      block_called_from_erb?(block) ? concat(content_tag) : content_tag
    else
      choice
    end
  end

  def bingo!(test_name, options = {})
    Abingo.bingo!(test_name, options)
  end
  
end