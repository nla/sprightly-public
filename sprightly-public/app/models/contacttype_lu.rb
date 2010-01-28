class ContacttypeLu < ActiveRecord::Base
  set_primary_key "contacttype_lu_id"
  has_many :contact, :foreign_key  => 'contacttype_lu_id'

  def self.find_by_code(code)
    ContacttypeLu.find(:first, :conditions => {:code => code} )
  end

  def self.options
    @all = ContacttypeLu.find(:all);
    @options = []
    for contacttype_lu in @all
      @options.push([contacttype_lu.label,contacttype_lu.contacttype_lu_id])
    end
    @options
  end

  
  def self.postal
    ContacttypeLu.find_by_code("postal").contacttype_lu_id
  end

  def self.ah_phone
    ContacttypeLu.find_by_code("ah_phone").contacttype_lu_id
  end

  def self.bh_phone
    ContacttypeLu.find_by_code("bh_phone").contacttype_lu_id
  end

  def self.mobile
    ContacttypeLu.find_by_code("mobile").contacttype_lu_id
  end

  def self.fax
    ContacttypeLu.find_by_code("fax").contacttype_lu_id
  end

  def self.email
    ContacttypeLu.find_by_code("email").contacttype_lu_id
  end

end