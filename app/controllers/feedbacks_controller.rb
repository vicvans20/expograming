class FeedbacksController < ApplicationController
	def new
		@feedback = Feedback.new
	end
	def create
		@feedback= Feedback.new(secure_params)
		if @feedback.valid?
			@feedback.store_feedback
			flash[:notice] = "Envíado correctamente! #{@feedback.name}."
			redirect_to feedbacks_new_path
		else
			flash[:alert] = "Error, porfavor verifique los campos."
			render :new
		end
	end

	def secure_params
		params.required(:feedback).permit(:name,:email,:content)
	end

end