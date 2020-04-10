class InvitesController < ApplicationController
  def new
    @form = BulkInvitesForm.new
  end

  def create
    @form = BulkInvitesForm.new(invites_params: invites_params)

    if @form.save
      flash[:success] = 'Invites have been sent successfully'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def invites_params
    params.require(:bulk_invites_form).permit(invites_attributes: [:email])
  end
end
