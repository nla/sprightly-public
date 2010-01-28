#
# Manages requests for Contact Details
#
# @author: tingram
#
class ContactController < ApplicationController

  before_filter :login_required
  before_filter :update_access_required, :except => :show
  
  # Displays a list of all the ACTIVE and ARCHIVED contact details.
  def show
    @party = Party.get_party(params[:partyid])
    @rightsholder = Rightsholder.get_rightsholder_by_partyid(@party.partyid)
  end

  def new
    @partyid = params[:partyid]
    @contact = Contact.new
    @contactdetail = Hash.new

    if params[:type] then
      @contacttype_lu = ContacttypeLu.find(params[:type])
      @contact.contacttype_lu_id = @contacttype_lu.contacttype_lu_id
    else
      @contact.contacttype_lu_id = nil
      @contacttype_lu = nil
    end
    render :action => "new"
  end

  def new_compiled
    @partyid = params[:partyid]
    @contact = Contact.new

    @address1_data = Hash.new
    @address1_contact = Hash.new
    @address2_data = Hash.new
    @address2_contact = Hash.new
    @ah_phone_data = Hash.new
    @ah_phone_contact = Hash.new
    @bh_phone_data = Hash.new
    @bh_phone_contact = Hash.new
    @mobile_phone_data = Hash.new
    @mobile_phone_contact = Hash.new
    @fax_data = Hash.new
    @fax_contact = Hash.new
    @email_data = Hash.new
    @email_contact = Hash.new

    render :action => "new_compiled", :layout => false
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.status_lu_id = StatusLu.active
    @contact.audituser = session[:user].id
    @contact.auditdate = Date.today
    @contact.createdate = Date.today
    @contact.createuser = session[:user].id
    @contact.preferred = nil if @contact.preferred == '0' # Ensuring that if the checkbox is not submiited this field is null

    @contactdetail = params[:contactdetail]

    if @contact.save
       @contactdetail.each_key do |key|
        contactdetail = Contactdetail.new
        contactdetail.key = key
        contactdetail.value = @contactdetail[key]
        contactdetail.contactid = @contact.contactid
        contactdetail.save
       end
      @msg = 'Contact successfully created.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
       @partyid = params[:partyid]
       @msg = 'Unable to create contact.'
       @msg_class = "error-msg"
       render :action => "new"
    end
  end

  def create_compiled
    @partyid = params[:partyid]
    
    @address1_data = params[:address1_data]
    @address1_contact = params[:address1_contact]

    @address2_data = params[:address2_data]
    @address2_contact = params[:address2_contact]

    @bh_phone_data = params[:bh_phone_data]
    @bh_phone_contact = params[:bh_phone_contact]

    @ah_phone_data = params[:ah_phone_data]
    @ah_phone_contact = params[:ah_phone_contact]

    @mobile_phone_data = params[:mobile_phone_data]
    @mobile_phone_contact = params[:mobile_phone_contact]

    @fax_data = params[:fax_data]
    @fax_contact = params[:fax_contact]

    @email_data = params[:email_data]
    @email_contact = params[:email_contact]

    contacts_to_save = []

    if @address1_data.values.reject{ |v| v.blank? }.length>0 then
      contacts_to_save.push({:contact=>@address1_contact, :data=>@address1_data})
    end
    if @address2_data.values.reject{ |v| v.blank? }.length>0 then
      contacts_to_save.push({:contact=>@address2_contact, :data=>@address2_data})
    end
    if not @bh_phone_data["bh_phone"].blank? then
      contacts_to_save.push({:contact=>@bh_phone_contact, :data=>@bh_phone_data})
    end
    if not @ah_phone_data["ah_phone"].blank? then
     contacts_to_save.push({:contact=>@ah_phone_contact, :data=>@ah_phone_data})
    end
    if not @mobile_phone_data["mobile"].blank? then
      contacts_to_save.push({:contact=>@mobile_phone_contact, :data=>@mobile_phone_data})
    end
    if not @fax_data["fax"].blank? then
      contacts_to_save.push({:contact=>@fax_contact, :data=>@fax_data})
    end
    if not @email_data["email"].blank? then
      contacts_to_save.push({:contact=>@email_contact, :data=>@email_data})
    end
    
    error_saving_contacts = false

    # TRANSACTION GOES HERE

    Contact.transaction do
      begin
        contacts_to_save.each do |contact_hash|
          contact = Contact.new(contact_hash[:contact])
          contact.audituser = session[:user].id
          contact.auditdate = Date.today
          contact.createdate = Date.today
          contact.createuser = session[:user].id
          contact.status_lu_id = StatusLu.active
          contact.partyid = @partyid

          if contact.save then
            contact_hash[:data].each do |k,v|
              contactdetail = Contactdetail.new
              contactdetail.key = k
              contactdetail.value = v
              contactdetail.contactid = contact.contactid
              if not contactdetail.save then
                error_saving_contacts = true
                raise ActiveRecord::Rollback, "Error Saving Contact"
                break
              end
            end
          else
            error_saving_contacts = true
            raise ActiveRecord::Rollback, "Error Saving Contact"
            break
          end

        end
      rescue ActiveRecord::StatementInvalid
        error_saving_contacts = true
      end
    end

    if error_saving_contacts then
      @msg = 'Unable to create contact.'
      @msg_class = "error-msg"
      render :action => "new_compiled"
    else
      @msg = 'All contacts were successfully created.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    end
  end

  def edit
    @contact = Contact.find(params[:id])
    @contacttype_lu = @contact.contacttype_lu
    @contactdetail = Hash.new
    @contact.contactdetail.each { |detail| @contactdetail[detail.key] = detail.value }
    render :action => "edit.html"
  end

  # To create the history of contact detail changes, the old contact detail is archived and the
  # new details are created.
  def update
    @old_contact = Contact.find(params[:id])
    @old_contact.status_lu_id = StatusLu.archived
    @old_contact.auditdate = Date.today.to_s
    @old_contact.audituser = session[:user].id
    @old_contact.save

    @contact = Contact.new(params[:contact])
    @contact.status_lu_id = StatusLu.active
    @contact.audituser = session[:user].id
    @contact.auditdate = Date.today
    @contact.createdate = Date.today
    @contact.createuser = session[:user].id
    @contact.preferred = nil if @contact.preferred == '0' # Ensuring that if the checkbox is not submiited this field is null

    @contactdetail = params[:contactdetail]

    if @contact.save
       @contactdetail.each_key do |key|
        contactdetail = Contactdetail.new
        contactdetail.key = key
        contactdetail.value = @contactdetail[key]
        contactdetail.contactid = @contact.contactid
        contactdetail.save
       end
       @msg = 'Contact successfully updated.'
       @msgClass = "success-msg"
       @refreshPageOnSave = false
       @closeDialog = true
       render :partial => "common/refresh", :layout => nil
    else
       @msg = 'Unable to update contact.'
       @msg_class = "error-msg"
       render :action => "edit.html"
    end
  end

  def delete
    @contact = Contact.new
    @contact.contactid = params[:id]
    render :action => "delete.html"
  end

  # Soft delete
  def destroy
    @contact = Contact.find(params[:id])
    @contact.status_lu_id = StatusLu.archived
    @contact.auditdate = Date.today
    @contact.audituser = session[:user].id

    if @contact.save
      @msg = 'Contact successfully archived.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
     else
      @msg = 'Unable to archive contact.'
      @msgClass = "fail"
      render :action => "delete", :id => @contact.contactid
    end
  end

end