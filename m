Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1F380FF4
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882505; cv=none; b=G3Nxpk3baw47adiNGVHCldl+LDfUoVAv0p7G7J9//eEYHRFPTlFzLOK380jK+DfkwOaXl7RrzvZa3RpjSiwWhQ1DW1/bffYq96FZlmYtfO2Pmw5z0nyPvnrKBEnoC4lzfQMSEvk/GnEaQeAMTl50SIDYWJouzDD7Xp1Yo4l3Hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882505; c=relaxed/simple;
	bh=oLcUT0EnsxGEojThH/5a871va7gFkB+UhCnrwWKRQtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbMXlpDdn79ChanjRp1ymWr9eBABzQQ/6iLz9AOfiUBEgp0khc3KeD/L5u+3ewFCHZG/DG/oWieE9v9DwgF35mqnvjyJraYdi1oidZdnEG7j/ryU2Y536sv3/Yhk35JQjWl5GgA1EkWhgVxjFm3rHaZJZEFzam8WRuYjU3a8MQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD0i9Yv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD0i9Yv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EF01F000FF;
	Thu,  1 Oct 2026 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790882503;
	bh=4aCZKUm6E4u3x3PvSra9oM99mmGYZftZdEMJH2Ov3sc=;
	h=From:To:Cc:Subject:Date;
	b=VD0i9Yv/1xg0j9mgaTdyi3Nl2J9QZ07MXzm4WcQ3HBJBX4xQVYwRp7AjcGkIZn5lg
	 Qq0yYdWguoTcJ9lM9PZvNU51urPf2PJTJp0FDjmHXIqxuHqEp2+14HIl9jLshhwYvI
	 JqoPDwq6i4ZhSFcpBPVtJNY0UpuTrpTPoVGJqBaeeBhOwwBWJmfukxuCnXd2bfRGQO
	 doKj89wr2ppqqpCdVLMoLpT38vcnweYZBFzaaPwpvIxdUGzt5KVLgJHCF+cwbE0FzA
	 b7o6ga4MJlIGD3Fieos/7IjebhwIZbI+GTpK2qQyPB7FZIgCdLlrVWDlFE+tOlaUep
	 hKAMmFAlaFDgg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weiwan@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net-next] selftests/net: add SO_RESERVE_MEM test
Date: Thu,  1 Oct 2026 21:21:37 +0200
Message-ID: <20261001192137.309983-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kselftest suite covering SO_RESERVE_MEM behavior:
- Reject unsupported socket types (UDP/SOCK_DGRAM, UNIX/SOCK_STREAM,
  SOCK_RAW, MPTCP) with EOPNOTSUPP, for both zero and non-zero values.
- Validate bounds (negative values and values > SZ_1G return EINVAL).
- Verify reserve adjustments (increase, decrease, page rounding, and
  reset to 0) and corresponding sk_meminfo[SK_MEMINFO_FWD_ALLOC] changes
  via getsockopt(SO_MEMINFO).
- Exercise cgroup v2 memory.max enforcement returning ENOMEM when the
  requested reservation exceeds the cgroup limit.
- Verify that a child socket returned by accept() starts with a 0
  reserve even when its parent listener configured a non-zero
  SO_RESERVE_MEM.
- Verify reserve retention across TCP send/receive/ACK cycles.

Each test runs in private mount and network namespaces. cgroup2 is
mounted on a private tmpfs, so nothing is left behind in the host
filesystem. The test process is moved to a dedicated leaf cgroup, and
back to its original cgroup on teardown. The memory controller is
enabled in the root of the hierarchy if needed, and left enabled like
selftests/cgroup do, as disabling it could break other users.

Also enable CONFIG_CGROUPS=y and CONFIG_MEMCG=y in
tools/testing/selftests/net/config.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: LLM
---
v3: (net-next submission)
 - run in a private netns, bring lo up
 - mount cgroup2 on a private tmpfs, check MS_PRIVATE remount
 - move back to the original cgroup instead of the hierarchy root (Sashiko)
 - never disable the memory controller (Sashiko)
 - accept EPERM/EACCES for SOCK_RAW creation (Sashiko)
 - also check val == 0 on non-TCP sockets (Wei)
 - wait for WMEM_QUEUED == 0 and FWD_ALLOC >= reserve in one snapshot (Sashiko)
