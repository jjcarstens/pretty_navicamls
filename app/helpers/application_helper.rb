module ApplicationHelper
  include ::ActionView::Helpers::NumberHelper

  def flash_type_to_div_class(flash_type)
    case flash_type
    when "error"
      "bg-danger"
    when "notice"
      "bg-success"
    else
      "bg-warning"
    end
  end

  def price_change_color(price_change)
    price_change.negative? ? "decreasedPrice" : "incresedPrice"
  end
end
