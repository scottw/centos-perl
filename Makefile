TAG = 5.24.1

build:
	docker build -t scottw/centos-perl:$(TAG) .

push:
	docker push scottw/centos-perl:$(TAG)
