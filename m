Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4312F585
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253370; cv=none; b=FWH8yI8M8n2WHLxWnmRruoSQaQuZ8gRbcZv6oAeSzEOISgyOyXbozIFNEAxloRcNGBiuBuXSYwYiEznlfhoHE8X1Ki8xAfvdBlhPGi/gU6q6nqtD54UZ4eGF+16WxJdCudZOM3QPhNoZOgG7oomWhLe3fabAvZ2czRH6SUC9lR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253370; c=relaxed/simple;
	bh=lUWA4xb1WZOgg9p4KFowNSeG13CI3AVou3LtH6C66Ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WwJPpqaWM79YFJVTkoGY1pF08Z95yzVnqLcwKu+0dOBmjtkIvTFlZX8+hzbyTUkMafT1TBcnqeqAdiYkV13mS/ZrB1BkrtYSX3VRvI2Sjm7n8L/EBlz8nY6Id69E23UExyWRIveEXbx5cLRzy4l+SGFS96ysQNUNf2w4z4KqTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJLmb/yf; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJLmb/yf"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9308eafb465so462220785a.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790253367; x=1790858167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GV9ZI7thFJMHgOAFeVa3fbM6vICJTD6exhedAfO/Ai0=;
        b=DJLmb/yfxixQ4SaxZIDh7k4TIuBB72U25tMsp8eqCoi00uIeoTASpryKEnB4YBMQss
         m/6NXkb3eaUsSeqbzXI8NFpp6E7JBz+DaadWokYuFrx3NqI/juZvqKDgIuxFQ7kkkyu8
         wkF+nAuwNBKBRWcG52rAToBJgUj6nU3QxXqMWjeByZw+2bfEJEk1K4kJlJFm4mVTRGXX
         rRFbSHDGw5l0mKcudyKelFNW4YVRiIGLaAimcZR/Hni8WS29CKQPMFgpTuODUX90pzZf
         dKqV0EVp6sviY21TFJxcVq3tO7YbLfi4mdc+t+eq0iO4cfdnt1U8u+Trx3S+NK7GOzre
         +1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253367; x=1790858167;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GV9ZI7thFJMHgOAFeVa3fbM6vICJTD6exhedAfO/Ai0=;
        b=Y159GNjRnlM9RNWmuTigHdFvixuCuYQckhB8bzJ26SUdNIaHn3MKY/Nd36UyCnMxxB
         2j8wzqxkwHhp3Py7Tzc2QFE3p51Ozt+33efcpP+i3leRcZ8smiPpjZdHU52OhRLI/kUA
         helJq68MweXugQxrob+5JRKaidKwfqQz9WEVUlGcywQnU5WJyeBmd62LxSAVDcdIXAZY
         3zLiTJt6skpqsL2Qqk5BcEeTbQ8tI3eM8dEqQweKD1gDLlgBj0v6hRc5JY6zrmG1d06F
         /RD00F7sSthqanpqKUgJXK3eUr9s/RqV8SanQLiTMXV+fNl+E2lAnd3zGvQTAY+qlHSz
         0+0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwffBq+kVTc4Q+sWhYbp0LAtLU7Uht50ZpnWD6PXzp7FMzOuk4BqKXDDDfV7Qz8sTkjbD3HSwE=@vger.kernel.org
X-Gm-Message-State: AFuF++kLNCNHVWrLIEf2X7CvAGLdV184wLMy08eOZOq/v5/fmDVsLNHv
	HHxnNDrKpVb9K+2/mcE+erM8c4GisR7YQGkahtk17/DDN8ZJSE9tZcISjT1egRUi8k3K9kt8dH+
	6azo3wYFBqgb76g==
