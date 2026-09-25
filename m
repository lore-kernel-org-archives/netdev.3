Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD54A64C4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344373; cv=none; b=a1u4+7FnUIqfgVHMFlGpKxj0X224VnWbShv0uOvN6f8JF53m7wWTloxjtMVxkbU5+Y1cpthIZlFn0K1zqnMjDFWfbmGqSM8FC5nZvpawdZ5aAfOF8yhFVLP7XrwjBeQCLTlGQyaUfFGiT2fa9yC4F6MvMF6w15Y5X/wX8LcNyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344373; c=relaxed/simple;
	bh=rxxWmnfvi02ITnnw+Dt7o2tQabJ0UiZLBU9KBRIrwcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zkq4A2QTHy/W4/iEmOA/CMkr84XANNJ5VN5zAWiJV5OBhk04yx7pdyZag4eWfu7uO7AGYyNuz1xyVaKIbjpRBjG1zSKY3HKiR+hzrolTZpVCfbtIdwEfxbAI6HqC6rOW1nPdmnonRUGP6YiwYW8e9MokNXXmqVW7nUryt44vZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhNFAljX; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhNFAljX"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90c8da50f4fso13794396d6.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790344370; x=1790949170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLihyrhCXq5dkPhFpvcsDrI/Zsxtsbj0ISYVIQ15uXE=;
        b=mhNFAljXC6YnFP9NaXE6Hc4x6GAKLSIjt7TCCNQxlUVP32xDdPLFyyJm35l173fU4H
         8TrkCOGCJcTlZ0kL60/o9+oQN4levqnvVGf8SzqyNsoRoT/L5/mwFQ6V7FzJzP0X5IH2
         w6lBLyf9n9Y/pEqkYJI+7G+MvRXJYDySHfojf8P1XUadjzH+hzjB1EU32843p09yxE2F
         0qv491eoeRDCfmt7292zRqHEQCCzsjCpkFF4IN0QiWiuh4IyPGeErSi9fCT3umAkr2M0
         0IXZB2PGCmNTqJnSPCaMTcjFF41+M/LGrAP8MtDlfZW2shzGWpTDh10FxW4mKdvfww91
         feTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790344370; x=1790949170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLihyrhCXq5dkPhFpvcsDrI/Zsxtsbj0ISYVIQ15uXE=;
        b=a/MOMQvQrs64OpGKwXY2AG0OLMwtfC67ZcoG8I47TB0G/hf8Iww5YeN3NO4yoQeQSe
         07lhaE4WEvNK0+/e31sKPr3FIpCtxo9nwEjwI5gR0ANef/BV2X2ibWPQrhWkGZDssxnW
         fiywIzs0cYJjaj22ZNJ1aAecNI2gZ46ROHONEC+TswUSJcnTHU3paPufNFkgcljpF+nO
         MIoX7+4D7usdjIxbWxvQdzEQ7R3KlC3LEhG65XMzAusJSZIJEU8xPyRJC1fMJpnIeRAp
         AQV9qbGh8myn7cgV6nx7IvB5K6yQ557/CEACDZGp6kI4H+0droGeHoR5y8+HG5VMmP8v
         7qGg==
X-Forwarded-Encrypted: i=1; AKwUvBzliTS1QPKGbJgU7T0A7+VB/sJAQBpqcU6bSRpgT6wEcLLILDqlvqiD/PaAyYe3BZgq4GVGy9w=@vger.kernel.org
X-Gm-Message-State: AFuF++mH04+ENvBVr+yFUckhIzJRC1dVYEo53BBB9prQ5Kr3sI+WqSQo
	FVqc+4V6UflS9PVLM0x9DNZMO1wTyD9F5zA0qcGoDwXBQ0I0wje2Mq4ckYsPQ6Ar0D+komr7aBG
	tb8PBi6vNkLOmRA==
X-Received: from qvbd14.prod.google.com ([2002:a05:6214:506e:b0:914:c8f:a257])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:509b:b0:912:3fc7:2336 with SMTP id 6a1803df08f44-9142f92832bmr41575026d6.31.1790344369374;
 Fri, 25 Sep 2026 06:52:49 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:52:44 +0000
In-Reply-To: <20260925135244.3715196-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925135244.3715196-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925135244.3715196-3-edumazet@google.com>
Subject: [PATCH v2 net 2/2] selftests/net: add SO_RESERVE_MEM test
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weiwan@google.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a kselftest suite covering SO_RESERVE_MEM behavior:
- Reject unsupported socket types (UDP/SOCK_DGRAM, UNIX/SOCK_STREAM,
  SOCK_RAW, MPTCP) with EOPNOTSUPP.
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

