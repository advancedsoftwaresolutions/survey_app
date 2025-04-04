class ResponsesController < ApplicationController
  require 'csv'
  # GET /responses or /responses.json
  def index
    @survey = Survey.find(params[:survey_id])
    @responses = @survey.responses.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@responses), filename: "survey-#{@survey.id}-responses.csv" }
    end
  end

  # GET /responses/1 or /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    @survey = Survey.find(params[:survey_id])

    @response = Response.new(
      answer: response_params[:answer],
      survey_id: params[:survey_id],
      ip_address: request.remote_ip
    )

    respond_to do |format|
      if @response.save
        format.html { redirect_to @survey, notice: 'Thanks for voting!' }
        format.json { render :show, status: :created, location: @response }
      else

        format.html { redirect_to @survey, alert: "Your response couldn't be saved." }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy!

    respond_to do |format|
      format.html { redirect_to responses_path, status: :see_other, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def generate_csv(responses)
    CSV.generate(headers: true) do |csv|
      csv << ['Answer', 'Submitted At', 'IP Address']
      responses.each do |response|
        csv << [
          response.answer == 'yes' ? 'Yes' : 'No',
          response.created_at.strftime('%Y-%m-%d %H:%M:%S'),
          response.ip_address
        ]
      end
    end
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.require(:response).permit(:answer)
  end
end
