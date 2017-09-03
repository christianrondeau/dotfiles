function posix-source
	for i in (cat $argv)
		set arr (echo $i | string match -r "([^=]+)='?([^']+)")
		set -gx $arr[2] $arr[3]
	end
end
