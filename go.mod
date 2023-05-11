module github.com/containerd/fuse-overlayfs-snapshotter

go 1.19

// The test suite from containerd v1.7.x is not compatible with fuse-overlayfs:
// https://github.com/containerd/fuse-overlayfs-snapshotter/pull/53#issuecomment-1543442048
// Expected to be fixed in v1.7.2 (https://github.com/containerd/containerd/pull/8507)

require (
	github.com/containerd/containerd v1.6.21
	github.com/containerd/continuity v0.3.0
	github.com/coreos/go-systemd/v22 v22.5.0
	github.com/sirupsen/logrus v1.9.0
	google.golang.org/grpc v1.55.0
)

require (
	github.com/Microsoft/go-winio v0.6.1 // indirect
	github.com/Microsoft/hcsshim v0.9.9 // indirect
	github.com/containerd/cgroups v1.1.0 // indirect
	github.com/containerd/ttrpc v1.2.2 // indirect
	github.com/containerd/typeurl v1.0.2 // indirect
	github.com/docker/go-events v0.0.0-20190806004212-e31b211e4f1c // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/google/go-cmp v0.5.9 // indirect
	github.com/moby/sys/mountinfo v0.6.2 // indirect
	github.com/opencontainers/go-digest v1.0.0 // indirect
	github.com/opencontainers/image-spec v1.1.0-rc3 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	go.etcd.io/bbolt v1.3.7 // indirect
	go.opencensus.io v0.24.0 // indirect
	golang.org/x/mod v0.10.0 // indirect
	golang.org/x/net v0.10.0 // indirect
	golang.org/x/sync v0.2.0 // indirect
	golang.org/x/sys v0.8.0 // indirect
	golang.org/x/text v0.9.0 // indirect
	golang.org/x/tools v0.9.1 // indirect
	google.golang.org/genproto v0.0.0-20230410155749-daa745c078e1 // indirect
	google.golang.org/protobuf v1.30.0 // indirect
	gotest.tools/v3 v3.4.0 // indirect
)
