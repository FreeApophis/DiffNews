# encoding: UTF-8

require 'diff_match_patch'

class DiffNewsDiff
  def initialize news
    @before = news.length == 2 ? news.first : NewsObject.new
    @after = news.last
  end

  def header
    h = <<EOT
<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <title>#{@after.title}</title>
  <meta name="description" content="Diff">
  <meta name="author" content="news_diff">
  <link rel="stylesheet" href="../style.css">
</head>
<body>
<pre class="diff">
EOT
  end

  def footer
    f = <<EOT
</pre>
</body>
</html>
EOT
  end

  def diff
    dmp = DiffMatchPatch.new
    diffs = dmp.diff_main(@before.text, @after.text)
    dmp.diff_cleanupEfficiency(diffs)
    dmp.diff_cleanupSemantic(diffs)
    return dmp.diff_prettyHtml(diffs)
  end

  def save file_path
    File.open(file_path, 'w:UTF-8') do |f|
      f.write(header)
      f.write(diff)
      f.write(footer)
    end
  end

end
