Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42796377A85
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009578; cv=none; b=YT7N/yDalG+s0z1UtLr+5obpE9ZlyDKfCK1M1wt8yyWp+UosGCN20z1T0OQTcW7NV9fo2W4gkqWKmIGqk1B8+rbgscNLXStluMZeqprxHBlR2GdcDnqwTxwflF2rEsYYyla1BEceLXCUw6vH7mDpfpSOIfps7SJVVxFcdKqrI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009578; c=relaxed/simple;
	bh=O3kvqQP4fqZBH3AAaB9eXwYPb4yAydFV3j5p22ev+uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W29Rf+s2mmWA6rNeqyaI0f7itIfZTEijKxzdbLln1IhmHfhk4U1yMdMrUVDK0RCQU1f48NvYmL7+Sc9k8EyraY/UAaJmMKNsbtSlpKeibFeSmDzrUSuh3AKa0mN2HoQP8txT6LDHL49eqebYFWbJxAmerFgOCwkUx300VEvLMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cocin9em; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cocin9em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yF
	YV95rbrutIZ6mWLe8+UMoy9CWZz4jXGXZTwzgT2gQ=; b=cocin9emrkAHlt+56h
	LHfe9XiOrGaM2uTMblf3dZo8V9TOY/mOhdWfVqivhU0VGEWZkQINomAGKwJUdY/L
	EbDywKh0dDxt6CZtVU770BOO6UseeAwo3mzHsAeUktQciwFXsoX9864TN8EYw6eB
	IiXVkdXtCwG9kBWlvVvimfYAY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXD0AEo8BqidfxCA--.46014S3;
	Sat, 03 Oct 2026 14:39:04 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v4 1/2] tun: keep a kernel copy of the socket filter program
Date: Sat,  3 Oct 2026 14:38:58 +0800
Message-Id: <20261003063859.136895-2-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261003063859.136895-1-clementwei90@163.com>
References: <20261003063859.136895-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXD0AEo8BqidfxCA--.46014S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyrZr48GFyUKFy5XrWfAFb_yoW3CrWrpF
	W5W3W5try5WF4xWwnxAFW8AF1aqw18Wa47ury8G34Y9F1qgr1ru3y2gryYvwnxArWUu3WS
	vw1jgr9xuw1DZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzlksUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-gi1IWrAowjvUQAA3d

From: Rongguang Wei <weirongguang@kylinos.cn>

TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
stays a pointer into the address space of the process that issued the
ioctl. tun_attach() reads it again whenever a queue is attached to the
persistent device later on.

Rebuilding the filter from that pointer is not reliable. With the inverted
check below, a failed read (-EFAULT for an unmapped address, -EINVAL for
bytes that are not a valid classic BPF program) was not fatal: for a new
tfile err is overwritten by "err = 0", so the queue was attached without a
filter. And when the read succeeded, the early return meant the queue was
never published at all.

Keep the program in the kernel instead: tun->fprog_kern holds the
instructions, and each queue gets its own program built from it with the
new sk_attach_filter_kern(), the kernel memory counterpart of
sk_attach_filter(). The copy is freed when the filter is detached or
replaced and with the device, and tun->fprog is left untouched so
TUNGETFILTER keeps its uapi behaviour.

Also fix the inverted check at the same time when tun_attach() returns
early when sk_attach_filter_kern() succeeds instead of when it fails.
Neither change works on its own: with only the kernel copy, every re-attach
returns 0 without publishing the queue; with only the check fixed, a
re-attach that used to succeed without installing a filter would start to
fail.

sk_attach_filter_kern() builds the program with bpf_prog_create(), which
does not keep an original program, so SO_GET_FILTER returns -EACCES and
sock_diag omits the filter for sockets that use it. tun sockets are not
exposed as file descriptors, so this is not user visible.

The inverted check was discovered by manual code inspection first [1], and
the review of v1 reported the other things.

[1] https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c      | 56 ++++++++++++++++++++++++++++++++++++++----
 include/linux/filter.h |  1 +
 net/core/filter.c      | 22 +++++++++++++++++
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..b58ad67b77ad 100644
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
@@ -722,12 +723,47 @@ static void tun_force_wake_queue(struct tun_struct *tun,
 	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
 }
 
+/* Copy the filter that @argp points at into the kernel, so that it can be
+ * installed again later, independent of the ioctl caller's address space.
+ * tun->fprog and tun->fprog_kern are updated only once the copy succeeded.
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
+	insns = kmalloc_array(fprog.len, sizeof(struct sock_filter),
+			      GFP_KERNEL_ACCOUNT);
+	if (!insns)
+		return -ENOMEM;
+
+	if (copy_from_user(insns, fprog.filter,
+			   fprog.len * sizeof(struct sock_filter))) {
+		kfree(insns);
+		return -EFAULT;
+	}
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
 {
 	struct tun_file *tfile = file->private_data;
 	struct net_device *dev = tun->dev;
+	bool rollback_filter = false;
 	int err;
 
 	err = security_tun_dev_attach(tfile->socket.sk, tun->security);
@@ -752,10 +788,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	/* Re-attach the filter to persist device */
 	if (!skip_filter && (tun->filter_attached == true)) {
 		lock_sock(tfile->socket.sk);
-		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
-		if (!err)
+		if (err)
 			goto out;
+		rollback_filter = true;
 	}
 
 	if (!tfile->detached &&
@@ -817,6 +854,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
 	tun_set_real_num_queues(tun);
 out:
+	if (err && rollback_filter) {
+		lock_sock(tfile->socket.sk);
+		sk_detach_filter(tfile->socket.sk);
+		release_sock(tfile->socket.sk);
+	}
 	return err;
 }
 
@@ -2397,6 +2439,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	kfree(tun->fprog_kern.filter);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3059,6 +3102,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
 		release_sock(tfile->socket.sk);
 	}
 
+	kfree(tun->fprog_kern.filter);
+	tun->fprog_kern.filter = NULL;
+	tun->fprog_kern.len = 0;
 	tun->filter_attached = false;
 }
 
@@ -3070,7 +3116,7 @@ static int tun_attach_filter(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
 		if (ret) {
 			tun_detach_filter(tun, i);
@@ -3418,8 +3464,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = -EFAULT;
-		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
+		ret = tun_copy_filter(tun, argp);
+		if (ret)
 			break;
 
 		ret = tun_attach_filter(tun);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc73..0de5a738fb26 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1218,6 +1218,7 @@ int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
 void bpf_prog_destroy(struct bpf_prog *fp);
 
 int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
+int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk);
 int sk_attach_bpf(u32 ufd, struct sock *sk);
 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..64d6505a4ef2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1567,6 +1567,28 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_attach_filter);
 
+int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
+{
+	struct bpf_prog *prog;
+	int err;
+
+	if (sock_flag(sk, SOCK_FILTER_LOCKED))
+		return -EPERM;
+
+	err = bpf_prog_create(&prog, fprog);
+	if (err)
+		return err;
+
+	err = __sk_attach_prog(prog, sk);
+	if (err < 0) {
+		__bpf_prog_release(prog);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sk_attach_filter_kern);
+
 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 {
 	struct bpf_prog *prog = __get_filter(fprog, sk);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

