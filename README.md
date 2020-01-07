# [`fuse-overlayfs`](https://github.com/containers/fuse-overlayfs) snapshotter plugin for [containerd](https://containerd.io)

Unlike `overlayfs`, `fuse-overlayfs` can be used as a non-root user without patching the kernel.

## Requirements
* kernel >= 4.18
* containerd >= [20200107](https://github.com/containerd/containerd/commit/b9fad5e310fafb453def5f1e7094f4c36a9806d2) (v1.4 pre-alpha)
* fuse-overlayfs >= v0.7.0

## How to test

To run the test as a non-root user, [RootlessKit](https://github.com/rootless-containers/rootlesskit) needs to be installed.

```console
$ go test -exec rootlesskit -test.v -test.root
```
