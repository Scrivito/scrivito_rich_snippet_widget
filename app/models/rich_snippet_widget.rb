class RichSnippetWidget < Widget
  attribute :snippet, :reference

  def type
    self.snippet.type
  end

  def module
    self.snippet.module
  end

  def warnings
    return ['No snippet selected'] if snippet.blank?
    snippet.warnings
  end

  def to_json
    snippet.to_json(true).to_json
  end
end
