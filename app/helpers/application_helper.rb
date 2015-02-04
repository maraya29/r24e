module ApplicationHelper
  def date_format(date)
    return 'N/A' unless date.present?
    date.strftime("%m/%d/%Y %I:%M %p")
  end
end