X-Received: from qkkf20.prod.google.com ([2002:a05:620a:15b4:b0:93b:fab3:d62b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a0a:b0:932:ddff:1241 with SMTP id af79cd13be357-93c362bf196mr266622485a.26.1790253366830;
 Thu, 24 Sep 2026 05:36:06 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:36:02 +0000
In-Reply-To: <20260924123602.1979090-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924123602.1979090-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924123602.1979090-3-edumazet@google.com>
Subject: [PATCH net 2/2] selftests/net: add SO_RESERVE_MEM test
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
- Validate bounds (negative values and values > INT_MAX >> 1 return
  EINVAL).
- Verify reserve adjustments (increase, decrease, page rounding, and
  reset to 0) and corresponding sk_meminfo[SK_MEMINFO_FWD_ALLOC] changes
  via getsockopt(SO_MEMINFO).
- Exercise cgroup v2 memory.max enforcement returning ENOMEM when the
  requested reservation exceeds the cgroup limit.
- Verify that a child socket returned by accept() starts with a 0
  reserve even when its parent listener configured a non-zero
  SO_RESERVE_MEM.
- Verify reserve retention across TCP send/receive/ACK cycles.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Assisted-by: LLM
---
 tools/testing/selftests/net/.gitignore       |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/so_reserve_mem.c | 333 +++++++++++++++++++
 3 files changed, 335 insertions(+)
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
diff --git a/tools/testing/selftests/net/so_reserve_mem.c b/tools/testing/selftests/net/so_reserve_mem.c
new file mode 100644
index 0000000000000000000000000000000000000000..c2ca02ebe8353b858a94b7f1e026bad10bf9aeeb
--- /dev/null
+++ b/tools/testing/selftests/net/so_reserve_mem.c
@@ -0,0 +1,333 @@
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
+#ifndef SO_RESERVE_MEM
+#define SO_RESERVE_MEM 73
+#endif
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
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
+FIXTURE(so_reserve_mem)
+{
+	char cg_root[64];
+	char cg_child[128];
+	long page_size;
+	bool cg_mounted;
+};
+
+FIXTURE_SETUP(so_reserve_mem)
+{
+	char procs_path[160], ctrl_path[160];
+	int fd, ret;
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
+
+	snprintf(ctrl_path, sizeof(ctrl_path), "%s/cgroup.subtree_control",
+		 self->cg_root);
+	fd = open(ctrl_path, O_WRONLY);
+	if (fd >= 0) {
+		ret = write(fd, "+memory", 7);
+		(void)ret;
+		close(fd);
+	}
+
+	snprintf(self->cg_child, sizeof(self->cg_child), "%s/test_%d",
+		 self->cg_root, getpid());
+	if (mkdir(self->cg_child, 0755)) {
+		umount2(self->cg_root, MNT_DETACH);
+		rmdir(self->cg_root);
+		ASSERT_TRUE(false);
+	}
+
+	snprintf(procs_path, sizeof(procs_path), "%s/cgroup.procs",
+		 self->cg_child);
+	fd = open(procs_path, O_WRONLY);
+	if (fd < 0 || dprintf(fd, "%d\n", getpid()) <= 0) {
+		if (fd >= 0)
+			close(fd);
+		rmdir(self->cg_child);
+		umount2(self->cg_root, MNT_DETACH);
+		rmdir(self->cg_root);
+		ASSERT_TRUE(false);
+	}
+	close(fd);
+	self->cg_mounted = true;
+}
+
+FIXTURE_TEARDOWN(so_reserve_mem)
+{
+	char procs_path[160];
+	int fd;
+
+	if (!self->cg_mounted)
+		return;
+
+	snprintf(procs_path, sizeof(procs_path), "%s/cgroup.procs",
+		 self->cg_root);
+	fd = open(procs_path, O_WRONLY);
+	if (fd >= 0) {
+		dprintf(fd, "%d\n", getpid());
+		close(fd);
+	}
+	rmdir(self->cg_child);
+	umount2(self->cg_root, MNT_DETACH);
+	rmdir(self->cg_root);
+}
+
+static void check_non_tcp_rejected(struct __test_metadata *_metadata,
+				   int domain, int type, int protocol,
+				   int val)
+{
+	int fd = socket(domain, type, protocol);
+
+	if (fd < 0) {
+		EXPECT_TRUE(errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT);
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
+	/* Negative or > INT_MAX >> 1 value -> EINVAL */
+	val = -1;
+	EXPECT_EQ(setsockopt(fd, SOL_SOCKET, SO_RESERVE_MEM, &val, sizeof(val)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	val = (INT_MAX >> 1) + 1;
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
+	char max_path[160];
+	int ps = self->page_size;
+	int fd, max_fd, val;
+
+	snprintf(max_path, sizeof(max_path), "%s/memory.max", self->cg_child);
+	max_fd = open(max_path, O_WRONLY);
+	if (max_fd < 0)
+		SKIP(return, "cgroup memory controller not delegated");
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(fd, 0);
+
+	/* Limit cgroup memory to 8 pages and try to reserve 64 pages */
+	ASSERT_GT(dprintf(max_fd, "%ld\n", 8L * ps), 0);
+
+	val = 64 * ps;
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
2.56.0.rc1.310.g51773c2048-goog

