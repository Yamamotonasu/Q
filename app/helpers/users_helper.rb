module UsersHelper
  def show_user_image(user)
    # unless %w[image/jpg image/jpeg image/gif image/png].include?(user&.image&.blob.content_type)
    #   flash[:alert] = "無効なファイルです。"
    #   redirect_to root_path
    # end
    if user.image.attached?
      begin
        image_tag user.image.variant(resize: "300x300"), class: "img-thumbnail img-r"
      rescue
        user.image.purge
        flash.now[:alert] = "無効なファイルです。"
      end
    else
      image_tag "no_image.png", class: "img-thumbnail"
    end
  end

  def graph_judge_user
    if (@my_answer_one + @my_answer_two + @my_answer_three + @my_answer_four) == 0
      "まだ回答がありません。"
    elsif @my_question.blank?
      pie_chart [[@my_target_question.num_one, @my_answer_one], [@my_target_question.num_two, @my_answer_two]], donut: true
    elsif @my_question.num_three.present?
      pie_chart [[@my_target_question.num_one, @my_answer_one], [@my_target_question.num_two, @my_answer_two], [@my_target_question.num_three, @my_answer_three]], donut: true
    else
      pie_chart [[@my_target_question.num_one, @my_answer_one], [@my_target_question.num_two, @my_answer_two], [@my_target_question.num_three, @my_answer_three], [@my_target_question.num_four, @my_answer_four]], donut: true
    end
  end

  def has_question?
    if Question.find_by(user_id: current_user.id, target: true)
      return true
    else
      return false
    end
  end
end