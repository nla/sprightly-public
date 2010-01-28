# This represents a collection of Permission Rule mappings contained
# in the spreadsheet for data mapping: http://ourweb.nla.gov.au/apps/wiki/display/RMP/Data+Mapping
#
# Each rule method has been prefixed with an "r". Once a method is called
# relevant populate PERMISSION model object is returned.
#
# @author tingram

module PermissionRules

  # Lists the kinds of Permission Holders
  class PermissionHolder

    def self.everyone
      "Everyone"
    end

    def self.nla
      "NLA"
    end

  end

  # Rules for permissions
  class Rule

    # Access (everyone)
    # Yes
    def self.r4
      details = "access allowed on the Library's premises or while on loan in other libraries"
      get_permission("r4", PermissiontypeLu.access, PermissionpolicyLu.open, nil, PermissionHolder.everyone, details)
    end

    # Access (everyone)
    # parts_require_permission_until_date_or_event
    def self.r5
      details = "access allowed except permission required for access to the following parts, until the following date or event"
      get_permission("r5", PermissiontypeLu.access, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Access (everyone)
    # Yes for parts, the rest requires permission until date or event
    def self.r6
      details = "access allowed to the following parts, permission required for the rest, until the following date or event"
      get_permission("r6", PermissiontypeLu.access, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Access (everyone)
    # only_with_permission
    def self.r7
      details = "access restricted, requires permission"
      get_permission("r7", PermissiontypeLu.access, PermissionpolicyLu.permission_required, nil, PermissionHolder.everyone, details)
    end

    # Access (everyone)
    # only_after_date_or_event
    def self.r8
      details = "access restricted, closed until the following date or event"
      get_permission("r8", PermissiontypeLu.access, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, details)
    end

    # Access (everyone)
    # only_with_permission_until_date_or_event
    def self.r9
      details = "access restricted, requires permission until the following date or event, after which access allowed without seeking permission"
      get_permission("r9", PermissiontypeLu.access, PermissionpolicyLu.permission_required, nil, PermissionHolder.everyone, details)
    end

    # Exhibitions here and away (NLA use, everyone access)
    # yes
    def self.r10
      details = "exhibition allowed at the Library and other institutions"
      get_permission("r10", PermissiontypeLu.exhibition, PermissionpolicyLu.open, nil, PermissionHolder.everyone, details)
    end

    # Exhibitions here and away (NLA use, everyone access)
    # parts require permission until date or event
    def self.r11
      details = "exhibition allowed except permission required for exhibition of the following parts, until the following date or event"
      get_permission("r11", PermissiontypeLu.exhibition, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Exhibitions here and away (NLA use, everyone access)
    # yes for parts, the rest requires permission until date or event
    def self.r12
      details = "exhibition of the following parts allowed, permission required for the rest, until the following date or event"
      get_permission("r12", PermissiontypeLu.exhibition, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Exhibitions here and away (NLA use, everyone access)
    # only after date or event
    def self.r13
      details = "exhibition restricted, closed until the following date or event"
      get_permission("r13", PermissiontypeLu.exhibition, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, details)
    end


    # Exhibitions here and away (NLA use, everyone access)
    # no_refer_all_requests_to_me
    def self.r14
      details = "exhibition restricted, refer all requests to rights holder"
      get_permission("r14", PermissiontypeLu.exhibition, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, details)
    end

    # Copy for research, study, personal (everyone)
    # yes
    def self.r15
      details = "copying allowed for research, study or personal use"
      get_permission("r15", PermissiontypeLu.copying, PermissionpolicyLu.open, nil, PermissionHolder.everyone, details)
    end

    # Copy for research, study, personal (everyone)
    # parts_require_permission_until_date_or_event
    def self.r16
      details = "copying allowed except permission required for copying of the following parts, until the following date or event"
      get_permission("r16", PermissiontypeLu.copying, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Copy for research, study, personal (everyone)
    # yes for parts, the rest requires permission until date or event
    def self.r17
      details = "copying of the following parts allowed, permission required for the rest, until the following date or event"
      get_permission("r17", PermissiontypeLu.copying, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Copy for research, study, personal (everyone)
    # only_with_permission
    def self.r18
      details = "copying restricted, requires permission"
      get_permission("r18", PermissiontypeLu.copying, PermissionpolicyLu.permission_required, nil, PermissionHolder.everyone, details)
    end

    # Copy for research, study, personal (everyone)
    # only_after_date_or_event
    def self.r19
      details = "copying restricted, closed until the following date or event"
      get_permission("r19", PermissiontypeLu.copying, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, details)
    end

    # r20 - NOT USED

    
    # Publishing digital copies on web (NLA)
    # yes
    def self.r21
      details = "publishing digital copies on websites allowed"
      get_permission("r21", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.online, PermissionHolder.nla, details)
    end

    # Publishing digital copies on web (NLA)
    # parts_require_permission_until_date_or_event
    def self.r22
      details = "publishing digital copies on websites allowed, except permission required for the following parts until the following date or event"
      get_permission("r22", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionpurposeLu.online, PermissionHolder.nla, details)
    end

    # Publishing digital copies on web (NLA)
    # yes for parts, the rest requires permission until date or event
    def self.r23
      details = "publishing digital copies of the following parts allowed, permission required for the rest, until the following date or event"
      get_permission("r23", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionpurposeLu.online, PermissionHolder.nla, details)
    end

    # Publishing digital copies on web (NLA)
    # only_after_date_or_event
    def self.r24
      details = "publishing digital copies on websites restricted, closed until the following date or event"
      get_permission("r24", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.online, PermissionHolder.nla, details)
    end

    # Publishing digital copies on web (NLA)
    # only_with_permission_until_date_or_event
    def self.r25
      details = "publishing digital copies on websites restricted, permission required until the following date or event"
      get_permission("r25", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, PermissionpurposeLu.online, PermissionHolder.nla, details)
    end

    # Publishing digital copies on web (NLA)
    # no
    def self.r26
      details = "publishing digital copies on websites restricted, closed"
      get_permission("r26", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.online, PermissionHolder.nla, details)
    end


    # Other publishing and use (NLA)
    # yes
    def self.r27
      details = "publishing and public use by the Library allowed"
      get_permission("r27", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.publications_merchandise_publicity, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # parts_require_permission_until_date_or_event
    def self.r28
      details = "publishing and public use by the Library allowed, except permission required for the following parts until the following date or event"
      get_permission("r28", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionpurposeLu.publications_merchandise_publicity, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes for parts, the rest requires permission until date or event
    def self.r29
      details = "publishing and public use of the following parts allowed, permission required for the rest, until the following date or event"
      get_permission("r29", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionpurposeLu.publications_merchandise_publicity, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # ony with permission until date or event
    def self.r30
      details = "publishing and public use by the Library restricted, requires permission until the following date or event"
      get_permission("r30", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, PermissionpurposeLu.publications_merchandise_publicity, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_librarys_own_publications
    def self.r31
      details = "the Library may use in its own publications"
      get_permission("r31", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.publications, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_other_publications
    def self.r32
      details = "the Library may use for the purpose of publicising the Library"
      get_permission("r32", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.publicity, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_merchandise
    def self.r33
      details = "the Library may use in merchandise issued by the Library"
      get_permission("r33", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.merchandise, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_specific_exhibition_including_catalogue
    def self.r34
      details = "the Library may use in the following exhibition, including catalogue or other related publications"
      get_permission("r34", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.specific_exhibition_publication, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_specific_print_publication
    def self.r35
      details = "the Library may use in the following print publication"
      get_permission("r35", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.specific_exhibition_publication, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_digital_copies_for_specific_publication_or_exhibition_or_project
    def self.r36
      details = "the Library may provide access to digital copies in connection with the following exhibition, project or publication"
      get_permission("r36", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.specific_exhibition_publication, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_use_as_credited_detail
    def self.r37
      details = "the Library may use the material as a credited detail, with or without the full image"
      get_permission("r37", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.specific_exhibition_publication, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # yes_only_for_use_in_promotional_or_educational_activity
    def self.r38
      details = "the Library may use the material in promotional or educational activities in any format or medium, in connection with the following exhibition, project or publication"
      get_permission("r38", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.specific_exhibition_publication, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # no_refer_all_requests_to_me
    def self.r39
      details = "publishing restricted, refer all requests to rights holder"
      get_permission("r39", PermissiontypeLu.publishing, PermissionpolicyLu.closed, nil, PermissionHolder.nla, details)
    end

    # Other publishing and use (everyone)
    # yes
    def self.r40
      details = "Library may provide copies for publishing and public use by other people and organisations"
      get_permission("r40", PermissiontypeLu.publishing, PermissionpolicyLu.open, nil, PermissionHolder.everyone, details)
    end

    # Other publishing and use (everyone)
    # parts_require_permission_until_date_or_event
    def self.r41
      details = "Library may provide copies for publishing and public use by other people and organisations, except the following parts require permission until the following date or event"
      get_permission("r41", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Other publishing and use (everyone)
    # yes for parts the rest requires permission until date or event
    def self.r42
      details = "Library may provide copies of the following parts for publishing and public use by other people and organisations, permission required for the rest, until the following date or event"
      get_permission("r42", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, nil, PermissionHolder.everyone, details)
    end

    # Other publishing and use (everyone)
    # only_with_permission
    def self.r43
      details = "Library may only provide copies for publishing and public use by other people and organisations with my specific permission"
      get_permission("r43", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, nil, PermissionHolder.everyone, details)
    end

    # Other publishing and use (everyone)
    # only_after_date_or_event
    def self.r44
      details = "Library may not provide copies for publishing and public use by other people and organisations, closed until the following date or event"
      get_permission("r44", PermissiontypeLu.publishing, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, details)
    end

    # Other publishing and use (everyone)
    # only_with_permission_until_date_or_event
    def self.r45
      details = "Library may only provide copies for publishing and public use by other people and organisations with my specific permission until the following date or event"
      get_permission("r45", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, nil, PermissionHolder.everyone, details)
    end

    # Other publishing and use (everyone)
    # no_refer_all_requests_to_me
    def self.r46
      details = "Library may not provide copies for publishing and public use by other people and organisations, refer all requests to rights holder"
      get_permission("r46", PermissiontypeLu.publishing, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, details)
    end
    
    # Researchers who have access may also copy
    # Yes
    def self.r47
      "When access is granted for a particular researcher, copying for research and study is also allowed."
    end

    # Researchers who have access may also copy
    # No
    def self.r48
      "Separate permission is required for researchers to copy material as well as access the material."
    end

    # Other publishing and use (NLA)
    # no_closed_for_other_publications
    def self.r49
      details = "the Library may not use in its own publications"
      get_permission("r49", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.publications, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # no_closed_for_other_publications
    def self.r50
      details = "the Library may not use for the purpose of publicising the Library"
      get_permission("r50", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.publicity, PermissionHolder.nla, details)
    end

    # Other publishing and use (NLA)
    # no_closed_for_merchandise
    def self.r51
      details = "the Library may not use in merchandise issued by the Library"
      get_permission("r51", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.merchandise, PermissionHolder.nla, details)
    end

    protected

    def self.get_permission(rule, permissiontype, permissionpolicy, permissionpurpose, permissionholder, details)
      permission = Permission.new
      permission.rule = rule
      permission.permissiontype_lu_id = PermissiontypeLu.find_by_code(permissiontype).permissiontype_lu_id
      permission.permissionpolicy_lu_id = PermissionpolicyLu.find_by_code(permissionpolicy).permissionpolicy_lu_id
      permission.permissionpurpose_lu_id = PermissionpurposeLu.find_by_code(permissionpurpose).permissionpurpose_lu_id if !permissionpurpose.nil?
      permission.permissionholder = permissionholder
      permission.details = details
      return permission
    end

  end
end
