require 'test_helper'

class RulesTest < ActiveSupport::TestCase

  def test_r4
    valid_permission?(PermissionRules::Rule.r4, "r4", PermissiontypeLu.access, PermissionpolicyLu.open, PermissionRules::PermissionHolder.everyone, nil, "access allowed on the Library's premises or while on loan in other libraries")
  end

  def test_r5
    valid_permission?(PermissionRules::Rule.r5, "r5", PermissiontypeLu.access, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "access allowed except permission required for access to the following parts, until the following date or event")
  end

  def test_r6
    valid_permission?(PermissionRules::Rule.r6, "r6", PermissiontypeLu.access, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "access allowed to the following parts, permission required for the rest, until the following date or event")
  end

  def test_r7
    valid_permission?(PermissionRules::Rule.r7, "r7", PermissiontypeLu.access, PermissionpolicyLu.permission_required, PermissionRules::PermissionHolder.everyone, nil, "access restricted, requires permission")
  end

  def test_r8
    valid_permission?(PermissionRules::Rule.r8, "r8", PermissiontypeLu.access, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.everyone, nil, "access restricted, closed until the following date or event")
  end

  def test_r9
    valid_permission?(PermissionRules::Rule.r9, "r9", PermissiontypeLu.access, PermissionpolicyLu.permission_required, PermissionRules::PermissionHolder.everyone, nil, "access restricted, requires permission until the following date or event, after which access allowed without seeking permission")
  end

  def test_r10
    valid_permission?(PermissionRules::Rule.r10, "r10", PermissiontypeLu.exhibition, PermissionpolicyLu.open, PermissionRules::PermissionHolder.everyone, nil, "exhibition allowed at the Library and other institutions")
  end

  def test_r11
    valid_permission?(PermissionRules::Rule.r11, "r11", PermissiontypeLu.exhibition, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "exhibition allowed except permission required for exhibition of the following parts, until the following date or event")
  end

  def test_r12
    valid_permission?(PermissionRules::Rule.r12, "r12", PermissiontypeLu.exhibition, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "exhibition of the following parts allowed, permission required for the rest, until the following date or event")
  end

  def test_r13
    valid_permission?(PermissionRules::Rule.r13, "r13", PermissiontypeLu.exhibition, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.everyone, nil, "exhibition restricted, closed until the following date or event")
  end

  def test_r14
    valid_permission?(PermissionRules::Rule.r14, "r14", PermissiontypeLu.exhibition, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.everyone, nil, "exhibition restricted, refer all requests to rights holder")
  end

  def test_r15
    valid_permission?(PermissionRules::Rule.r15, "r15", PermissiontypeLu.copying, PermissionpolicyLu.open, PermissionRules::PermissionHolder.everyone, nil, "copying allowed for research, study or personal use")
  end

  def test_r16
    valid_permission?(PermissionRules::Rule.r16, "r16", PermissiontypeLu.copying, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "copying allowed except permission required for copying of the following parts, until the following date or event")
  end

  def test_r17
    valid_permission?(PermissionRules::Rule.r17, "r17", PermissiontypeLu.copying, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "copying of the following parts allowed, permission required for the rest, until the following date or event")
  end

  def test_r18
    valid_permission?(PermissionRules::Rule.r18, "r18", PermissiontypeLu.copying, PermissionpolicyLu.permission_required, PermissionRules::PermissionHolder.everyone, nil, "copying restricted, requires permission")
  end

  def test_r19
    valid_permission?(PermissionRules::Rule.r19, "r19", PermissiontypeLu.copying, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.everyone, nil, "copying restricted, closed until the following date or event")
  end
  
  def test_r21
    valid_permission?(PermissionRules::Rule.r21, "r21", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.online, "publishing digital copies on websites allowed")
  end

  def test_r22
    valid_permission?(PermissionRules::Rule.r22, "r22", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.online, "publishing digital copies on websites allowed, except permission required for the following parts until the following date or event")
  end

  def test_r23
    valid_permission?(PermissionRules::Rule.r23, "r23", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.online, "publishing digital copies of the following parts allowed, permission required for the rest, until the following date or event")
  end

  def test_r24
    valid_permission?(PermissionRules::Rule.r24, "r24", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.online, "publishing digital copies on websites restricted, closed until the following date or event")
  end

  def test_r25
    valid_permission?(PermissionRules::Rule.r25, "r25", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.online, "publishing digital copies on websites restricted, permission required until the following date or event")
  end

  def test_r26
    valid_permission?(PermissionRules::Rule.r26, "r26", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.online, "publishing digital copies on websites restricted, closed")
  end

  def test_r27
    valid_permission?(PermissionRules::Rule.r27, "r27", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publications_merchandise_publicity, "publishing and public use by the Library allowed")
  end

  def test_r28
    valid_permission?(PermissionRules::Rule.r28, "r28", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publications_merchandise_publicity, "publishing and public use by the Library allowed, except permission required for the following parts until the following date or event")
  end

  def test_r29
    valid_permission?(PermissionRules::Rule.r29, "r29", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publications_merchandise_publicity, "publishing and public use of the following parts allowed, permission required for the rest, until the following date or event")
  end

  def test_r30
    valid_permission?(PermissionRules::Rule.r30, "r30", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publications_merchandise_publicity, "publishing and public use by the Library restricted, requires permission until the following date or event")
  end

  def test_r31
    valid_permission?(PermissionRules::Rule.r31, "r31", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publications, "the Library may use in its own publications")
  end

  def test_r32
    valid_permission?(PermissionRules::Rule.r32, "r32", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publicity, "the Library may use for the purpose of publicising the Library")
  end

  def test_r33
    valid_permission?(PermissionRules::Rule.r33, "r33", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.merchandise, "the Library may use in merchandise issued by the Library")
  end

  def test_r34
    valid_permission?(PermissionRules::Rule.r34, "r34", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.specific_exhibition_publication, "the Library may use in the following exhibition, including catalogue or other related publications")
  end

  def test_r35
    valid_permission?(PermissionRules::Rule.r35, "r35", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.specific_exhibition_publication, "the Library may use in the following print publication")
  end

  def test_r36
    valid_permission?(PermissionRules::Rule.r36, "r36", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.specific_exhibition_publication, "the Library may provide access to digital copies in connection with the following exhibition, project or publication")
  end

  def test_r37
    valid_permission?(PermissionRules::Rule.r37, "r37", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.specific_exhibition_publication, "the Library may use the material as a credited detail, with or without the full image")
  end

  def test_r38
    valid_permission?(PermissionRules::Rule.r38, "r38", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.specific_exhibition_publication, "the Library may use the material in promotional or educational activities in any format or medium, in connection with the following exhibition, project or publication")
  end

  def test_r39
    valid_permission?(PermissionRules::Rule.r39, "r39", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.nla, nil, "publishing restricted, refer all requests to rights holder")
  end

  def test_r40
    valid_permission?(PermissionRules::Rule.r40, "r40", PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionRules::PermissionHolder.everyone, nil, "Library may provide copies for publishing and public use by other people and organisations")
  end

  def test_r41
    valid_permission?(PermissionRules::Rule.r41, "r41", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "Library may provide copies for publishing and public use by other people and organisations, except the following parts require permission until the following date or event")
  end

  def test_r42
    valid_permission?(PermissionRules::Rule.r42, "r42", PermissiontypeLu.publishing, PermissionpolicyLu.part_open_part_permission_required, PermissionRules::PermissionHolder.everyone, nil, "Library may provide copies of the following parts for publishing and public use by other people and organisations, permission required for the rest, until the following date or event")
  end

  def test_r43
    valid_permission?(PermissionRules::Rule.r43, "r43", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, PermissionRules::PermissionHolder.everyone, nil, "Library may only provide copies for publishing and public use by other people and organisations with my specific permission")
  end

  def test_r44
    valid_permission?(PermissionRules::Rule.r44, "r44", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.everyone, nil, "Library may not provide copies for publishing and public use by other people and organisations, closed until the following date or event")
  end

  def test_r45
    valid_permission?(PermissionRules::Rule.r45, "r45", PermissiontypeLu.publishing, PermissionpolicyLu.permission_required, PermissionRules::PermissionHolder.everyone, nil, "Library may only provide copies for publishing and public use by other people and organisations with my specific permission until the following date or event")
  end

  def test_r46
    valid_permission?(PermissionRules::Rule.r46, "r46", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.everyone, nil, "Library may not provide copies for publishing and public use by other people and organisations, refer all requests to rights holder")
  end

  def test_r49
    valid_permission?(PermissionRules::Rule.r49, "r49", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publications, "the Library may not use in its own publications")
  end

  def test_r50
    valid_permission?(PermissionRules::Rule.r50, "r50", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.publicity, "the Library may not use for the purpose of publicising the Library")
  end

  def test_r51
    valid_permission?(PermissionRules::Rule.r51, "r51", PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionRules::PermissionHolder.nla, PermissionpurposeLu.merchandise, "the Library may not use in merchandise issued by the Library")
  end

  private

    def valid_permission?(permission, rule, type_code, policy_code, holder, purpose_code, details)
      assert_equal(rule, permission.rule, "Permission Rules are not equal")
      assert_equal(PermissiontypeLu.find_by_code(type_code).permissiontype_lu_id, permission.permissiontype_lu_id, "Permission Types are not equal")
      assert_equal(PermissionpolicyLu.find_by_code(policy_code).permissionpolicy_lu_id, permission.permissionpolicy_lu_id, "Permission Policies are not equal")
      assert_equal(holder, permission.permissionholder, "Permission Holders are not equal")
      assert_equal(PermissionpurposeLu.find_by_code(purpose_code).permissionpurpose_lu_id, permission.permissionpurpose_lu_id, "Permission Purposes are not equal") if (!purpose_code.blank?)
      assert_equal(details, permission.details, "Details messages are not equal")
    end

end

