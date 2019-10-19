test:
	DOCKER_BUILDKIT=1 docker build -t containerd-fuse-overlayfs-test .
	docker run --rm --security-opt seccomp=unconfined --security-opt apparmor=unconfined --device /dev/fuse containerd-fuse-overlayfs-test
	docker rmi containerd-fuse-overlayfs-test

_test:
	go test -exec rootlesskit -test.v -test.root

.PHONY: test _test
