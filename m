Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F50396565
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440394; cv=none; b=UAUObvLwjreNxg1us1Pv/wtgEMrqGudYsv2WwN6nTHXGStEQXSBdzAca249zucY83jWC+QUTvklMjTbJrhlu7VGtnAiIB9PBPwjoUQE59SrnnUbZAnm5HLnzTQWWj4rz0ljwOtYXxnrBJ6FxJKFUCQSQEG/rrSxL60p2i/+PuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440394; c=relaxed/simple;
	bh=sE/ynAaMMJdq+vLTCmEECvtUeWlMjjQg9MjzH+6sbSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzZ7ihckr4FQXBn+2dJuKgxqpqFVQ5JwlVSxrq04YFoqMKsR7bZL22T835uI95n1qnsGh0HdVOjy6gbsczWxTHzyDR76HWJxdPbvTTU98/RUyZUszP5unYpu+OeHNdzzIiUUYDJ+qUkLNe8mkpL1vn8SojWkuIWI/2HxSqkCFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QzB7SBcO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QzB7SBcO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so2282053a91.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789440393; x=1790045193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BkxGdou5bXZ13SdRZf9iAbEUZvMc1uC5h9uZbP/Uu8=;
        b=QzB7SBcOLtdcn6NX+bn9fZv5ZvZw6XJElqWowYAQXM463D6d5OzQEXvLgmGtZdpfuK
         iJFXa7V4q1zyovWtQqjZjlPwrChfAsoFo6xq4uYdPa//Y+tepTRQp1ufUZU/c06WuE8W
         y738vpZv3l/MNKhMY9c41Ll9GVQRdPUUlAuSR88gTdOeglnfzb2xFCW4LxYtLmTKre/A
         b2DcHTdzxWlkaPuxkBHDHyfsZr5jlKVHzo84HPeJwIJo4Z6bcPq3K4dOjPWHV1aOAYoF
         9U9BxfFrTnXl1+F5FTUmzPYKbXz79Z4+P8WN3hQDXuAQHB2bYH5w/dFwowcQV9i3ImO2
         tdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789440393; x=1790045193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3BkxGdou5bXZ13SdRZf9iAbEUZvMc1uC5h9uZbP/Uu8=;
        b=NCSeYSfDEKHUn97k6NmYUtXz4W9Ko+nnDwcmIXAJ4MbhktVvZrw9aY3+h3UeLZCCGT
         n9QNvvPADL4ktZvYdkUu6gFwv/djp6V33K76+rQ0XRUSwaF7Nu7qznR+cmQZ8m1pZOVe
         axNNzCErSIzK/idpafT3exq01JYmwlvam1+gJ+jJ1tnP7DNLj2JXVdQuCjjdoQ9x8dN3
         +UIyUG+ssoNtZaOGdAbmGpmHZZSujUcGlRQ1HBSZCzThL0X8F3ocyPORK0LzbmCiJeu/
         BmU26cqqSgVuxqbcrlwmtUPgBinKK0hZYnyctB3vgXMjZd1kQ8PnjNIHol7U5XA/34of
         D9vw==
X-Gm-Message-State: AFuF++l/UaeOyyTSzWy8DyJCTfV9VcT1+XzdJEmvZUJ0vmjk6Rfx6PBX
	R4jCrc23Znvpb+8VKVs4y1HSj13gUvAjRUNg5tOGZRGALrMvxV+RWNhuffvHBvpQ1EaShexe1rY
	7CBJ/EA==
X-Gm-Gg: AYBFou0Wmjyyvo+KGD268VkcsS3IN7HSiT+wOjDxxBIJqAFopcuiFmstNT2jkjYiQn5
	if3qt4F4zcKQGk5TAXRxnYkJOFCongnuV5ab4iyKzmjZXjeyUoGf8ipLF4RgSkJhlKxJEDzsbYK
	Y6IMu6T5l7Q+WJTbWqbWBPQh1eMQWVVcv7vtwPS7po3mjTYGCZBqRGk8V6Vx3LHyhVawdxZRm1q
	Me1UdNmtpb18c+id8ygRYq7TQe7Pypsas8YhtWQttkZ9MH+oqS+Gxo1pWe+Qe++e9Hr13C0SYhZ
	iZsIVub0szuYcwjwOZvvYLVzYtnzqC5L5F3HCRGyzrZj0l498nJu4fT9UDGGuWtNRa9nGvqDBfP
	ieeu+KwAE6XSSDPtA3ZhPclCWuppQ/WzWqTDZDzm2gQg0Mx1q9k1kSjjgn+88AdaJiKhhQqbFz+
	UZFAWydUEVPfO4ARZ9DOWBgSDIm0/tEWvqFcIiuzJ3t9Mwipbazag/4MC5S+rAUGMx61lVF9hOl
	y/lhAfVj8XlR/DiZHqR
