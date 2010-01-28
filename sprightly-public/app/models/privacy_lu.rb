class PrivacyLu < ActiveRecord::Base
  set_primary_key "privacy_lu_id"
  has_many :contact, :foreign_key  => 'privacy_lu_id'

  def self.find_by_code(code)
    PrivacyLu.find(:first, :conditions => {:code => code} )
  end

  def self.options
    @all = PrivacyLu.find(:all, :order => "label asc");
    @options = []
    for privacy_lu in @all
      @options.push([privacy_lu.label,privacy_lu.privacy_lu_id])
    end
    @options
  end

end