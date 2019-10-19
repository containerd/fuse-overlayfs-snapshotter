// +build linux

/*
   Copyright The containerd Authors.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

package fuseoverlayfs

import (
	"context"
	"io/ioutil"
	"os"
	"testing"

	"github.com/containerd/containerd/pkg/testutil"
	"github.com/containerd/containerd/snapshots"
	"github.com/containerd/containerd/snapshots/testsuite"
)

func newSnapshotter(ctx context.Context, root string) (snapshots.Snapshotter, func() error, error) {
	snapshotter, err := NewSnapshotter(root)
	if err != nil {
		return nil, nil, err
	}

	return snapshotter, func() error { return snapshotter.Close() }, nil
}

func TestFUSEOverlayFS(t *testing.T) {
	testutil.RequiresRoot(t)
	td, err := ioutil.TempDir("", "fuseoverlayfs-test")
	if err != nil {
		t.Fatal(err)
	}
	defer os.RemoveAll(td)
	if err := Supported(td); err != nil {
		t.Skipf("fuse-overlayfs not supported: %v", err)
	}
	testsuite.SnapshotterSuite(t, "fuse-overlayfs", newSnapshotter)
}
