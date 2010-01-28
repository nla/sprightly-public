module RightsholdersHelper

  def format_date(date)
    year = date.to_s.slice(0..3)
    month = date.to_s.slice(4..5)
    day = date.to_s.slice(6..7)
    return day + "-" + month + "-" + year
  end

  def get_work_url(pi)

    source = 'dcm'
    if pi.starts_with?('nla.cat-vn')
      source = 'catalogue'
    end

    return url_for(:controller=>:works, :action=>:show, :id=>pi, 'source'=>source)
  end


  def count_html(count)
    if count == 0 then
      return "<span class='empty'>0</span>"
    end
    return '<span class="work-tray-count blue">'+count.to_s + '</span>'
  end
end