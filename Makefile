docker: Dockerfile
	git submodule update --init
	docker build -t hypothesis/sakai:12 -f $(PWD)/Dockerfile sakai
