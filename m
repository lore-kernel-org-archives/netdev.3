Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747390;
	b=WNrX3/sfxj89qJrbScfPQthRd/4ZX8hkinopJL/sZU3b0NN8IrJ/QEdv2cB5Dw/QqpIB
	 xe7Qs574AeOWt4OhwycrGojuCg1rnigFHRjNat3b9vQ7flVuSklK9GORXu6euB1/pYxOq
	 tshdLyN4pYbbpmnpwrkQtu4tWpBXfO9TihfcufQ5MblR2yW2ylQf2hbNO3L6FYTOtniay
	 ALgNyzmRPGweBddmlOVgB3eVOzV5JKzXH1wn8yY7U7X5smGRG16ZcDgWFundXXco0seLm
	 NDqgoudlMtUdiDPlJHeYOsFo3clzgiHzZpJ/JouBFkZ+i+hxZKXZl8NJxWt/6razhQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747390;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=3+CegWp7fm9XPs/3uw1Onj6vthdyT4js06jqAlbfUSc=;
	b=fMursF70AU/6vyMkY//r/jzg97u9NGuVoLwtYix7kdyAYRmLSvTkq46DVFnXotsVeJKr
	 qWGck+wx4ltsZkJi8raY60FZjyS7gfR4HTBQd3TEe0hpg7i+EaZrIZeC0pGCaJYc5Yx4x
	 9uAkD3PifJcXzpqb5FUiyJY+0dSCaRhc8wD33e753ogPnWg3BiDOdLFyRH1VyRCQLUAlr
	 rfWJjMTq3Kokjrlvh4u+ySFiJZu/xaeMquWNrmVMuoNwXTvaKUGSiHOb3TzPU4RZfwIgj
	 5vQgF65o/MVvv5RdefxmeKC2qdKexqznbZaOZ2XdK8qo2p1W/dY6wgpQRXRRDZYnvRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CYtj5Iph;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195F606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9195F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CYtj5Iph
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3+
	CegWp7fm9XPs/3uw1Onj6vthdyT4js06jqAlbfUSc=; b=CYtj5IphwZ/JRFMwdC
	XP8t9dANvDeAZOIQg2UhJySUjaUlwrQeUKy5KKWx8eIutt5UZFe2UgNWBJJw/kf0
	nDc0yCqgi8IaWT2ClCXyCvNmnp8PNvUmeslQtxC0KKW+mWalanVa1Rc3DldNrirN
	V3Aaq0+ZoDUzr0t/hbzFmJaAA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHL7xgJ9tqkyFtCQ--.53366S3;
	Fri, 23 Oct 2026 17:22:43 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v7 1/2] tun: keep a kernel copy of the socket filter program
Date: Fri, 23 Oct 2026 17:22:38 +0800
Message-Id: <20261023092239.186665-2-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261023092239.186665-1-clementwei90@163.com>
References: <20261023092239.186665-1-clementwei90@163.com>
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
X-CM-TRANSID:_____wDHL7xgJ9tqkyFtCQ--.53366S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3trW7Zw4rAFWkKF17AFW8JFb_yoWkArW5pF
	W5Wa45tr1UWF48WwnxAay8AF1aq3WkWF1Uur95G34Y9F4qgr1093yjgFyYvrnxArZ8u3Wf
	Z3WjgF9ruw1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzlksUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4QR032rbJ2SO7wAA3d

From: Rongguang Wei <weirongguang@kylinos.cn>

TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
stays a pointer into the address space of the process that issued the
ioctl. tun_attach() reads it again whenever a queue is attached to the
persistent device later on.

Rebuilding the filter from that pointer is not reliable. With the inverted
check below, a failure of the attach was not fatal: -EFAULT for an unmapped
address, -EINVAL for bytes that are not a valid classic BPF program, -EPERM
for a locked filter and -ENOMEM all ended up in "err = 0" for a new tfile,
so the queue was attached without a filter. And when the read succeeded,
the early return meant the queue was never published at all.

Keep the program in the kernel instead: tun->fprog_kern holds the
instructions, and each queue gets its own program built from it with the
new sk_attach_filter_kern(), the kernel memory counterpart of
sk_attach_filter(). The copy is freed when the filter is detached or
replaced and with the device, and tun->fprog is left untouched so
TUNGETFILTER keeps its uapi behaviour.

Also fix the inverted check, which made tun_attach() return early when
sk_attach_filter_kern() succeeded instead of when it failed. Neither change
works on its own: with only the kernel copy, every re-attach returns 0
without publishing the queue; with only the check fixed, a re-attach that
used to succeed without installing a filter would start to fail.

sk_attach_filter_kern() builds the program with bpf_prog_create(), which
does not keep an original program, so SO_GET_FILTER returns -EACCES and
sock_diag omits the filter for sockets that use it. tun sockets are not
exposed as file descriptors, so this is not user visible.

