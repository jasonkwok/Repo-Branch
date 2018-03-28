def checkBranchOfFile(path)
  begin
    Dir.foreach(path) do |item|
      $item_path = path + "/" + item
      if item != '.' and item != '..'
        if File.directory?($item_path)
          $git_path = $item_path + "/" + ".git"
          if File.directory?($git_path)
            Dir.chdir($git_path) do
              puts item + " "
              system 'git branch'
              puts "Last modified: " + " " + File.mtime(".").to_s + "\n" + "\n"
            end
          else
            checkBranchOfFile($item_path)
          end
        end
      end
    end
  rescue
    puts 'I am rescued.'
  end
end

$no_arg = true
ARGV.each do|path|
  $no_arg = false
  checkBranchOfFile(path)
  break
end

if $no_arg
  checkBranchOfFile("..")
end
