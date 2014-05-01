module ApplicationHelper

  # Returns "MM:SS" from n
  def duration_to_human secs
    "#{secs/60}:#{'%02d'%(secs%60)}"
  end

  # Returns n from "MM:SS"
  def duration_from_human dur
    if dur =~ /^\d+$/
      dur.to_i
    elsif dur =~ /^(\d+):(\d+)$/
      $1.to_i*60 + $2.to_i
    else
      0
    end
  end

end
