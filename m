Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB945DF6C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755696; cv=none; b=HysLoP+IkcNuV8BP9kmYhmsqP9TE7ECGLyFMbMRPIAW/uJJxFDc1huBtol+sdiFeT9Qz8CcnoT3auag0RlI919rgPJY7Kj5wsJXM0iIrFgt09uREyeeEh4hQzdTcQ/sPAhYZCLFnlQmbiR1LzXxXJwSWxnz4jyZlWz5PDgaExkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755696; c=relaxed/simple;
	bh=ypOyOY8DJxbZZx1YqhIY8z69H6+b09STEfEMYmscxqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqVH1UymFxFnafmtSdyKmE7Hy1iKUeU0AfXcupGd/mqBZ04jyRld4wrMUXmne2HSG3J09abs/qmaeXl5JP3U/QNsGJF6CcQ+bsjo4rq+SukFKEfy8ACCJQq9EXawn6z8n6VsNxhuC6PQO6V+TEa2Mcd//AP4y5lx+njkeJMwcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MWzYgqPB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MWzYgqPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tP
	4AUfgsIVstGgqPRYNcy+cvae1nS7fjcMfU7aZleO4=; b=MWzYgqPB0UINHf1tyK
	GV5CclOzoS1tn9kzFv7NxA4OU2cLr1C413GnfyZSJtXWwLuhyTVjuSyzemWpetfK
	gZFAHvvf9ScJ5SK41kHKSeYGewOBTcbUPMOH9ZN4ceCc+xI95aowt7KpGLcdOgMm
	JJ50EJzeONkm1V5V9BlQ48R70=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnNiBTw7xqRdh1Bw--.20247S5;
	Wed, 30 Sep 2026 16:07:53 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v3 3/3] selftests: net: add TAP socket filter attach tests
Date: Wed, 30 Sep 2026 16:07:46 +0800
Message-Id: <20260930080746.135017-4-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930080746.135017-1-clementwei90@163.com>
References: <20260930080746.135017-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnNiBTw7xqRdh1Bw--.20247S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45XF47Gr1rKw1fur4kZwb_yoW7uFWkpF
	93WayDJr1UWFy7Xan7ArW8AFWfXw4DGr15Zrs5K3s8ZrsrJryrCanakFWYkr1Iyr48uwn0
	kFyaya45uws8XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdxhLUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4RnQPGq8w1k6dAAA3W

From: Rongguang Wei <weirongguang@kylinos.cn>

reattach_filter_without_user_buffer() attaches a filter, makes the buffer
the program was copied from unreadable and then attaches the queue again,
which used to fail with -EFAULT.

attach_filter_bad_len_keeps_program() checks that a rejected
TUNATTACHFILTER leaves both the saved program and the installed filter
alone.

attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
ways to attach a queue without a filter.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 tools/testing/selftests/net/tun.c | 155 ++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index abe488bac50b..6f6023b16d1c 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -8,8 +8,10 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/filter.h>
 #include <linux/if_tun.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 
 #include "kselftest_harness.h"
@@ -542,6 +544,159 @@ TEST_F(tun, reattach_close_delete)
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
+ * A queue can be attached long after the filter was configured, from a process
+ * that does not necessarily map the buffer the program was copied from, so
+ * the kernel has to keep its own copy of the program.  Here the mapping is
+ * made unreadable before the queue is attached again: re-reading the user
+ * address used to fail with -EFAULT.
+ */
+TEST_F(tun, reattach_filter_without_user_buffer)
+{
+	struct sock_fprog gf = { 0 };
+	short flags = 0;
+	void *prog;
+	int ret;
+
+	prog = filter_alloc(filter_accept, ARRAY_SIZE(filter_accept));
+	ASSERT_NE(prog, NULL);
+	ASSERT_EQ(filter_attach(self->fd, prog, ARRAY_SIZE(filter_accept)), 0);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+
+	/* The process that called TUNATTACHFILTER no longer maps this memory */
+	ASSERT_EQ(mprotect(prog, getpagesize(), PROT_NONE), 0);
+
+	ret = tun_attach(self->fd, self->ifname);
+	EXPECT_EQ(ret, 0);
+
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
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
+	short flags = 0;
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
+}
+
 FIXTURE(tun_vnet_udptnl)
 {
 	char ifname[IFNAMSIZ];
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

