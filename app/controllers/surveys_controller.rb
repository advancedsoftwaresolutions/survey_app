class SurveysController < ApplicationController
  before_action :set_survey, only: %i[edit update destroy]

  # GET /surveys or /surveys.json
  def index
    @surveys = Survey.all

    Rails.logger.debug "Loaded #{@surveys.count} surveys:"
    Rails.logger.debug(@surveys.map { |s| "#{s.id}: #{s.question} (#{s.responses.count} responses)" })
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /surveys/1 or /surveys/1.json
  def show
    @survey = Survey.find(params[:id])

    yes_count = @survey.responses.where(answer: true).count
    no_count = @survey.responses.where(answer: false).count

    @chart_data = {
      'Yes' => yes_count,
      'No' => no_count
    }

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys or /surveys.json
  def create
    @survey = current_user.surveys.build(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1 or /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1 or /surveys/1.json
  def destroy
    @survey.destroy!

    respond_to do |format|
      format.html { redirect_to surveys_path, status: :see_other, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def card
    @survey = Survey.find(params[:id])
    render turbo_stream: turbo_stream.replace("survey-#{@survey.id}",
                                              partial: 'components/survey_card_component',
                                              locals: { survey: @survey, delay: 0 })
  end

  def cards
    @surveys = Survey.all

    turbo_streams = @surveys.map.with_index do |survey, i|
      turbo_stream.replace(
        "survey-#{survey.id}",
        html: ApplicationController.render(
          SurveyCardComponent.new(survey: survey, delay: i * 50), layout: false
        )
      )
    end

    render turbo_stream: turbo_streams
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_survey
    @survey = current_user.surveys.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def survey_params
    params.require(:survey).permit(:question, :user_id)
  end
end
