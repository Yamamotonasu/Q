module QuestionsHelper

  def graph_judge
    if (@my_answer_one + @my_answer_two + @my_answer_three + @my_answer_four) == 0
      "まだ回答がありません。"
    elsif @my_question.blank?
      pie_chart [[@my_question.num_one, @my_answer_one], [@my_question.num_two, @my_answer_two]], donut: true
    elsif @my_question.num_three.present?
      pie_chart [[@my_question.num_one, @my_answer_one], [@my_question.num_two, @my_answer_two], [@my_question.num_three, @my_answer_three]], donut: true
    else
      pie_chart [[@my_question.num_one, @my_answer_one], [@my_question.num_two, @my_answer_two], [@my_question.num_three, @my_answer_three], [@my_question.num_four, @my_answer_four]], donut: true
    end
  end

  def column_judge
    if (@my_answer_one + @my_answer_two + @my_answer_three + @my_answer_four) == 0
      "まだ回答がありません。"
    elsif @my_question.blank?
      bar_chart [[@my_question.num_one, @my_answer_one], [@my_question.num_two, @my_answer_two]]
    elsif @my_question.num_three.present?
      bar_chart [[@my_question.num_one, @my_answer_one], [@my_question.num_two, @my_answer_two], [@my_question.num_three, @my_answer_three]]
    else
      bar_chart [[@my_question.num_one, @my_answer_one], [@my_question.num_two, @my_answer_two], [@my_question.num_three, @my_answer_three], [@my_question.num_four, @my_answer_four]]
    end
  end

  def total_count
    @my_answer_one + @my_answer_two + @my_answer_three + @my_answer_four
  end
end