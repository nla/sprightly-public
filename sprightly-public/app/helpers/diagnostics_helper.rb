module DiagnosticsHelper

  def get_background_color(available)
    if available
      "background-color:green;"
    else
      "background-color:red;"
    end
  end
end
