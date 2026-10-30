Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340080;
	b=PiITks8FkMrFx5rSejVkaRfqFpcSxHXVFCOZ6KDs60g+0I4XhtdjnIojJt52Jt/9FFhD
	 aJqe0eW2KM/Gy+M+V2s04AXo8VX8P+BHUqXwP5Fnq35UeZF8Dps4lfr9avjOONF+i17Az
	 AsC9ZPtLGGgtrJyLBNyj4KFNm6KMAzH4GdfvDXYPq3KdR9leu6chc2ZlGF4bYfZ6dpYbe
	 pII97HVrYYuUR4qB4jchKdt2VkHxW8FwtqTAiQOXBHzW+dcSTRm7C03JLzS/2XFCfyZtW
	 wHR/lm4fVgYveKaNrv/sJq2DvIqw0v/QzuGfBsr9PWab4sc82SPo5v+Sy61m7YARz1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340080;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=itJw9ol23Tlq/phK/3FkkRmnXJEZMGbbTmigyD4fX4o=;
	b=oGDQEPmhitqrIeZTljd5XbsFX1wkhasSFDODQqHS01LuiafJW9MH3t3i0pKoCRwAW7CU
	 cmhWsTRxV5ajVBx1QBiYKK2xSCNAvYuZGhGm8yC7vsRD5g6TKCd1A47+4jeWgVSmABG0M
	 8yMR/M9wK3l27s81Iw3YedEk5j8aimmWu68JlmIrCYWzJkMQjcrtwEfvTkf/ioPI9NekI
	 PN0IbstryGteS14a/NKA408gROCsy+BjThoxcqbotSCo8QB7VmqRBamKXhb0DT7qzVabH
	 /NwJY6f3zft7rbGyuvmdQoYlvaOH8paO0pXVe+giioeZ41QCBDeAplgpUnVyuF6FkAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bAwZyi4d;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C151606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C151606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bAwZyi4d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=it
	Jw9ol23Tlq/phK/3FkkRmnXJEZMGbbTmigyD4fX4o=; b=bAwZyi4dmVJh1KGHK7
	vzXqdM23UxDRCCMEGGd3kc5CsJ4dn+m3HGVQHJJ1qX7jMsecQIqC8FMdpGJnuK09
	CEOV4K1fEzlJqt4sErjhNsB+8AFMfPh23790J1qE+iAnZec3tXurOmKBKy4KTmy+
	AmHHyAzZTszj6qjDQUsvzS6ek=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXb1WNMuRq0UhWEA--.43024S3;
	Fri, 30 Oct 2026 14:00:48 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v9 1/2] tun: keep a kernel copy of the socket filter program
Date: Fri, 30 Oct 2026 14:00:42 +0800
Message-Id: <20261030060043.94719-2-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030060043.94719-1-clementwei90@163.com>
References: <20261030060043.94719-1-clementwei90@163.com>
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
X-CM-TRANSID:_____wDXb1WNMuRq0UhWEA--.43024S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3trW7Zw45Zw17XFy8JF43Jrb_yoW8Gr4fZo
	WfXrZxXw1UJrWxG3yjvF1fGF17Z3srKrW7JFW5Wrs8Xay7t3yUGa95J3y3Xa4jqF1FqF4D
	WasrJw4ayrWDtFyfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4_HUUUUUU
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-hCE72rkMpCNbAAA3I

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
anything is replaced: a TUNATTACHFILTER that the classic verifier rejects
now fails early and leaves the previously attached filter in place.  The
instructions are verified with the new bpf_prog_validate_classic(), which
runs bpf_check_basics_ok() and bpf_check_classic() on the copied program.
That does not cover the s16 check in bpf_convert_filter() or the runtime
selection in bpf_prog_select_runtime(), so a program can still be refused
when it is built for a queue. Such a late failure does not replace the
saved program: the copy is committed to tun->fprog and tun->fprog_kern
only after tun_attach_filter() installed it on every queue. A queue that
already took the copy is rolled back, which leaves it without a filter,
because the program it ran before was already released; restoring it
would need an extra reference per queue.

The inverted check was discovered by manual code inspection first.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c      | 127 +++++++++++++++++++++++++++++++++++++----
 include/linux/filter.h |   2 +
 net/core/filter.c      |  67 ++++++++++++++++++++++
 3 files changed, 184 insertions(+), 12 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 439565a264ee..c121ad50f31b 100644
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
@@ -726,12 +727,69 @@ static void tun_force_wake_queue(struct tun_struct *tun,
 	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
 }
 
