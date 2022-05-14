def clean_new_lines(lines)
  lines.delete("\n")
end

def parse_fds_lines(lines)
  line_regex = Regexp.new(/&.*?\//m)
  lines.scan(@line_regex)
end

def identify_namelist(line)
end

lines = File.read("test.fds")
.then(&method(:clean_new_lines))
.then(&method(:parse_fds_lines))



puts lines