v2: https://lore.kernel.org/netdev/20260925135244.3715196-1-edumazet@google.com/

 tools/testing/selftests/net/.gitignore       |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/config           |   2 +
 tools/testing/selftests/net/so_reserve_mem.c | 448 +++++++++++++++++++
 4 files changed, 452 insertions(+)
 create mode 100644 tools/testing/selftests/net/so_reserve_mem.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index dacd36ed8455e38576ff3df27acdea02d7b78edf..21412510ac26b869f68b91bc5830b12bf3568518 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -41,6 +41,7 @@ skf_net_off
 socket
 so_incoming_cpu
 so_netns_cookie
+so_reserve_mem
 so_rcv_listener
 stress_reuseport_listen
 tap
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index cab3f2c90039f691b40a3b977ba5ad0740661eb2..54beea2e348c45db56604e2e3c5027829d2f3e53 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -197,6 +197,7 @@ TEST_GEN_PROGS := \
 	sk_connect_zero_addr \
 	sk_so_peek_off \
 	so_incoming_cpu \
+	so_reserve_mem \
 	tap \
 	tcp_port_share \
 	tls \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 737e7e6327b3793984718eb518d3fb79b7870e4d..d355cf98059770bbcdcda1a33d8e84bc390eb26a 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -7,6 +7,7 @@ CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CAN=m
 CONFIG_CAN_DEV=m
 CONFIG_CAN_VXCAN=m
+CONFIG_CGROUPS=y
 CONFIG_CRYPTO_ARIA=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_SHA1=y
@@ -61,6 +62,7 @@ CONFIG_L2TP_V3=y
 CONFIG_MACSEC=m
 CONFIG_MACVLAN=y
 CONFIG_MACVTAP=y
+CONFIG_MEMCG=y
 CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_MPLS_ROUTING=m
