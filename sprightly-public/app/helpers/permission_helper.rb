module PermissionHelper

  def format_time_or_event(str)
    if str.nil? || str.empty?
      return ""
    else
      return str
    end
  end

  def format_years(str)
    if str.nil?
      return ""
    else
      return str.to_i.to_s + " year(s)"
    end
  end

  def get_permission_purpose(permissionpurpose_lu)
    if permissionpurpose_lu.nil?
      return "&nbsp;"
    else
      permissionpurpose_lu.label
    end
  end

  def get_icon_for_permission_type(permissiontype_lu)
    case permissiontype_lu.code
    when PermissiontypeLu.access
      return image_tag("access.png", :alt=>permissiontype_lu.label, :title=>permissiontype_lu.label)
    when PermissiontypeLu.copying
      return image_tag("research_copies.png", :alt=>permissiontype_lu.label, :title=>permissiontype_lu.label)
    when PermissiontypeLu.publishing
      return image_tag("public.png", :alt=>permissiontype_lu.label, :title=>permissiontype_lu.label)
    when PermissiontypeLu.exhibition
      return image_tag("public.png", :alt=>permissiontype_lu.label, :title=>permissiontype_lu.label)
    else
      return image_tag("question.png", :alt=>"Unknown permission type", :title=>"Unknown permission type")
    end
  end

  def get_icon_for_permission_policy(permissionpolicy_lu)
    case permissionpolicy_lu.code
    when PermissionpolicyLu.permission_required
      return image_tag("permission.png", :alt=>permissionpolicy_lu.label, :title=>permissionpolicy_lu.label)
    when PermissionpolicyLu.closed
      return image_tag("stop.png", :alt=>permissionpolicy_lu.label, :title=>permissionpolicy_lu.label)
    when PermissionpolicyLu.open
      return image_tag("tick.png", :alt=>permissionpolicy_lu.label, :title=>permissionpolicy_lu.label)
    when PermissionpolicyLu.part_open_part_permission_required
      return image_tag("open_permission.png", :alt=>permissionpolicy_lu.label, :title=>permissionpolicy_lu.label)
    when PermissionpolicyLu.part_open_part_closed
      return image_tag("open_closed.png", :alt=>permissionpolicy_lu.label, :title=>permissionpolicy_lu.label)
    when PermissionpolicyLu.part_permission_required_part_closed
      return image_tag("permission_closed.png", :alt=>permissionpolicy_lu.label, :title=>permissionpolicy_lu.label)
    else
      return image_tag("question.png", :alt=>"Unknown permission policy", :title=>"Unknown permission policy")
    end
  end

end