X-Received: by 2002:a17:90b:3fcf:b0:39e:ac:b776 with SMTP id 98e67ed59e1d1-39e00acb9edmr3293198a91.25.1789440392686;
        Mon, 14 Sep 2026 19:46:32 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfbad50acsm1018250a91.4.2026.09.14.19.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:46:31 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	ncardwell@google.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: tcp: account zero-copy receive VMA memory
Date: Tue, 15 Sep 2026 10:45:40 +0800
Message-ID: <619733e91a715790da8c4efd88f51897ff06e253.1789284524.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789284524.git.petalzu987@gmail.com>
References: <cover.1789284524.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

TCP_ZEROCOPY_RECEIVE installs page references in a user VMA and then
consumes the corresponding skb. The socket charge is released at that
point, so a process can retain an unbounded number of receive pages,
including page-table memory, by advancing through a large VMA.

Reserve the VMA size in TCP socket memory accounting while the mapping
exists. This charges the reservation to the socket memory cgroup and
TCP protocol budget, and releases it when the last VMA fragment is
unmapped. Keep the reservation across same-mm VMA splits and moves,
disallow expansion and fork inheritance, and reject inherited VMAs from
the zero-copy path. Use a strict accounting kind so ordinary receive-
buffer minimum allowances cannot bypass the reservation limit.

Fixes: 93ab6cc69162 ("tcp: implement mmap() for zero copy receive")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/sock.h          |   1 +
 include/trace/events/sock.h |   3 +-
 net/core/sock.c             |   2 +-
 net/ipv4/tcp.c              | 102 ++++++++++++++++++++++++++++++++++--
 4 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac2..cf19055a9c40 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1556,6 +1556,7 @@ void __sk_mem_reclaim(struct sock *sk, int amount);
 
 #define SK_MEM_SEND	0
 #define SK_MEM_RECV	1
+#define SK_MEM_RECV_ZEROCOPY	0x100
 
 /* sysctl_mem values are in pages */
 static inline long sk_prot_mem_limits(const struct sock *sk, int index)
diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index b5310439536e..0f10b92c118c 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -38,7 +38,8 @@
 
 #define skmem_kind_names			\
 		EM(SK_MEM_SEND)			\
-		EMe(SK_MEM_RECV)
+		EM(SK_MEM_RECV)			\
+		EMe(SK_MEM_RECV_ZEROCOPY)
 
 /* enums need to be exported to user space */
 #undef EM
diff --git a/net/core/sock.c b/net/core/sock.c
index fa60b7494c58..3d85c138e1c7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3380,7 +3380,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		if (atomic_read(&sk->sk_rmem_alloc) < sk_get_rmem0(sk, prot))
 			return 1;
 
-	} else { /* SK_MEM_SEND */
+	} else if (kind == SK_MEM_SEND) {
 		int wmem0 = sk_get_wmem0(sk, prot);
 
 		if (sk->sk_type == SOCK_STREAM) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 562752352afe..5cc2bfc8a90d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -267,6 +267,7 @@
 #include <linux/errqueue.h>
 #include <linux/static_key.h>
 #include <linux/btf.h>
+#include <linux/sched/mm.h>
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
@@ -1860,23 +1861,118 @@ void tcp_set_rcvbuf(struct sock *sk, int val)
 }
 
 #ifdef CONFIG_MMU
