//in case if we want https page
/proc/get_namefromtau(address)
	address = shelleo_url_scrub(address)

	if(!address)
		return

	return world.ext_python("namefromtau.py", "\"[address]\"") // escaping url for shell