The header and the instructions are checked in tun_copy_filter() before
anything is replaced: a TUNATTACHFILTER that no verifier would accept now
fails early and leaves the previously attached filter in place.  The
instructions are verified with the new bpf_prog_validate_classic(), which
runs the same checks as bpf_prog_create() on the copied program.  Before
this series the check only happened per queue in tun_attach_filter(),
which never ran when no queue was attached, so an invalid program could be
stored; with the corrected error check, every later attach of such a
program would then fail with -EINVAL.

The inverted check was discovered by manual code inspection first, and the
review of v1 reported the other things.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c      | 76 +++++++++++++++++++++++++++++++++++++++---
 include/linux/filter.h |  2 ++
 net/core/filter.c      | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd071..e7d9f4480a89f 100644
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
@@ -722,12 +723,61 @@ static void tun_force_wake_queue(struct tun_struct *tun,
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
+	int err;
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
+	/* The instructions are only verified when a program is built from
+	 * them, which tun_attach_filter() does once per attached queue.
+	 * Check them here as well: with no queue attached that would not
+	 * happen at all, and, now that tun_attach() treats that error as
+	 * fatal, every later attach would fail with -EINVAL instead of
+	 * rejecting the program now.
+	 */
+	err = bpf_prog_validate_classic(insns, fprog.len);
+	if (err) {
+		kfree(insns);
+		return err;
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
@@ -752,10 +802,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
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
@@ -817,6 +868,17 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
 	tun_set_real_num_queues(tun);
 out:
+	if (err && rollback_filter) {
+		/* The filter was installed before the rest of the attach
+		 * ran, so drop it again if a later step failed.  The
+		 * program it replaced is already gone: this leaves the
+		 * queue without a filter rather than restoring the
+		 * previous one.  Best effort, the filter may be locked.
+		 */
+		lock_sock(tfile->socket.sk);
+		sk_detach_filter(tfile->socket.sk);
+		release_sock(tfile->socket.sk);
+	}
 	return err;
 }
 
@@ -2400,6 +2462,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	kfree(tun->fprog_kern.filter);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3064,6 +3127,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
 		release_sock(tfile->socket.sk);
 	}
 
+	kfree(tun->fprog_kern.filter);
+	tun->fprog_kern.filter = NULL;
+	tun->fprog_kern.len = 0;
 	tun->filter_attached = false;
 }
 
@@ -3075,7 +3141,7 @@ static int tun_attach_filter(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
 		if (ret) {
 			tun_detach_filter(tun, i);
@@ -3423,8 +3489,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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
index 39decde7fc730..e6f8506de3e2f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1216,8 +1216,10 @@ int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog);
 int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
 			      bpf_aux_classic_check_t trans, bool save_orig);
 void bpf_prog_destroy(struct bpf_prog *fp);
+int bpf_prog_validate_classic(const struct sock_filter *insns, unsigned int len);
 
 int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
+int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk);
 int sk_attach_bpf(u32 ufd, struct sock *sk);
 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2e..bcc7906353fef 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1476,6 +1476,27 @@ void bpf_prog_destroy(struct bpf_prog *fp)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_destroy);
 
+/**
+ * bpf_prog_validate_classic - verify a classic BPF program in kernel memory
+ * @insns: instruction array
+ * @len: number of instructions in @insns
+ *
+ * Run the same checks that bpf_prog_create() performs on a classic BPF
+ * program, without allocating a struct bpf_prog.  Callers that already hold
+ * the instructions in kernel memory can use this to reject a program when it
+ * is configured instead of when it is attached to a socket.
+ *
+ * Return: 0 if the program is valid, otherwise -EINVAL.
+ */
+int bpf_prog_validate_classic(const struct sock_filter *insns, unsigned int len)
+{
+	if (!bpf_check_basics_ok(insns, len))
+		return -EINVAL;
+
+	return bpf_check_classic(insns, len);
+}
+EXPORT_SYMBOL_GPL(bpf_prog_validate_classic);
+
 static int __sk_attach_prog(struct bpf_prog *prog, struct sock *sk)
 {
 	struct sk_filter *fp, *old_fp;
@@ -1567,6 +1588,47 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
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
+ * copy of the instructions, so sk_get_filter() returns -EACCES and sock_diag
+ * omits the filter for a socket that uses this helper.
+ *
+ * Return: 0 on success, or a negative errno: -EPERM if @sk has
+ * SOCK_FILTER_LOCKED set, otherwise whatever bpf_prog_create() or
+ * __sk_attach_prog() returned (for example -EINVAL for an invalid classic
+ * BPF program, -ENOMEM, or -ENOTSUPP when a JIT is required but is not
+ * available).
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
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

