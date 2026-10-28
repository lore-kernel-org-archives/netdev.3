Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179983;
	b=LLmEc77kY756VKooQOR1SY9MuYWQRDHURTxeltLDcSvwx/lCIq+lDsmNfDbYoozdWwfn
	 HQyE21EnZrPZm4YwqYVX/7Nm9E19Z9vcaW88P/jvPMxfl7QUXDLc52xYyM32AeJRWwNok
	 I5ZxR795SEj0p4Vi7d7gK1Q6/IowH7RICttCvsDnmL+CnJtNOlbQ7OkJ3uC55DWhVbH1o
	 cSEgxw9GIsHfOKVHid2Jjy4cU13NMtMynkYEe+Dag3tlfcZZG7R3WxtK3kzbrF+ajeiHk
	 mCPrnfYAAAGvg+dLm2PqNzIbtgV2QqBmHyBNv5v+CL1gq9Dx72Al5897EhtG7Hfy8Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179983;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=n1LfOovnyA+uYBnXvqyeflhbol4DwWZKYc0TgqSc7X0=;
	b=b89uFgq4OYVVWcVQjUpOCekXzK7XtOQjDjWfryRGjaWpZo45yINRnLf8ywZAeMf/w8m1
	 yRP/CNGYaHqAlVg1xCFL+dzsE/4BTe9CAsikfOy6oPSHK3OZ9YaDmu+eZKwhfZug86D5f
	 pXMqRedv2u+9vfDnIQ4x+kpBcSDdTYydEBubl3U3AK63WkBbzt9htDO5Tu1LR+yoM+YtP
	 hFvnZh0/pPS4xKOUkx+k0+j+5DBSYiBV+5X9l4wPxiepUH5ENkjyN1EbPgXP4aSNQlyfr
	 aShiDRCsY2pbxl6sbaPJBxwa1XaUSe3f43STRtRRSTwtDRT0EIw0aXwm9G3w2g6yDzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T6U8imWX;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A982606A323
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A982606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=T6U8imWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=n1
	LfOovnyA+uYBnXvqyeflhbol4DwWZKYc0TgqSc7X0=; b=T6U8imWXHgCW/3HMBp
	896WNC9y+ZETYIubGD89Yabk6qGqp9uMFZRHOvEZrVR0spUgoqLWlb5whhNIgaLG
	v8CWdA7YDhAlXsJ9IUTC7Td3IQBVsK1FfESMOjhSZ7JnB3sbcmqJICZjid30Z1Cc
	ZwhEk5Y7UIyjMACe+1hi134KM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBn5es1weFqGkWrCQ--.12186S4;
	Wed, 28 Oct 2026 17:32:40 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v8 2/2] selftests: net: add TAP socket filter attach tests
Date: Wed, 28 Oct 2026 17:32:35 +0800
Message-Id: <20261028093235.148649-3-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028093235.148649-1-clementwei90@163.com>
References: <20261028093235.148649-1-clementwei90@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBn5es1weFqGkWrCQ--.12186S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45GF43AryxXF13ZFW8WFg_yoWfZr4fpa
	s5WayDGF1UXrW7Xws7ArW8uFWfAw4DGr15ZFs5K3s8Zrs8Gry5ua9akFWSkan2yr48uws0
	kFyaya43WwsIqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq6wAUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hiR-GrhwTjSoQAA3W

From: Rongguang Wei <weirongguang@kylinos.cn>

reattach_filter_without_user_buffer() attaches a filter, makes the buffer
the program was copied from unreadable, detaches the queue and attaches it
again. It then attaches a second queue from a fresh socket, which starts
without a filter of its own, so a clear IFF_NOFILTER shows that the filter
was installed again from the kernel copy.

attach_filter_bad_len_keeps_program() checks that a TUNATTACHFILTER with a
bad length leaves the installed program and the filter state that
TUNGETIFF reports alone, and that a queue attached afterwards still gets
the filter.  attach_filter_bad_prog_keeps_program() refuses a program with
a valid length and instructions that bpf_check_classic() rejects, and
checks the same properties: the filter state on the queue, and a queue
attached afterwards still gets the saved program.

attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
ways to attach a queue without a filter.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 tools/testing/selftests/net/tun.c | 249 ++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index afaa81c9bac53..f27df2734dad1 100644
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
@@ -543,6 +545,253 @@ TEST_F(tun, reattach_close_delete)
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+/* accept: return skb->len.  Three instructions on purpose, so that the
+ * length read back through TUNGETFILTER tells it apart from a rejected
+ * program that is shorter.
+ */
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
+/* A TUNATTACHFILTER with instructions that bpf_check_classic() rejects must
+ * be refused, and must leave the program installed already in place.
+ */
+TEST_F(tun, attach_filter_bad_prog_keeps_program)
+{
+	struct sock_fprog gf = { 0 };
+	struct sock_filter bad[] = {
+		BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
+	};
+	struct ifreq ifr = { 0 };
+	short flags = 0;
+	int fd;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_accept,
+				ARRAY_SIZE(filter_accept)), 0);
+
+	errno = 0;
+	EXPECT_EQ(filter_attach(self->fd, bad, ARRAY_SIZE(bad)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* the program attached before is untouched */
+	EXPECT_EQ(filter_get(self->fd, &gf), 0);
+	EXPECT_EQ(gf.len, ARRAY_SIZE(filter_accept));
+
+	/* IFF_NOFILTER comes from the socket's sk_filter, not from the saved
+	 * header, so a clear flag shows the filter is still installed.
+	 */
+	flags = tun_get_iff_flags(self->fd);
+	EXPECT_GE(flags, 0);
+	EXPECT_EQ(flags & IFF_NOFILTER, 0);
+
+	/* A queue attached afterwards still gets the filter, so the rejected
+	 * program never replaced the saved one.
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
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

