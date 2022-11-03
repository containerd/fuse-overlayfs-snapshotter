#   Copyright The containerd Authors.

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# Deliverables path
DESTDIR ?= /usr/local
BINDIR ?= $(DESTDIR)/bin

# Tools path
ECHO ?= echo
DOCKER ?= docker
GO ?= go
MKDIR ?= mkdir
TAR ?= tar
INSTALL ?= install
GIT ?= git

VERSION ?= $(shell $(GIT) describe --match 'v[0-9]*' --dirty='.m' --always --tags)
VERSION_TRIMMED := $(VERSION:v%=%)
REVISION ?= $(shell $(GIT) rev-parse HEAD)$(shell if ! $(GIT) diff --no-ext-diff --quiet --exit-code; then $(ECHO) .m; fi)

PKG_MAIN := github.com/containerd/fuse-overlayfs-snapshotter/cmd/containerd-fuse-overlayfs-grpc
PKG_VERSION := github.com/containerd/fuse-overlayfs-snapshotter/cmd/containerd-fuse-overlayfs-grpc/version

export GO_BUILD=GO111MODULE=on CGO_ENABLED=0 $(GO) build -ldflags "-s -w -X $(PKG_VERSION).Version=$(VERSION) -X $(PKG_VERSION).Revision=$(REVISION)"

bin/containerd-fuse-overlayfs-grpc:
	$(GO_BUILD) -o $@ $(PKG_MAIN)

all: binaries

help:
	@$(ECHO) "Usage: make <target>"
	@$(ECHO)
	@$(ECHO) " * 'install'   - Install binaries to system locations."
	@$(ECHO) " * 'uninstall' - Uninstall binaries from system."
	@$(ECHO) " * 'binaries'  - Build containerd-fuse-overlayfs-grpc."
	@$(ECHO) " * 'test'      - Run tests."
	@$(ECHO) " * 'clean'     - Clean artifacts."
	@$(ECHO) " * 'help'      - Show this help message."

binaries: bin/containerd-fuse-overlayfs-grpc

install:
	$(INSTALL) -D -m 755 $(CURDIR)/bin/containerd-fuse-overlayfs-grpc $(BINDIR)/containerd-fuse-overlayfs-grpc

uninstall:
	$(RM) $(BINDIR)/containerd-fuse-overlayfs-grpc

clean:
	$(RM) -r $(CURDIR)/bin $(CURDIR)/_output

test:
	DOCKER_BUILDKIT=1 $(DOCKER) build -t containerd-fuse-overlayfs-test --build-arg FUSEOVERLAYFS_COMMIT=${FUSEOVERLAYFS_COMMIT} .
	$(DOCKER) run --rm containerd-fuse-overlayfs-test fuse-overlayfs -V
	$(DOCKER) run --rm --security-opt seccomp=unconfined --security-opt apparmor=unconfined --device /dev/fuse containerd-fuse-overlayfs-test
	$(DOCKER) rmi containerd-fuse-overlayfs-test

_test:
	$(GO) test -exec rootlesskit -test.v -test.root

TAR_FLAGS=--transform 's/.*\///g' --owner=0 --group=0

artifacts: clean
	$(MKDIR) -p _output
	GOOS=linux GOARCH=amd64 make
	$(TAR) $(TAR_FLAGS) -czvf _output/containerd-fuse-overlayfs-$(VERSION_TRIMMED)-linux-amd64.tar.gz $(CURDIR)/bin/*
	GOOS=linux GOARCH=arm64 make
	$(TAR) $(TAR_FLAGS) -czvf _output/containerd-fuse-overlayfs-$(VERSION_TRIMMED)-linux-arm64.tar.gz $(CURDIR)/bin/*
	GOOS=linux GOARCH=arm GOARM=7 make
	$(TAR) $(TAR_FLAGS) -czvf _output/containerd-fuse-overlayfs-$(VERSION_TRIMMED)-linux-arm-v7.tar.gz $(CURDIR)/bin/*
	GOOS=linux GOARCH=ppc64le make
	$(TAR) $(TAR_FLAGS) -czvf _output/containerd-fuse-overlayfs-$(VERSION_TRIMMED)-linux-ppc64le.tar.gz $(CURDIR)/bin/*
	GOOS=linux GOARCH=s390x make
	$(TAR) $(TAR_FLAGS) -czvf _output/containerd-fuse-overlayfs-$(VERSION_TRIMMED)-linux-s390x.tar.gz $(CURDIR)/bin/*

.PHONY: \
	containerd-fuse-overlayfs-grpc \
	install \
	uninstall \
	clean \
	test \
	_test \
	artifacts \
	help
