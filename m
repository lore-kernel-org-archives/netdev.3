Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B74E36FE
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674667; cv=none; b=kZ+bellyOAd5z+i9SSG78YwPW2Kz5KTtOay7HIPmP4lSfjTEjngnri4I0EjMzAf/Eg/X85Sts2JgV/2gcSu02CEcmNM0omcMcMoS3HEvuE8rZ2Qg3YieXd9iySJ0xo4xjPqq5D2GpIIqjFGiHf+eGvJIRLFGBhZ9AxM3LfdRkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674667; c=relaxed/simple;
	bh=y3DelGi6YCys+qthA0tcQ2u9nH0QxpVueFqbzgzc0+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mButreNrv/u6TwifwArhOuEZSbuADMvvniolM0MPtBrF+S8thf0T8GiLzfXnUaw81HiCJDSR23VRUQ7uPIs2l+c/wQI7YB/zPCrowCkhtzA62ln9dGiLwqK3BbUtMvqVLrAAVSHCP3lMTYsJOP14CYNHJcI0kqowARTDCHcDp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S6qk9Sod; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S6qk9Sod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=R0
	r274GkxXLH1d2OcAvIB/rjlTMukuKN+QALwtCORFc=; b=S6qk9SodixlEpsw4vG
	FcSzW1r1y2SYn0g37RiOhWu6I+r6+AXAF3dIyvvOHsu/FsNvenFrBaviO6LuD7cm
	Any6Ufs+Sx8UmXq4+CWHXmItfQF54FPDFlF64+aZ8ns+S21S/dtB5gbx1yIu/X/i
	2EeOJlfcjT/s2B1DZQ1XK3Vps=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCnt5nKhrtqVp7nBQ--.16613S6;
	Tue, 29 Sep 2026 17:37:25 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v2 4/4] selftests: net: add TAP socket filter attach tests
Date: Tue, 29 Sep 2026 17:37:12 +0800
Message-Id: <20260929093712.131096-5-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929093712.131096-1-clementwei90@163.com>
References: <20260929093712.131096-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnt5nKhrtqVp7nBQ--.16613S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45XF47Gr1rKw1fur4kZwb_yoW7KFWDpF
	WkWayDGr15WF47W3Z7ArW8ZFWfXw4kGF15Ars5K3s8ZFs8Jr95uanakFyFy3W0qr48ZwnY
	kFya9a45Cws8XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2KZJUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hVgy2q7htXG7wAA33

From: Rongguang Wei <weirongguang@kylinos.cn>

reattach_filter_without_user_buffer() attaches a filter, makes the buffer
the program was copied from unreadable and then attaches the queue again,
which used to fail with -EFAULT.

attach_filter_bad_len_keeps_descriptor() checks that a rejected
TUNATTACHFILTER leaves both the saved descriptor and the installed filter
alone.

attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
ways to attach a queue without a filter.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 tools/testing/selftests/net/tun.c | 159 ++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index abe488bac50b..bf8d4d6f21f7 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -8,13 +8,19 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/filter.h>
 #include <linux/if_tun.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 
 #include "kselftest_harness.h"
 #include "tuntap_helpers.h"
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
 static const char param_dev_geneve_name[] = "geneve1";
 static unsigned char param_hwaddr_outer_dst[] = { 0x00, 0xfe, 0x98,
 						  0x14, 0x22, 0x42 };
@@ -542,6 +548,159 @@ TEST_F(tun, reattach_close_delete)
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+/* accept: return skb->len */
+static const struct sock_filter filter_accept[] = {
+	BPF_STMT(BPF_LD | BPF_W | BPF_LEN, 0),
+	BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0),
+	BPF_STMT(BPF_RET | BPF_A, 0),
+};
+
+/* drop: return 0 */
+static const struct sock_filter filter_drop[] = {
+	BPF_STMT(BPF_RET | BPF_K, 0),
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
+static int tap_get_iff(int fd, short *flags)
+{
+	struct ifreq ifr = { 0 };
+
+	if (ioctl(fd, TUNGETIFF, (void *)&ifr) < 0)
+		return -1;
+
+	*flags = ifr.ifr_flags;
+
+	return 0;
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
+	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
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
+	ASSERT_EQ(filter_attach(self->fd, filter_drop, ARRAY_SIZE(filter_drop)), 0);
+
+	fd = open("/dev/net/tun", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	strcpy(ifr.ifr_name, self->ifname);
+	ifr.ifr_flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NOFILTER;
+	EXPECT_GE(ioctl(fd, TUNSETIFF, (void *)&ifr), 0);
+
+	EXPECT_EQ(tap_get_iff(fd, &flags), 0);
+	EXPECT_NE(flags & IFF_NOFILTER, 0);
+
+	close(fd);
+}
+
+/* After TUNDETACHFILTER a later attach must not install the filter again */
+TEST_F(tun, detach_filter_clears_reattach)
+{
+	short flags = 0;
+
+	ASSERT_EQ(filter_attach(self->fd, filter_drop, ARRAY_SIZE(filter_drop)), 0);
+	EXPECT_EQ(ioctl(self->fd, TUNDETACHFILTER, 0), 0);
+
+	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
+	EXPECT_NE(flags & IFF_NOFILTER, 0);
+
+	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
+	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
+
+	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
+	EXPECT_NE(flags & IFF_NOFILTER, 0);
+}
+
+/* A TUNATTACHFILTER with a bad length must not clobber the saved descriptor */
+TEST_F(tun, attach_filter_bad_len_keeps_descriptor)
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
+	EXPECT_EQ(tap_get_iff(self->fd, &flags), 0);
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

