module TakeLogsHelper


  def status_label status
    status_span_generator status
  end

  def status_span_generator status
    case status
    when '未提醒'
      content_tag(:span , status.titleize, class: 'label label-primary')
    when '已提醒'
      content_tag(:span , status.titleize, class: 'label label-success')
    end
    
  end
end