+struct tcp_zc_vma {
+	unsigned long nr_pages;
+	struct mm_struct *mm;
+	refcount_t refcnt;
+	struct sock *sk;
+};
+
+/* Keep the size argument to __sk_mem_raise_allocated() within int. */
+#define TCP_ZEROCOPY_MEM_CHUNK (INT_MAX >> PAGE_SHIFT)
+
+static void tcp_zc_mem_uncharge(struct sock *sk, unsigned long nr_pages)
+{
+	unsigned int chunk;
+
+	while (nr_pages) {
+		chunk = min_t(unsigned long, nr_pages,
+			      TCP_ZEROCOPY_MEM_CHUNK);
+		__sk_mem_reduce_allocated(sk, chunk);
+		nr_pages -= chunk;
+	}
+}
+
+static int tcp_zc_mem_charge(struct sock *sk, unsigned long nr_pages)
+{
+	unsigned long charged = 0;
+	unsigned int chunk;
+	int ret;
+
+	while (nr_pages) {
+		chunk = min_t(unsigned long, nr_pages,
+			      TCP_ZEROCOPY_MEM_CHUNK);
+		ret = __sk_mem_raise_allocated(sk, chunk << PAGE_SHIFT,
+					       chunk, SK_MEM_RECV_ZEROCOPY);
+		if (!ret) {
+			tcp_zc_mem_uncharge(sk, charged);
+			return -ENOMEM;
+		}
+		charged += chunk;
+		nr_pages -= chunk;
+	}
+
+	return 0;
+}
+
+static void tcp_zc_vma_open(struct vm_area_struct *vma)
+{
+	struct tcp_zc_vma *zc_vma = vma->vm_private_data;
+
+	refcount_inc(&zc_vma->refcnt);
+}
+
+static void tcp_zc_vma_close(struct vm_area_struct *vma)
+{
+	struct tcp_zc_vma *zc_vma = vma->vm_private_data;
+
+	if (refcount_dec_and_test(&zc_vma->refcnt)) {
+		tcp_zc_mem_uncharge(zc_vma->sk, zc_vma->nr_pages);
+		mmdrop(zc_vma->mm);
+		sock_put(zc_vma->sk);
+		kfree(zc_vma);
+	}
+}
+
 static const struct vm_operations_struct tcp_vm_ops = {
+	.open = tcp_zc_vma_open,
+	.close = tcp_zc_vma_close,
 };
 
 int tcp_mmap(struct file *file, struct socket *sock,
 	     struct vm_area_struct *vma)
 {
+	struct tcp_zc_vma *zc_vma;
+	unsigned long nr_pages;
+
 	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
 		return -EPERM;
 	vm_flags_clear(vma, VM_MAYWRITE | VM_MAYEXEC);
 
 	/* Instruct vm_insert_page() to not mmap_read_lock(mm) */
-	vm_flags_set(vma, VM_MIXEDMAP);
+	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_MIXEDMAP);
+
+	nr_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	zc_vma = kmalloc_obj(*zc_vma, GFP_KERNEL_ACCOUNT);
+	if (!zc_vma)
+		return -ENOMEM;
+
+	zc_vma->nr_pages = nr_pages;
+	zc_vma->mm = vma->vm_mm;
+	zc_vma->sk = sock->sk;
+	refcount_set(&zc_vma->refcnt, 1);
+	mmgrab(zc_vma->mm);
+	sock_hold(zc_vma->sk);
+	if (tcp_zc_mem_charge(zc_vma->sk, nr_pages)) {
+		mmdrop(zc_vma->mm);
+		sock_put(zc_vma->sk);
+		kfree(zc_vma);
+		return -ENOMEM;
+	}
 
 	vma->vm_ops = &tcp_vm_ops;
+	vma->vm_private_data = zc_vma;
 	return 0;
 }
 
+static bool tcp_zc_vma_valid(const struct vm_area_struct *vma,
+			     const struct mm_struct *mm)
+{
+	const struct tcp_zc_vma *zc_vma = vma->vm_private_data;
+
+	return vma->vm_ops == &tcp_vm_ops && zc_vma && zc_vma->mm == mm;
+}
+
 static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 				       u32 *offset_frag)
 {
@@ -2173,7 +2269,7 @@ static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
 	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
 
 	if (vma) {
-		if (vma->vm_ops != &tcp_vm_ops) {
+		if (!tcp_zc_vma_valid(vma, mm)) {
 			vma_end_read(vma);
 			return NULL;
 		}
@@ -2183,7 +2279,7 @@ static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
 
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, address);
-	if (!vma || vma->vm_ops != &tcp_vm_ops) {
+	if (!vma || !tcp_zc_vma_valid(vma, mm)) {
 		mmap_read_unlock(mm);
 		return NULL;
 	}
