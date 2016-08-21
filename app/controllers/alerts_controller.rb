class AlertsController < ApplicationController
  # GET /alerts
  # GET /alerts.json
  def index
    @alerts = Alert.all
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    Alert.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to alerts_url, notice: 'Alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