+/* Copy the filter that @argp points at into the kernel, so that it can be
+ * installed again later, independent of the ioctl caller's address space.
+ * @fprog_kern receives the copy, which belongs to the caller until it is
+ * installed or freed, and @fprog receives the header, with the user pointer
+ * kept for TUNGETFILTER.
+ */
+static int tun_copy_filter(struct sock_fprog __user *argp,
+			   struct sock_fprog *fprog,
+			   struct sock_fprog_kern *fprog_kern)
+{
+	struct sock_fprog fp;
+	struct sock_filter *insns;
+	int err;
+
+	if (copy_from_user(&fp, argp, sizeof(fp)))
+		return -EFAULT;
+
+	if (!fp.len || fp.len > BPF_MAXINSNS)
+		return -EINVAL;
+
+	insns = kmalloc_array(fp.len, sizeof(struct sock_filter),
+			      GFP_KERNEL_ACCOUNT);
+	if (!insns)
+		return -ENOMEM;
+
+	if (copy_from_user(insns, fp.filter,
+			   fp.len * sizeof(struct sock_filter))) {
+		kfree(insns);
+		return -EFAULT;
+	}
+
+	/* The instructions are only verified when a program is built from
+	 * them, which happens when the filter is attached to a socket. Run
+	 * the classic verifier here as well, so that a bad program is
+	 * refused before it is saved and before any queue is touched.
+	 * bpf_prog_create() can still refuse the program later, when it is
+	 * converted to eBPF or when no runtime can be selected for it; the
+	 * attach path returns that error, and the saved program is not
+	 * replaced.
+	 */
+	err = bpf_prog_validate_classic(insns, fp.len);
+	if (err) {
+		kfree(insns);
+		return err;
+	}
+
+	/* Zero the whole header before filling it in. */
+	memset(fprog, 0, sizeof(*fprog));
+	fprog->len = fp.len;
+	fprog->filter = fp.filter;
+	fprog_kern->len = fp.len;
+	fprog_kern->filter = insns;
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
@@ -756,10 +814,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
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
@@ -821,6 +880,17 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
 	tun_set_real_num_queues(tun);
 out:
+	if (err && rollback_filter) {
+		/* The filter was installed before the rest of the attach
+		 * ran, so drop it again if a later step failed. Any
+		 * program it replaced is already gone: this leaves the
+		 * queue without a filter rather than restoring the
+		 * previous one.
+		 */
+		lock_sock(tfile->socket.sk);
+		sk_detach_filter(tfile->socket.sk);
+		release_sock(tfile->socket.sk);
+	}
 	return err;
 }
 
@@ -2406,6 +2476,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	kfree(tun->fprog_kern.filter);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3070,10 +3141,14 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
 		release_sock(tfile->socket.sk);
 	}
 
+	kfree(tun->fprog_kern.filter);
+	tun->fprog_kern.filter = NULL;
+	tun->fprog_kern.len = 0;
 	tun->filter_attached = false;
 }
 
-static int tun_attach_filter(struct tun_struct *tun)
+static int tun_attach_filter(struct tun_struct *tun,
+			     struct sock_fprog_kern *fprog_kern)
 {
 	int i, ret = 0;
 	struct tun_file *tfile;
@@ -3081,15 +3156,29 @@ static int tun_attach_filter(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		ret = sk_attach_filter_kern(fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
-		if (ret) {
-			tun_detach_filter(tun, i);
-			return ret;
-		}
+		if (ret)
+			goto out_detach;
 	}
 
 	tun->filter_attached = true;
+	return 0;
+
+out_detach:
+	/* Drop the copies already installed on queues 0..i-1, which leaves
+	 * them without a filter: their previous sk_filter, if any, was
+	 * already replaced and released. The caller does not replace the
+	 * saved program when this fails, so tun->fprog, tun->fprog_kern and
+	 * filter_attached keep their previous values.
+	 */
+	while (i--) {
+		tfile = rtnl_dereference(tun->tfiles[i]);
+		lock_sock(tfile->socket.sk);
+		sk_detach_filter(tfile->socket.sk);
+		release_sock(tfile->socket.sk);
+	}
+
 	return ret;
 }
 
@@ -3424,17 +3513,31 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		tun_set_sndbuf(tun);
 		break;
 
-	case TUNATTACHFILTER:
+	case TUNATTACHFILTER: {
+		struct sock_fprog_kern fprog_kern;
+		struct sock_fprog fprog;
+
 		/* Can be set only for TAPs */
 		ret = -EINVAL;
 		if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 			break;
-		ret = -EFAULT;
-		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
+
+		ret = tun_copy_filter(argp, &fprog, &fprog_kern);
+		if (ret)
+			break;
+
+		ret = tun_attach_filter(tun, &fprog_kern);
+		if (ret) {
+			kfree(fprog_kern.filter);
 			break;
+		}
 
-		ret = tun_attach_filter(tun);
+		/* Install the copy only after every queue accepted it. */
+		kfree(tun->fprog_kern.filter);
+		tun->fprog_kern = fprog_kern;
+		tun->fprog = fprog;
 		break;
+	}
 
 	case TUNDETACHFILTER:
 		/* Can be set only for TAPs */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0218e677a1d..7169c03610b4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1257,8 +1257,10 @@ int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog);
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
index b7ac145b68b1..61b2d223c445 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1476,6 +1476,32 @@ void bpf_prog_destroy(struct bpf_prog *fp)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_destroy);
 
+/**
+ * bpf_prog_validate_classic - run the classic BPF verifier on kernel memory
+ * @insns: instruction array
+ * @len: number of instructions in @insns
+ *
+ * Run bpf_check_basics_ok() and bpf_check_classic() on a program that is
+ * already in kernel memory, without building a struct bpf_prog.  These are
+ * the checks bpf_prog_create() runs before it converts the program, so
+ * callers can reject a bad program when it is configured instead of when it
+ * is first attached to a socket.
+ *
+ * A program that passes here can still be refused by bpf_prog_create(), when
+ * it is converted to eBPF or when no runtime can be selected for it.
+ *
+ * Return: 0 if the program passes the classic verifier, -EINVAL if it does
+ * not, or -ENOMEM if the verifier cannot allocate its state.
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
@@ -1567,6 +1593,47 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
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

