Pry.config.editor = proc { |file, line| "vi +#{line} #{file}" }
