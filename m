Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693292DB789
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755695; cv=none; b=sjPUJVJ78Er45OEcjZHxoi5WwjWK2Lt5DwDIx/xThj/8VbDhb+75QhrnfocBPWyltXQCGmEfsxA26l1QJGMfh7h7NMsHOPCKEcC/MbzVVWxQe8J6zPXzDoCQrajbqoQse4LuniP8nkiaqa2lTXP2vjajm7oVF9vzqplfDWcZegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755695; c=relaxed/simple;
	bh=N2iopIczYmdLRsir/FxapApxrKkQCX/Eh1eRGThO2To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPmdb5wDl89svf+9Num78RbbsZEUruqZfc7O9iyRyDMDgcVfjnChct6o5/c9x5Mc04Y1JHyVoUsPblYAsCXRodTkd8fPdDSeJfk6BTgAbmsmL15hje1x3Bo6+lsiCsUGk6DcWMYkzLA58vbwzP/LHhDN7BIW5zf1YyAPUM6z/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WyBvWC/+; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WyBvWC/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Qk
	bJMflO4AzyeDXhB1zRNlm8/EWazIgSHOT8idCTm8E=; b=WyBvWC/+iaOn8W4Yd0
	2lL89vbs0X0XfkbQ3Xs2FZ4dU54GSE3GP3Q66OR4T7cAla8i1O+3xZIFxZhCWMHv
	ysA2UsMFPenu99Qv72v5YNe4QckSIS5htHQ0DGGCRcih5LQaG6dx5PJBzGqkdb5B
	8Z83/Y8uku0wXQa1ONpz1KMAo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnNiBTw7xqRdh1Bw--.20247S3;
	Wed, 30 Sep 2026 16:07:51 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v3 1/3] tun: keep a kernel copy of the socket filter program
Date: Wed, 30 Sep 2026 16:07:44 +0800
Message-Id: <20260930080746.135017-2-clementwei90@163.com>
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
X-CM-TRANSID:PCgvCgBnNiBTw7xqRdh1Bw--.20247S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFyrZr4fKr17JrykCr13CFg_yoWxGr47pF
	W5W3W5try5WFW2gwnIyFW0yF1aq3W8WFy7ury8G34Y9F1qgr18u3y2gFyYywn8ArWUu3Wf
	Zw1jgr9xWw1kWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzlksUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4hfPO2q8w1cekgAA3P

From: Rongguang Wei <weirongguang@kylinos.cn>

TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
stays a pointer into the address space of the process that issued the
ioctl. tun_attach() reads it again whenever a queue is attached to the
persistent device later on: unmapped there, the attach fails with -EFAULT;
mapped, whatever bytes it holds become the filter of the new queue.

Keep the program in the kernel instead. tun->fprog_kern holds the
instructions and each queue gets its own program, built with
sk_attach_filter_kern().

sk_attach_filter_kern() reads no user buffer and attaches the program like
sk_attach_filter() does. The caller must hold the socket lock. Failing the
attach releases it; so does the socket when the filter is replaced,
detached or the socket goes away.

The copy is freed when the filter is detached or replaced and with the
device, and tun->fprog is left untouched so TUNGETFILTER keeps its uapi
behaviour.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c      | 41 +++++++++++++++++++++++++++++++++++++----
 include/linux/filter.h |  1 +
 net/core/filter.c      | 22 ++++++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..22fb34e745bd 100644
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
@@ -752,7 +781,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	/* Re-attach the filter to persist device */
 	if (!skip_filter && (tun->filter_attached == true)) {
 		lock_sock(tfile->socket.sk);
-		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
 		if (!err)
 			goto out;
@@ -2397,6 +2426,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	kfree(tun->fprog_kern.filter);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3059,6 +3089,9 @@ static void tun_detach_filter(struct tun_struct *tun, int n)
 		release_sock(tfile->socket.sk);
 	}
 
+	kfree(tun->fprog_kern.filter);
+	tun->fprog_kern.filter = NULL;
+	tun->fprog_kern.len = 0;
 	tun->filter_attached = false;
 }
 
@@ -3070,7 +3103,7 @@ static int tun_attach_filter(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		lock_sock(tfile->socket.sk);
-		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
+		ret = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
 		if (ret) {
 			tun_detach_filter(tun, i);
@@ -3418,8 +3451,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
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

