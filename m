Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AE38E135
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134450; cv=none; b=FdCnTRxI+BtyeqxJuuYbrSknwW8dpDt1BhZKxUCAzPGpt3x8XbmLpT+jNnhPeTVDbyNC2yuhQ4GhHUsSUGKxvUkBmw4nzlfsTgqEuarUBCeRgHA4wjw9OSfFnigETlkZdwCOgFXXWZ3erKTyPthZdMrwBwJmTs4lAw556D4NmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134450; c=relaxed/simple;
	bh=tYSxKMyfMzfo8EeQTYYjilfcNPfDFZCsNWtlsas3fvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5ZTVF/8G9GazQY0Gv5rnYjyJq3FNcZf60a3Z9/nJZ3wGRCWNIwFTJiustvj4J2A7m6RD8IH7CfDH1wYp15UDZW3FJ0VsrVs0PZ6Byk4hFdKCIz0Xyr8vYSnAixTSWOvYDgbuo78RNJI6VeS1dQWQAUJ0DM6qmlLgKcyTSXOcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jGudfAKZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jGudfAKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dP
	+8KLCrFIgRi/5WpsW4+WXEwUZjdEgxvnEtftE4AQU=; b=jGudfAKZn0aCa97Pyj
	43qK8KwITC6xLH8TkWVaenzdfGH0Kohuec/YNulH8KX9oMkbYRrOWirYu/gKPCvk
	2FgCwkLLHWZ0lm3q4u4CPdWDDXQK5LLewth0o9VBk4AmNaspoe+9txJMnfeWzkJh
	dF2VJEYr6oolZCK1GnsRuLGxU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnr7wPzdFqoTHrAQ--.20287S4;
	Fri, 16 Oct 2026 15:06:59 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v6 2/2] selftests: net: add TAP socket filter attach tests
Date: Fri, 16 Oct 2026 15:06:54 +0800
Message-Id: <20261016070654.170932-3-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016070654.170932-1-clementwei90@163.com>
References: <20261016070654.170932-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr7wPzdFqoTHrAQ--.20287S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45GF4rKF1xWF4UWFW3KFg_yoW3Gr1Upa
	s5WayDGr1UWrW7Xws7ArW8ZFWfAw4DGr15ZFs5K3s8Zr4DJry5Ca9akFWSk3Z2yr48uws0
	kFyaya43uws0qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3mi_UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4ROG8WrRzROF3wAA36

From: Rongguang Wei <weirongguang@kylinos.cn>

reattach_filter_without_user_buffer() attaches a filter, makes the buffer
the program was copied from unreadable, detaches the queue and attaches it
again. It then attaches a second queue from a fresh socket, which starts
without a filter of its own, so a clear IFF_NOFILTER shows that the filter
was installed again from the kernel copy.

attach_filter_bad_len_keeps_program() checks that a rejected
TUNATTACHFILTER leaves the installed program and the filter state that
TUNGETIFF reports alone, and that a queue attached afterwards still gets
the filter.

attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
ways to attach a queue without a filter.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/tun.c | 197 ++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index afaa81c9bac5..a4993a631957 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -8,9 +8,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/filter.h>
 #include <linux/if_tun.h>
 #include <netinet/tcp.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 
 #include "kselftest_harness.h"
@@ -543,6 +545,201 @@ TEST_F(tun, reattach_close_delete)
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+/* accept: return skb->len */
+static const struct sock_filter filter_accept[] = {
+	BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
+	BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0),
+	BPF_STMT(BPF_RET | BPF_A, 0),
+};
+
+/* Put the instructions in an anonymous mapping, so that the test can make the
+ * address unreadable afterwards.
+ */
+static void *filter_alloc(const struct sock_filter *insns, unsigned int len)
+{
+	void *p;
+
+	p = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED)
+		return NULL;
+
+	memcpy(p, insns, len * sizeof(*insns));
+
+	return p;
+}
+
+static int filter_attach(int fd, const struct sock_filter *insns, unsigned int len)
+{
+	struct sock_fprog fp = {
+		.len = len,
+		.filter = (struct sock_filter *)insns,
+	};
+
+	return ioctl(fd, TUNATTACHFILTER, (void *)&fp);
+}
+
+static int filter_get(int fd, struct sock_fprog *fp)
+{
+	return ioctl(fd, TUNGETFILTER, (void *)fp);
+}
+
+static int tun_get_iff_flags(int fd)
+{
+	struct ifreq ifr = { 0 };
+
+	if (ioctl(fd, TUNGETIFF, (void *)&ifr) < 0)
+		return -1;
+
+	return ifr.ifr_flags;
+}
+
+/*
+ * A queue can be attached long after the filter was configured, from a
+ * process that does not necessarily map the buffer the program was copied
+ * from, so the kernel has to keep its own copy of the program.  Here the
+ * mapping is made unreadable before the queue is attached again, and a
+ * second queue is then attached from a fresh socket, which starts without a
+ * filter of its own.
+ */
+TEST_F(tun, reattach_filter_without_user_buffer)
+{
+	struct sock_fprog gf = { 0 };
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	void *prog;
+	int fd, ret;
+
+	prog = filter_alloc(filter_accept, ARRAY_SIZE(filter_accept));
+	ASSERT_NE(prog, NULL);
+	ASSERT_EQ(filter_attach(self->fd, prog, ARRAY_SIZE(filter_accept)), 0);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+
+	/* This memory is no longer readable */
+	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_NONE), 0);
+
+	ret = tun_attach(self->fd, self->ifname);
+	EXPECT_EQ(ret, 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	/* The queue is attached again, not left disabled */
+	EXPECT_EQ(flags & IFF_DETACH_QUEUE, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	/* The two checks below document the expected state, they cannot
+	 * tell a reinstalled filter from no filter: tun_detach() leaves
+	 * sk_filter alone, and TUNGETFILTER only returns the header.
+	 */
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
+
+	/* A new queue starts without a filter, so a clear IFF_NOFILTER shows
+	 * that the filter was installed again from the kernel copy.
+	 */
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	close(fd);
+
+	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_READ | PROT_WRITE), 0);
+	ASSERT_EQ(munmap(prog, getpagesize()), 0);
+}
+
+/* A new queue attached with IFF_NOFILTER must not get the filter that is
+ * configured on the device.
+ */
+TEST_F(tun, attach_filter_nofilter_flag)
+{
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	int fd;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
+
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NOFILTER;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+
+	close(fd);
+}
+
+/* After TUNDETACHFILTER a later attach must not install the filter again */
+TEST_F(tun, detach_filter_clears_reattach)
+{
+	short flags = 0;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
+	EXPECT_EQ(ioctl(self->fd, TUNDETACHFILTER, 0), 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, IFF_NOFILTER);
+}
+
+/* A TUNATTACHFILTER with a bad length must leave the installed program and the
+ * filter state that TUNGETIFF reports alone.
+ */
+TEST_F(tun, attach_filter_bad_len_keeps_program)
+{
+	struct sock_fprog gf = { 0 };
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	int fd;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept, ARRAY_SIZE(filter_accept)), 0);
+
+	errno = 0;
+	EXPECT_EQ(filter_attach(self->fd, filter_accept, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	/* A queue attached afterwards still gets the filter, so the rejected
+	 * ioctl left the saved program and filter_attached alone.
+	 */
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	flags = tun_get_iff_flags(fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	close(fd);
+}
+
 FIXTURE(tun_vnet_gso)
 {
 	char ifname[IFNAMSIZ];
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

