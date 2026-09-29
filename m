Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F564E1C92
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674665; cv=none; b=uk7taCindyYzIP88JamjjXMLO2sy+AN1pz3t3xB6bW224fZ8g1ABOA8a4xD1okqwWpPYUauDQR/2YOuwzl0VT5EHvi9V0Jv0y2Yng1BGOVTZi7FQoHaHHUyzW+X4pqCbc3I7JStOrwQ6Jq0n0OzFZdPxgStG20MgfHWMiBT1ocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674665; c=relaxed/simple;
	bh=uquniDTlFBY46BSowUUiptFwJRne4EKlMoFoLA9j+Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuT5HZu7vKgPiJs5Uj6R2bteqvbNoeH7rdZzfqZy12VAdeLd6uTxvlxivZHosnbGi91U9OkY84H5EY61+J/7iXOrY8ero1zyEM5/uysZOF+WRgB16WixNNCd2O9q8CqWQ7ofnKQXSgsNgtrWvdtFQWShaqBx7jPBvRobk5+ekLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZVmI/jyB; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZVmI/jyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ov
	NTVKHUKqJnjyx+by30O9loGtNYvsb7nP3hKQlsX68=; b=ZVmI/jyBExRRjlQzEP
	hYDy+Ty5EI+Go9X9S/mBAiE4dY4pgimzg10WylTz7GwcRo0JD2+gJBnysP3uP0bK
	JRHKIJxrDoxVbBbkCyh8sg+82pekr3tsCqXwRrO+43ZWBsY2MlKSNqojJKcO+Z79
	JIYgrsZgFLxA7fR0Z9w9mhTpE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCnt5nKhrtqVp7nBQ--.16613S5;
	Tue, 29 Sep 2026 17:37:21 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v2 3/4] tun: keep a kernel copy of the socket filter program
Date: Tue, 29 Sep 2026 17:37:11 +0800
Message-Id: <20260929093712.131096-4-clementwei90@163.com>
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
X-CM-TRANSID:_____wCnt5nKhrtqVp7nBQ--.16613S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxury8AFWrZFyrWr4DCFW8Crg_yoWrCFWfpF
	W5G3W5trW3WF1Igws0yFW0kFyaqw1Ig34xury8G345uF1qgr18Gay2gry5Zwn8AFW8uF4f
	Zw12gr9xWw1kJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jd5rcUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hFfymq7htHGrAAA3K

From: Rongguang Wei <weirongguang@kylinos.cn>

TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
stays a pointer into the address space of the process that issued the
ioctl. tun_attach() reads it again whenever a queue is attached to the
persistent device later on: unmapped there, the attach fails with -EFAULT;
mapped, whatever bytes it holds become the filter of the new queue.

Keep the program in the kernel instead. tun->fprog_kern holds the
instructions and each queue gets its own program, built with
sk_attach_filter_kern().

The copy is freed when the filter is detached or replaced and with the
device, and tun->fprog is left untouched so TUNGETFILTER keeps its uapi
behaviour.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a2fffef3735f..c796048742f9 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -197,6 +197,7 @@ struct tun_struct {
 	int			sndbuf;
 	struct tap_filter	txflt;
 	struct sock_fprog	fprog;
+	struct sock_fprog_kern	fprog_kern;
 	/* protected by rtnl lock */
 	bool			filter_attached;
 	u32			msg_enable;
@@ -722,6 +723,34 @@ static void tun_force_wake_queue(struct tun_struct *tun,
 	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
 }
 
+/* Copy the filter that @argp points at into the kernel, so that it can be
+ * installed again later, from any context. tun->fprog and tun->fprog_kern
+ * are updated only once the copy succeeded.
+ */
+static int tun_copy_filter(struct tun_struct *tun, struct sock_fprog __user *argp)
+{
+	struct sock_fprog fprog;
+	struct sock_filter *insns;
+
+	if (copy_from_user(&fprog, argp, sizeof(fprog)))
+		return -EFAULT;
+
+	if (!fprog.len || fprog.len > BPF_MAXINSNS)
+		return -EINVAL;
+
+	insns = memdup_array_user(fprog.filter, fprog.len,
+				  sizeof(struct sock_filter));
+	if (IS_ERR(insns))
+		return PTR_ERR(insns);
+
+	kfree(tun->fprog_kern.filter);
+	tun->fprog_kern.len = fprog.len;
+	tun->fprog_kern.filter = insns;
+	tun->fprog = fprog;
+
+	return 0;
+}
+
 static int tun_attach(struct tun_struct *tun, struct file *file,
 		      bool skip_filter, bool napi, bool napi_frags,
 		      bool publish_tun)
@@ -753,7 +782,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	/* Re-attach the filter to persist device */
 	if (!skip_filter && (tun->filter_attached == true)) {
 		lock_sock(tfile->socket.sk);
-		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
 		if (err)
 			goto out;
@@ -2404,6 +2433,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	kfree(tun->fprog_kern.filter);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3066,6 +3096,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
 		release_sock(tfile->socket.sk);
 	}
 
+	kfree(tun->fprog_kern.filter);
+	tun->fprog_kern.filter = NULL;
+	tun->fprog_kern.len = 0;
 	tun->filter_attached = false;
 }
 
@@ -3077,7 +3110,7 @@ static int tun_attach_filter(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
 		if (ret) {
 			tun_detach_filter(tun, i);
@@ -3425,8 +3458,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = -EFAULT;
-		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
+		ret = tun_copy_filter(tun, argp);
+		if (ret)
 			break;
 
 		ret = tun_attach_filter(tun);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

