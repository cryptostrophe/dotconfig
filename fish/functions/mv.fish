function mv --wraps mv
  if macos? # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    /bin/mv -iv $argv
  else
    command mv -iv $argv
  end
end
