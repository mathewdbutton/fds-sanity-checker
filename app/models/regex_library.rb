class RegexLibrary
  REAL_NUMBER = /(?<value>-?\d*?\.\d*)/
  WORD = /'(?<value>.*?)'/
  LOGICAL = /.(?<value>TRUE|FALSE)./
  REAL_TRIPLET = /(?<value>.*?,.*?,.*?),/
  REAL_ARRAY = /(?<value>-?\d+?\.\d*,-?\d+?\.\d*,-?\d+?\.\d*)/

  def self.cast_logical(string)
    case string
    when "TRUE"
      true
    when "FALSE"
      false
    end
  end
end