Also enable CONFIG_CGROUPS=y and CONFIG_MEMCG=y in
tools/testing/selftests/net/config.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Assisted-by: LLM
---
 tools/testing/selftests/net/.gitignore       |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/config           |   2 +
 tools/testing/selftests/net/so_reserve_mem.c | 404 +++++++++++++++++++
 4 files changed, 408 insertions(+)
 create mode 100644 tools/testing/selftests/net/so_reserve_mem.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index c9f46031ac73b20850d068125bb804420d236ad8..a15d7cc4fdcb22b36fdb35b9eaf47e511caa8673 100644
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
index 3ee3378f8b26eff9d99a834491ad5ef594dcd782..300207a840c1bcb73a41151c8f94e8f78d01a29b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -196,6 +196,7 @@ TEST_GEN_PROGS := \
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
index 0000000000000000000000000000000000000000..920aeccc0ddf780e1b7ffd2172cf8bc2a01320f1
--- /dev/null
+++ b/tools/testing/selftests/net/so_reserve_mem.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/sock_diag.h>
+#include <netinet/in.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
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
+static void wait_wmem_drained(struct __test_metadata *_metadata, int fd)
+{
+	__u32 meminfo[SK_MEMINFO_VARS] = {};
+	socklen_t len;
+	int i;
+
+	for (i = 0; i < 1000; i++) {
+		len = sizeof(meminfo);
+		ASSERT_EQ(getsockopt(fd, SOL_SOCKET, SO_MEMINFO, meminfo, &len), 0);
+		if (meminfo[SK_MEMINFO_WMEM_QUEUED] == 0)
+			return;
+		usleep(1000);
+	}
+	EXPECT_EQ(meminfo[SK_MEMINFO_WMEM_QUEUED], 0U);
+}
+
+FIXTURE(so_reserve_mem)
+{
+	char cg_root[64];
+	char cg_child[128];
+	long page_size;
+	bool cg_mounted;
+	bool restore_subtree_ctrl;
+};
+
+FIXTURE_TEARDOWN(so_reserve_mem)
+{
+	char path[160];
+	int fd;
+
+	if (!self->cg_mounted)
+		return;
+
+	snprintf(path, sizeof(path), "%s/cgroup.procs", self->cg_root);
+	fd = open(path, O_WRONLY);
+	if (fd >= 0) {
+		dprintf(fd, "%d\n", getpid());
+		close(fd);
+	}
+	if (self->cg_child[0]) {
+		rmdir(self->cg_child);
+		self->cg_child[0] = '\0';
+	}
+	if (self->restore_subtree_ctrl) {
+		snprintf(path, sizeof(path), "%s/cgroup.subtree_control",
+			 self->cg_root);
+		fd = open(path, O_WRONLY);
+		if (fd >= 0) {
+			if (write(fd, "-memory", 7) < 0)
+				;
+			close(fd);
+		}
+		self->restore_subtree_ctrl = false;
+	}
+	umount2(self->cg_root, MNT_DETACH);
+	rmdir(self->cg_root);
+	self->cg_mounted = false;
+}
+
+FIXTURE_SETUP(so_reserve_mem)
+{
+	char procs_path[160], ctrl_path[160], ctrl_buf[256] = {};
+	int fd, ret, val = 0;
+
+	self->page_size = sysconf(_SC_PAGESIZE);
+	ASSERT_GT(self->page_size, 0);
+
+	if (unshare(CLONE_NEWNS))
+		SKIP(return, "Failed to unshare mount namespace (need root)");
+
+	mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+
+	snprintf(self->cg_root, sizeof(self->cg_root),
+		 "/tmp/ksft_so_reserve_XXXXXX");
+	ASSERT_NE(mkdtemp(self->cg_root), NULL);
+
+	if (mount("none", self->cg_root, "cgroup2", 0, NULL)) {
+		rmdir(self->cg_root);
+		SKIP(return, "Failed to mount cgroup2 (need root)");
+	}
+	self->cg_mounted = true;
+
+	snprintf(ctrl_path, sizeof(ctrl_path), "%s/cgroup.subtree_control",
+		 self->cg_root);
+	fd = open(ctrl_path, O_RDWR);
+	if (fd < 0) {
+		so_reserve_mem_teardown(_metadata, self, variant);
+		SKIP(return, "Failed to open cgroup.subtree_control");
+	}
+	if (read(fd, ctrl_buf, sizeof(ctrl_buf) - 1) < 0) {
+		close(fd);
+		so_reserve_mem_teardown(_metadata, self, variant);
+		SKIP(return, "Failed to read cgroup.subtree_control");
+	}
+	if (!strstr(ctrl_buf, "memory")) {
+		if (write(fd, "+memory", 7) != 7) {
+			close(fd);
+			so_reserve_mem_teardown(_metadata, self, variant);
+			SKIP(return, "cgroup2 memory controller not available");
+		}
+		self->restore_subtree_ctrl = true;
+	}
+	close(fd);
+
+	snprintf(self->cg_child, sizeof(self->cg_child), "%s/test_%d",
+		 self->cg_root, getpid());
+	if (mkdir(self->cg_child, 0755)) {
+		self->cg_child[0] = '\0';
+		so_reserve_mem_teardown(_metadata, self, variant);
+		ASSERT_TRUE(false);
+	}
+
+	snprintf(procs_path, sizeof(procs_path), "%s/cgroup.procs",
+		 self->cg_child);
+	fd = open(procs_path, O_WRONLY);
+	if (fd < 0 || dprintf(fd, "%d\n", getpid()) <= 0) {
+		if (fd >= 0)
+			close(fd);
+		so_reserve_mem_teardown(_metadata, self, variant);
+		ASSERT_TRUE(false);
+	}
+	close(fd);
+
+	/* Verify memcg socket accounting is enabled on this kernel */
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (fd < 0) {
+		so_reserve_mem_teardown(_metadata, self, variant);
+		ASSERT_GE(fd, 0);
+	}
+	ret = setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val));
+	close(fd);
+	if (ret && errno == EOPNOTSUPP) {
+		so_reserve_mem_teardown(_metadata, self, variant);
+		SKIP(return, "memcg socket accounting not enabled");
+	}
+	if (ret) {
+		so_reserve_mem_teardown(_metadata, self, variant);
+		ASSERT_EQ(ret, 0);
+	}
+}
+
+static void check_non_tcp_rejected(struct __test_metadata *_metadata,
+				   int domain, int type, int protocol,
+				   int val)
+{
+	int fd = socket(domain, type, protocol);
+
+	if (fd < 0) {
+		EXPECT_TRUE(errno == EAFNOSUPPORT ||
+			    errno == EPROTONOSUPPORT ||
+			    errno == ENOPROTOOPT);
+		return;
+	}
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
+	char max_path[160], procs_path[160];
+	int fd, max_fd, procs_fd, val;
+	int ps = self->page_size;
+
+	snprintf(max_path, sizeof(max_path), "%s/memory.max", self->cg_child);
+	max_fd = open(max_path, O_WRONLY | O_NONBLOCK);
+	if (max_fd < 0)
+		SKIP(return, "cgroup memory controller not delegated");
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(fd, 0);
+
+	/* Move test process back to root cgroup before lowering cg_child's
+	 * memory.max so the limit only governs the socket's memcg charges
+	 * and cannot trigger OOM on the test process itself.
+	 */
+	snprintf(procs_path, sizeof(procs_path), "%s/cgroup.procs",
+		 self->cg_root);
+	procs_fd = open(procs_path, O_WRONLY);
+	ASSERT_GE(procs_fd, 0);
+	ASSERT_GT(dprintf(procs_fd, "%d\n", getpid()), 0);
+	close(procs_fd);
+
+	/* Limit cg_child memory to 8 pages and try to reserve 128 pages */
+	ASSERT_GT(dprintf(max_fd, "%ld\n", 8L * ps), 0);
+
+	val = 128 * ps;
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), -1);
+	EXPECT_EQ(errno, ENOMEM);
+	EXPECT_EQ(get_reserve_mem(_metadata, fd), 0);
+
+	/* Restore unlimited memory.max */
+	ASSERT_GT(dprintf(max_fd, "max\n"), 0);
+	close(max_fd);
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
+	wait_wmem_drained(_metadata, cfd);
+
+	EXPECT_GE(get_fwd_alloc(_metadata, cfd), (__u32)(16 * ps));
+	EXPECT_EQ(get_fwd_alloc(_metadata, sfd), 0U);
+
+	close(sfd);
+	close(cfd);
+	close(lfd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

