# frozen_string_literal: true

class ValidationTitleComponent < ViewComponent::Base
  def initialize(validation_run:)
    @validation_run = validation_run
    @head = validation_run.head || Head.new(title: "", chid: "")
  end

  def title
    return "" if chid.blank?

    " for \"#{chid}\""
  end

  def tooltip
    return "Include the &HEAD input parameter with a CHID value to display a title here" if chid.blank?

    "Derived from CHID"
  end

  def chid
    @chid ||= @head.chid.strip
  end

end
