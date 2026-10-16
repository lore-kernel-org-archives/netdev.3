Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357A37C10A
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134447; cv=none; b=UaU/V6PWFJXZpC2t/n2np+/J8H4zWKXV9Hd6RppXR8+FY0+8BcWL4UYawKXyiAs9MuQkBabMT3w0yjtHDg041gv+ymHhPqSmN76WBrTV84jxlctG3w277fJGhjq3ZCBVC/QjFNOz3MQtn1z19A/rXHeREQRuO8m1FrVDs9q9cm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134447; c=relaxed/simple;
	bh=s3jOmqMmJ9mPUqwoOG2UcnLvjSOVxcoJDBWGv8Sv8iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVROTUw61Sd+PRXfa7EZWS1alBRfKdtbvSyX2ReKJ40TfMB8EjcN/atI11ugL4fxzn0DhFGWDoibeswdBDV/4Dvz11+KK3IEBUX4zOx+6sXaRJ2oTJqv3tc1yhMu6+26PGroCf2lvfxAuUUHQFEg0wyM5ndEJ+QsIagGGC4UKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WI46yk8W; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WI46yk8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1K
	z+6RIMybjxRieb/Rge1STSnOj9kI531qPQnv+gqcA=; b=WI46yk8WKIR2w+S8K/
	zOJhOdENcY+L+NN6+6Y9VspCzyzA+JspIXLT8BvqS5l1jMR5NqW1AHh5NL0cJOrh
	gherNglBq2yqb9aXZ+18lwDG8bR8LRKaevVkHeaTEMxR8VMe8jhif1d1NzDkkVPn
	KIJ7N4Rn6LeURTGzRW+B7wHpM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnr7wPzdFqoTHrAQ--.20287S3;
	Fri, 16 Oct 2026 15:06:58 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v6 1/2] tun: keep a kernel copy of the socket filter program
Date: Fri, 16 Oct 2026 15:06:53 +0800
Message-Id: <20261016070654.170932-2-clementwei90@163.com>
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
X-CM-TRANSID:_____wDnr7wPzdFqoTHrAQ--.20287S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyrZr48GFyUKFy5XrWfAFb_yoWfZrWxpF
	W5W3W5tr15WF4xWwnxAFW0yF1aqw18Wa47ury8G34Y9F1qgr1ru3y2gryYvwnxArWUu3Wf
	Zw1jgr9ruw1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVpB-UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hKG8WrRzRIbAQAA35

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

Because the length is checked in tun_copy_filter() before anything is
replaced, a TUNATTACHFILTER with a bad header now fails early and leaves
the previously attached filter in place; before this series the failure
happened on queue 0 and cleared filter_attached.

The inverted check was discovered by manual code inspection first [1], and
the review of v1 reported the other things.

[1] https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c      | 56 ++++++++++++++++++++++++++++++++++++++----
 include/linux/filter.h |  1 +
 net/core/filter.c      | 41 +++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd07..e493c4554d5d 100644
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
 
@@ -2400,6 +2442,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	kfree(tun->fprog_kern.filter);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3064,6 +3107,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
 		release_sock(tfile->socket.sk);
 	}
 
+	kfree(tun->fprog_kern.filter);
+	tun->fprog_kern.filter = NULL;
+	tun->fprog_kern.len = 0;
 	tun->filter_attached = false;
 }
 
@@ -3075,7 +3121,7 @@ static int tun_attach_filter(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
 		if (ret) {
 			tun_detach_filter(tun, i);
@@ -3423,8 +3469,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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
index 70dc621672f2..57bef64b72bc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1567,6 +1567,47 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_attach_filter);
 
+/**
+ * sk_attach_filter_kern - attach a classic BPF filter held in kernel memory
+ * @fprog: program to attach, with @fprog->filter pointing at kernel memory
+ * @sk: socket to attach the filter to
+ *
+ * Attach a copy of a classic BPF program that the kernel already holds, the
+ * way sk_attach_filter() does for one that still lives in user space. The
+ * caller must hold the socket lock; SOCK_FILTER_LOCKED is checked here.
+ *
+ * The program is built by bpf_prog_create(), which does not keep an original
+ * copy of the instructions. sk_get_filter() therefore returns -EACCES and
+ * sock_diag leaves the filter out for a socket that uses this helper. A
+ * classic BPF program cannot be duplicated with bpf_prog_copy(), so keeping
+ * the original would cost another allocation and a copy per attach.
+ *
+ * Return: 0 on success, -EPERM if @sk has SOCK_FILTER_LOCKED set, -EINVAL if
+ * the instructions are not a valid classic BPF program, and -ENOMEM on an
+ * allocation failure.
+ */
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

