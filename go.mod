module github.com/AkihiroSuda/containerd-fuse-overlayfs

go 1.13

require (
	github.com/Microsoft/go-winio v0.4.14 // indirect
	github.com/Microsoft/hcsshim v0.8.6 // indirect
	github.com/containerd/containerd v0.0.0-00010101000000-000000000000
	github.com/containerd/continuity v0.0.0-20190827140505-75bee3e2ccb6
	github.com/containerd/ttrpc v0.0.0-20191018135249-012175fdb774 // indirect
	github.com/containerd/typeurl v0.0.0-20190911142611-5eb25027c9fd // indirect
	github.com/docker/go-events v0.0.0-20190806004212-e31b211e4f1c // indirect
	github.com/gogo/protobuf v1.3.1 // indirect
	github.com/google/go-cmp v0.3.1 // indirect
	github.com/opencontainers/go-digest v1.0.0-rc1 // indirect
	github.com/opencontainers/image-spec v1.0.1 // indirect
	github.com/opencontainers/runc v0.1.1 // indirect
	github.com/pkg/errors v0.8.1
	go.etcd.io/bbolt v1.3.3 // indirect
	golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e // indirect
	golang.org/x/sys v0.0.0-20191018095205-727590c5006e // indirect
	google.golang.org/grpc v1.24.0 // indirect
	gotest.tools v2.2.0+incompatible // indirect
)

// https://github.com/containerd/containerd/pull/3765
replace github.com/containerd/containerd => github.com/AkihiroSuda/containerd v1.1.1-0.20191212062816-cbf52e6f9154
