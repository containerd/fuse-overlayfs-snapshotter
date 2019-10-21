# [`fuse-overlayfs`](https://github.com/containers/fuse-overlayfs) snapshotter plugin for [containerd](https://containerd.io)

Unlike `overlayfs`, `fuse-overlayfs` can be used as a non-root user without patching the kernel.
(But currently containerd need to be patched.)

## Requirements
* kernel >= 4.18  (So this can't be tested in Travis CI, which uses kernel 4.15, as of October 2019)
* containerd with [PR #3765](https://github.com/containerd/containerd/pull/3765)
* fuse-overlayfs >= [20191020](https://github.com/containers/fuse-overlayfs/commit/c9bbc94ab65467481ea0e0810eea8fd1bfd8a4bf)

## How to test

To run the test as a non-root user, [RootlessKit](https://github.com/rootless-containers/rootlesskit) needs to be installed.

```console
$ go test -exec rootlesskit -test.v -test.root
```
