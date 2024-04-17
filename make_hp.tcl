proc parseTag {tag} {
    return [split $tag .]
}

set hash [exec  git log --pretty="%h" -1]
set tag [exec git tag --list --contains b8a5531]

puts [parseTag $tag]
