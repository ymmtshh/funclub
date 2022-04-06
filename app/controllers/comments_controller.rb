class CommentsController < ApplicationController

    def create
      schedule = Schedule.find(params[:schedule_id])
      comment = current_user.comments.new(comment_params)
      comment.schedule_id = schedule.id
      comment.save
      redirect_to schedule_path(schedule)
    end
  
    def destroy
      Comment.find_by(id: params[:id], schedule_id: params[:schedule_id]).destroy
      redirect_to schedule_path(params[:schedule_id])
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:comment_content)
    end

end
