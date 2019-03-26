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
      return
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

  # 年齢の配列を返すと[10台,20台,30台,40台,50台,60台,70台,80歳以上]の値の数で配列を返す
  def count_age(age)
    [age.select{ |x| x.to_i.between?(10,19) }.count,
     age.select{ |x| x.to_i.between?(20,29) }.count,
     age.select{ |x| x.to_i.between?(30,39) }.count,
     age.select{ |x| x.to_i.between?(40,49) }.count,
     age.select{ |x| x.to_i.between?(50,59) }.count,
     age.select{ |x| x.to_i.between?(60,69) }.count,
     age.select{ |x| x.to_i.between?(70,79) }.count,
     age.select{ |x| x.to_i >= 80 }.count]
  end

  # 年齢層の配列を渡すとチャートを返す
  def age_group_graph(age_group)
    pie_chart [["10台", age_group[0]], ["20台", age_group[1]], ["30台", age_group[2]], ["40台", age_group[3]], ["50台", age_group[4]], ["60台", age_group[5]], ["70台", age_group[6]], ["80歳以上", age_group[7]]]
  end

  # 回答者の性別の配列を渡すとチャートを返す
  def sex_group_graph(sex)
    man = sex.count("男")
    women = sex.count("女")
    [man, women]
    # pie_chart [["男性", man], ["女性", women]]
  end
end