diff --git a/tools/testing/selftests/net/so_reserve_mem.c b/tools/testing/selftests/net/so_reserve_mem.c
new file mode 100644
index 0000000000000000000000000000000000000000..aca5960ddff2544a7b5f1aec8d48332178a54a11
--- /dev/null
+++ b/tools/testing/selftests/net/so_reserve_mem.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/sock_diag.h>
+#include <net/if.h>
+#include <netinet/in.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+#define SO_RESERVE_MEM_MAX (1 << 30)
+
+/* cgroup2 is mounted here, on a tmpfs, in a private mount namespace. */
+#define CG_TMP "/tmp"
+#define CG_MNT CG_TMP "/cgroup2"
+
+static int cg_write(const char *dir, const char *file, const char *buf,
+		    int flags)
+{
+	ssize_t len = strlen(buf);
+	char path[PATH_MAX];
+	int fd, ret;
+
+	snprintf(path, sizeof(path), "%s/%s", dir, file);
+	fd = open(path, O_WRONLY | flags);
+	if (fd < 0)
+		return -1;
+	ret = write(fd, buf, len) == len ? 0 : -1;
+	close(fd);
+	return ret;
+}
+
+static int cg_read(const char *dir, const char *file, char *buf, size_t size)
+{
+	char path[PATH_MAX];
+	ssize_t n;
+	int fd;
+
+	snprintf(path, sizeof(path), "%s/%s", dir, file);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	n = read(fd, buf, size - 1);
+	close(fd);
+	if (n < 0)
+		return -1;
+	buf[n] = '\0';
+	return 0;
+}
+
+static int cg_enter(const char *dir)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "%d\n", getpid());
+	return cg_write(dir, "cgroup.procs", buf, 0);
+}
+
+/* Path of the current cgroup, below CG_MNT. */
+static int cg_get_current(char *buf, size_t size)
+{
+	char line[PATH_MAX];
+	int ret = -1;
+	FILE *f;
+
+	f = fopen("/proc/self/cgroup", "r");
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		if (strncmp(line, "0::", 3))
+			continue;
+		line[strcspn(line, "\n")] = '\0';
+		if (snprintf(buf, size, "%s%s", CG_MNT, line + 3) < (int)size)
+			ret = 0;
+		break;
+	}
+	fclose(f);
+	return ret;
+}
+
+static int get_reserve_mem(struct __test_metadata *_metadata, int fd)
+{
+	int val = -1;
+	socklen_t len = sizeof(val);
+
+	EXPECT_EQ(getsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, &len), 0);
+	return val;
+}
+
+static __u32 get_fwd_alloc(struct __test_metadata *_metadata, int fd)
+{
+	__u32 meminfo[SK_MEMINFO_VARS] = {};
+	socklen_t len = sizeof(meminfo);
+
+	EXPECT_EQ(getsockopt(fd, SOL_SOCKET, SO_MEMINFO, meminfo, &len), 0);
+	return meminfo[SK_MEMINFO_FWD_ALLOC];
+}
+
+/* Wait until a single SO_MEMINFO snapshot shows an empty write queue
+ * and at least @min_fwd_alloc bytes of forward alloc: ACK processing
+ * (possibly running on another CPU) first decrements sk_wmem_queued,
+ * then uncharges sk_forward_alloc.
+ */
+static void wait_wmem_drained(struct __test_metadata *_metadata, int fd,
+			      __u32 min_fwd_alloc)
+{
+	__u32 meminfo[SK_MEMINFO_VARS] = {};
+	socklen_t len;
+	int i;
+
+	for (i = 0; i < 5000; i++) {
+		len = sizeof(meminfo);
+		ASSERT_EQ(getsockopt(fd, SOL_SOCKET, SO_MEMINFO, meminfo, &len), 0);
+		if (meminfo[SK_MEMINFO_WMEM_QUEUED] == 0 &&
+		    meminfo[SK_MEMINFO_FWD_ALLOC] >= min_fwd_alloc)
+			return;
+		usleep(1000);
+	}
+	EXPECT_EQ(meminfo[SK_MEMINFO_WMEM_QUEUED], 0U);
+	EXPECT_GE(meminfo[SK_MEMINFO_FWD_ALLOC], min_fwd_alloc);
+}
+
+FIXTURE(so_reserve_mem)
+{
+	char cg_orig[PATH_MAX];	/* cgroup the test started in */
+	char cg_test[PATH_MAX];	/* cgroup the test sockets are charged to */
+	long page_size;
+	bool cg_created;
+};
+
+/* The cgroup2 mount lives in a private mount namespace which goes away
+ * with the test process, no need to unmount it.
+ */
+FIXTURE_TEARDOWN(so_reserve_mem)
+{
+	if (!self->cg_created)
+		return;
+
+	/* Leave cg_test so that it can be removed. */
+	EXPECT_EQ(cg_enter(self->cg_orig), 0);
+	EXPECT_EQ(rmdir(self->cg_test), 0);
+	self->cg_created = false;
+}
+
+FIXTURE_SETUP(so_reserve_mem)
+{
+	struct ifreq ifr = {
+		.ifr_name = "lo",
+		.ifr_flags = IFF_UP,
+	};
+	int fd, err, ret, val = 0;
+	char buf[256];
+
+	self->page_size = sysconf(_SC_PAGESIZE);
+	ASSERT_GT(self->page_size, 0);
+
+	if (unshare(CLONE_NEWNS | CLONE_NEWNET))
+		SKIP(return, "Failed to unshare namespaces (need root)");
+
+	/* Make sure the mounts below do not propagate to the host. */
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	if (mount("none", CG_TMP, "tmpfs", 0, NULL) ||
+	    mkdir(CG_MNT, 0755) ||
+	    mount("none", CG_MNT, "cgroup2", 0, NULL))
+		SKIP(return, "Failed to mount cgroup2");
+
+	ASSERT_EQ(cg_get_current(self->cg_orig, sizeof(self->cg_orig)), 0);
+
+	/* cg_test needs the memory controller to be enabled in the root of
+	 * the hierarchy (which is not necessarily the global root cgroup
+	 * when running in a cgroup namespace). Like selftests/cgroup, leave
+	 * it enabled on exit: disabling it could break other users of the
+	 * hierarchy.
+	 */
+	ASSERT_EQ(cg_read(CG_MNT, "cgroup.subtree_control", buf, sizeof(buf)), 0);
+	if (!strstr(buf, "memory") &&
+	    cg_write(CG_MNT, "cgroup.subtree_control", "+memory", 0))
+		SKIP(return, "cgroup2 memory controller not available");
+
+	/* cg_test is a leaf cgroup, it can always host the test process. */
+	snprintf(self->cg_test, sizeof(self->cg_test),
+		 "%s/ksft_so_reserve_mem_%d", CG_MNT, getpid());
+	if (mkdir(self->cg_test, 0755))
+		SKIP(return, "Failed to create test cgroup");
+	self->cg_created = true;
+
+	ret = cg_enter(self->cg_test);
+	if (ret)
+		so_reserve_mem_teardown(_metadata, self, variant);
+	ASSERT_EQ(ret, 0);
+
+	/* Bring up loopback and verify memcg socket accounting is enabled */
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	ret = fd < 0 ? -1 : ioctl(fd, SIOCSIFFLAGS, &ifr);
+	if (ret) {
+		if (fd >= 0)
+			close(fd);
+		so_reserve_mem_teardown(_metadata, self, variant);
+	}
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val));
+	err = errno;
+	close(fd);
+	if (ret) {
+		so_reserve_mem_teardown(_metadata, self, variant);
+		if (err == EOPNOTSUPP)
+			SKIP(return, "memcg socket accounting not enabled");
+	}
+	ASSERT_EQ(ret, 0);
+}
+
+static void check_non_tcp_rejected(struct __test_metadata *_metadata,
+				   int domain, int type, int protocol,
+				   int val)
+{
+	int fd = socket(domain, type, protocol);
+	int zero = 0;
+
+	if (fd < 0) {
+		/* Protocol not available, or no CAP_NET_RAW */
+		EXPECT_TRUE(errno == EAFNOSUPPORT ||
+			    errno == EPROTONOSUPPORT ||
+			    errno == ENOPROTOOPT ||
+			    errno == EPERM ||
+			    errno == EACCES);
+		TH_LOG("socket(%d, %d, %d): %s, skipped",
+		       domain, type, protocol, strerror(errno));
+		return;
+	}
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &zero, sizeof(zero)), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	close(fd);
+}
+
+TEST_F(so_reserve_mem, non_tcp_rejected)
+{
+	int val = self->page_size * 4;
+
+	check_non_tcp_rejected(_metadata, AF_INET, SOCK_DGRAM, 0, val);
+	check_non_tcp_rejected(_metadata, AF_UNIX, SOCK_STREAM, 0, val);
+	check_non_tcp_rejected(_metadata, AF_INET, SOCK_RAW, IPPROTO_ICMP, val);
+	check_non_tcp_rejected(_metadata, AF_INET, SOCK_STREAM, IPPROTO_MPTCP, val);
+}
+
+TEST_F(so_reserve_mem, grow_shrink_and_rounding)
+{
+	int ps = self->page_size;
+	int fd, val;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(fd, 0);
+
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 0);
+	EXPECT_EQ(get_fwd_alloc(_metadata, fd), 0U);
+
+	/* Negative or > SO_RESERVE_MEM_MAX value -> EINVAL */
+	val = -1;
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	val = SO_RESERVE_MEM_MAX + 1;
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	val = INT_MAX;
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* 1 byte rounds up to 1 page */
+	val = 1;
+	ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), ps);
+	EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)ps);
+
+	/* Grow to 16 pages */
+	val = 16 * ps;
+	ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 16 * ps);
+	EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)(16 * ps));
+
+	/* Shrink by 1 byte (rounds delta down to 0 -> stays 16 pages) */
+	val = 16 * ps - 1;
+	ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 16 * ps);
+	EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)(16 * ps));
+
+	/* Shrink to 4 pages */
+	val = 4 * ps;
+	ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 4 * ps);
+	EXPECT_EQ(get_fwd_alloc(_metadata, fd), (__u32)(4 * ps));
+
+	/* Release all */
+	val = 0;
+	ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 0);
+	EXPECT_EQ(get_fwd_alloc(_metadata, fd), 0U);
+
+	close(fd);
+}
+
+TEST_F(so_reserve_mem, cgroup_memory_max)
+{
+	int ps = self->page_size;
+	char buf[32];
+	int fd, val;
+
+	/* The socket is charged to cg_test */
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(fd, 0);
+
+	/* Move the test process back to its original cgroup before lowering
+	 * cg_test's memory.max, so that the limit only governs the socket's
+	 * memcg charges and cannot trigger OOM on the test process itself.
+	 */
+	ASSERT_EQ(cg_enter(self->cg_orig), 0);
+
+	/* Limit cg_test memory to 8 pages and try to reserve 128 pages.
+	 * O_NONBLOCK: do not try to reclaim cg_test usage above the new limit.
+	 */
+	snprintf(buf, sizeof(buf), "%d\n", 8 * ps);
+	ASSERT_EQ(cg_write(self->cg_test, "memory.max", buf, O_NONBLOCK), 0);
+
+	val = 128 * ps;
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), -1);
+	EXPECT_EQ(errno, ENOMEM);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 0);
+
+	/* Restore unlimited memory.max */
+	ASSERT_EQ(cg_write(self->cg_test, "memory.max", "max\n", 0), 0);
+
+	val = 4 * ps;
+	ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 4 * ps);
+
+	close(fd);
+}
+
+TEST_F(so_reserve_mem, accept_child_zero_reserve)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	socklen_t alen = sizeof(addr);
+	int ps = self->page_size;
+	int lfd, cfd, sfd, val;
+
+	lfd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(lfd, 0);
+
+	/* Set SO_RESERVE_MEM on listener before listen() */
+	val = 4 * ps;
+	ASSERT_EQ(setsockopt(lfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	ASSERT_EQ(bind(lfd, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(lfd, 2), 0);
+	ASSERT_EQ(getsockname(lfd, (struct sockaddr *)&addr, &alen), 0);
+
+	/* Grow SO_RESERVE_MEM on listener after listen() */
+	val = 8 * ps;
+	ASSERT_EQ(setsockopt(lfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, lfd), 8 * ps);
+	EXPECT_EQ(get_fwd_alloc(_metadata, lfd), (__u32)(8 * ps));
+
+	cfd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(cfd, 0);
+	ASSERT_EQ(connect(cfd, (struct sockaddr *)&addr, sizeof(addr)), 0);
+
+	sfd = accept(lfd, NULL, NULL);
+	ASSERT_GE(sfd, 0);
+
+	/* Child after accept() must have 0 reserve while listener keeps 8 pages */
+	EXPECT_EQ(get_reserve_mem(_metadata, sfd), 0);
+	EXPECT_EQ(get_fwd_alloc(_metadata, sfd), 0U);
+	EXPECT_EQ(get_reserve_mem(_metadata, lfd), 8 * ps);
+	EXPECT_EQ(get_fwd_alloc(_metadata, lfd), (__u32)(8 * ps));
+
+	/* Child can still independently set its own SO_RESERVE_MEM */
+	val = 6 * ps;
+	ASSERT_EQ(setsockopt(sfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	EXPECT_EQ(get_reserve_mem(_metadata, sfd), 6 * ps);
+	EXPECT_EQ(get_fwd_alloc(_metadata, sfd), (__u32)(6 * ps));
+
+	close(sfd);
+	close(cfd);
+	close(lfd);
+}
+
+TEST_F(so_reserve_mem, preserved_after_traffic)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	socklen_t alen = sizeof(addr);
+	int ps = self->page_size;
+	int lfd, cfd, sfd, val;
+	char buf[8192] = {};
+
+	lfd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(lfd, 0);
+	ASSERT_EQ(bind(lfd, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(lfd, 1), 0);
+	ASSERT_EQ(getsockname(lfd, (struct sockaddr *)&addr, &alen), 0);
+
+	cfd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(cfd, 0);
+	val = 16 * ps;
+	ASSERT_EQ(setsockopt(cfd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), 0);
+	ASSERT_EQ(connect(cfd, (struct sockaddr *)&addr, sizeof(addr)), 0);
+
+	sfd = accept(lfd, NULL, NULL);
+	ASSERT_GE(sfd, 0);
+
+	/* Send & drain traffic; cfd must retain its 16-page forward alloc,
+	 * while sfd (0 reserve) reclaims its forward alloc back to 0.
+	 */
+	ASSERT_EQ(send(cfd, buf, sizeof(buf), 0), (ssize_t)sizeof(buf));
+	ASSERT_EQ(recv(sfd, buf, sizeof(buf), MSG_WAITALL), (ssize_t)sizeof(buf));
+	wait_wmem_drained(_metadata, cfd, 16 * ps);
+
+	EXPECT_EQ(get_fwd_alloc(_metadata, sfd), 0U);
+
+	close(sfd);
+	close(cfd);
+	close(lfd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0

