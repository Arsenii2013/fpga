proc make {fname} {
	package require crc32
	package require tar

	proc parseTag {tag} {
	    return [split $tag .]
	}

	proc writeArg {fp name value} {
	    puts $fp "$name = $value"
	}
	puts $fname

	set hash [exec git log --pretty=%h -1]
	set tag [exec git tag --list --contains $hash]
	set maj [lindex [parseTag $tag] 0]
	set min [lindex [parseTag $tag] 1]
	set crc32 [::crc::crc32 -file $fname]
	set date [clock format [clock seconds] -format %Y%m%dT%H%M%S]

#	cd output_files

	set manifest [open manifest.txt w]
	writeArg $manifest version $tag; 
	writeArg $manifest git_commit $hash; 
	writeArg $manifest crc32 $crc32; 
	writeArg $manifest date $date;
	close $manifest 

	::tar::create "fw_llrf_hp_afe_${maj}_${min}_${hash}.tar" manifest.txt
	::tar::add "fw_llrf_hp_afe_${maj}_${min}_${hash}.tar" $fname
}
make [lindex $argv 0]
