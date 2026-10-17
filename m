Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074137A836
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200450; cv=none; b=JyZsm9PFOrKcj/6i6a0rtP636UQdwsvfRn7ZRaQe5KtJ6v+T9yjLfFM5Xxli9KKyj6RM1MSmPdWcJzWBu7UQ66TRtwXG+OQB79a3/84D5YImHolf1NOdQ045eE/tT2ooINJi7vxdyMGMiF0vKoaYXmb1gR6aXOsBLvVir/mdbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200450; c=relaxed/simple;
	bh=M8ES0kL0OPES6hbTArznFgO3NVcCTS5zVjhh6KSPQtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dREUl4o5WqwT3RMacwjpIh2g/oWC6PXaCBMrpw6FKQTJDYSfM2fq4rEVVC4FMCBBDni/3W5wbamr6jPIkh9RBzCzocdyjdrk7T6JZSz7pi/1wE0QTtGJSXe7KyUmHK6AcW+LGoDM5Xks5yXLGP4Zs3kvooxFVwx4RQScoDeTm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2cGTRNM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2cGTRNM"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c9879395so237936a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200448; x=1792805248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LioG1TfRbQbbPeFWnF473ae+LrllOtiRpu5PoIzCrE=;
        b=r2cGTRNMaBYoc1wKb7mTH5zmcgDxi1ioMn3ZjzMmdxGIpef4Acg55t6RZLuHKS44yI
         Jyx1ICXi9LWbV29dbUpahebPA9ASMctEzaggAM3XHRHiFLA1gmC0auR040D7VBtZFxxd
         lfVkaWHVoQd9jDPjGym5GCUmc5K+Bn7K1tgW2kYygqZTOLHpPbUjK+HH+flME3UfHUoL
         qqLZMktcdvTe3og5YrbAqcHNwMJbCLP7pt3v8GneM2wX3rwffEgDrhbvN+MYAvR2QDzY
         AjIFNL5gLHCJMHLJkcTYGspuPOxxMGK/tWQLq3lP9KoYC6ZlmOpjUvQIb31A+JTHhC5P
         Qr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200448; x=1792805248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4LioG1TfRbQbbPeFWnF473ae+LrllOtiRpu5PoIzCrE=;
        b=ckLITI8MTqSqgh7kjnhq2WWolBS6GNF2nS7Hva5yPG61nbZk8bTU4hGpEtGMiRDawP
         xtOuOGFX6VO46LK+vEQInPvu1X2hD96qg0KqmQm4VSs8njqf35b+Y8XtNWeoeK2fZ3Gs
         euYE2W4FPogvvR6AERv+iuVRMFlVJJtsnJtQqlUsquj6ZCzK/i4PL6iwrEalDl2CIEAW
         f5HBJ1wHeh/v7Sm0tbzi9G6KJjN4etLRrDdjj1eiTrWI2ELV2Az16epuWCNLsOoUFZvk
         GrgzYYruuDj28KlsrtyGLuqrvUvUtgh6woSJpEiZCKbQhnPXv4vGe+v3MNMPYwHm35+8
         VI6w==
X-Forwarded-Encrypted: i=1; AKwUvBxBwTMzlfM7KhD8no8NABoR0LJbpS2l/H0GO/mkMS5faOSi6lYkXjceJM+xGi+iGlzCwXnD9/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ12K/LrTIVoo9LJTiaH63jL1U6SAKMr+/D6DPir5uJ0CFe1A+h
	sblMgcJgZAgOHjcsExe2WAPRGYaI3SFvbEcHX7DY1ius3ZMcU73SAH/W
X-Gm-Gg: AYBFou2RUqE2fqRn9oVpf/Ghl0r/IzEuaTEzUe/Hw+PtGZIqw34V/PhrTHURxCBt01z
	tB28AH4WSaKANuwNQPMR49AKV6ts6yirGryT5KOkrw4qJ0kRhZkLtvhG5PgCOSwfo3QXFaFdn+Y
	KNqCusRM0bUa2CSnY2/1r+cCNEquAMfT+/hSsDX7w8Nzrwt8YiF70HyUzcGXMvprxbExXZJzefY
	5EpsI2dOmW8hzUpdEmTmf3zdmY7LgBgT0GJ6T5v9gk6WQUrx/pf/uTLfcrbQ0Rtn21muTLW/Bzh
	4KnTsDQMqXms4+ouyZ8Cp7yUL7sLZK96hVIkYuOj2YdHRLA6lgOvLFoxTfOvsijE4IDTalFFjl6
	32msK83s3i3aYYOlKUUXlz2ZzBZU2KvxuVIW0Mk1E/xTeISmPTOqizpdmJ3tty6iwt8aaay1DYF
	enThVDZva7Z9u24yrP+5KsPpPoa8g7zDzFDaMXOnRc4hJftvI4kulfpa6/4pYJFnRmzOTbWolEN
	RRrVV8eHZm11KwNo8TPU47ACe9/kmxjYjp/lT6BOnqId0HP3TDwGKGkVCl7zpxzNnnIcBpAglGp
	9jXC7ClMV7B79at6IdadJLu8d2wM8dYJNOjIaijbAMk=
X-Received: by 2002:a17:90b:4c49:b0:3ab:c674:cad1 with SMTP id 98e67ed59e1d1-3acef51ec78mr1289943a91.50.1792200447558;
        Fri, 16 Oct 2026 18:27:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm6188375a91.9.2026.10.16.18.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:27:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 16/38] bpf: Hold the socket in the sk_storage map iterator
Date: Sat, 17 Oct 2026 01:24:29 +0000
Message-ID: <20261017012451.364800-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The iterator over a sk_storage map passes the owner of an element to its
program as ctx->sk, without a reference. All that it holds is the RCU read
lock, which keeps the element and the storage, not the socket.

An element is unlinked by bpf_sk_storage_free(), which __sk_destruct()
calls right before it frees the socket. That is no better for a socket
with SOCK_RCU_FREE: the grace period comes in front of __sk_destruct(),
so a reader which starts behind call_rcu() still finds the element. The
program and the helpers it hands ctx->sk to, such as
bpf_sk_storage_get() or bpf_sk_storage_delete(), use a socket which is
being freed on another CPU. It takes nothing but reading the iterator
while sockets with an element in the map are closed, by whomever.

Take a reference for the time of the program, and skip the element if
there is none to be had. To look at the owner at all, do what
bpf_selem_unlink_nofail() does for bpf_local_storage_map_free(): as long
as the element is linked under the lock of the storage,
bpf_local_storage_destroy() has not got past it, unless it has given up
on the lock, and then it waits for owner_refcnt.

The last reference may now be dropped by the iterator. The end of a socket
may want process context: rfcomm_sock_destruct() takes a mutex. So only
drop the reference under RCU, and free a socket whose last one it was when
the RCU read lock has been released, which is at the end of a bucket and
of every read() at the latest.

Fixes: c69d2ddb2072 ("bpf: Using rcu_read_lock for bpf_sk_storage_map iterator")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 73 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index aea67b446c7c..ea22ec5ef5b1 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -699,8 +699,37 @@ struct bpf_iter_seq_sk_storage_map_info {
 	struct bpf_map *map;
 	unsigned int bucket_id;
 	unsigned skip_elems;
+	struct rcu_head *dead_sks;
 };
 
+/*
+ * sock_put() in two halves. The end of a socket may want process context:
+ * rfcomm_sock_destruct() takes a mutex. If the iterator drops the last
+ * reference, it keeps the socket until it has left the RCU read side critical
+ * section. Nobody uses sk_rcu before sk_destruct().
+ */
+static void
+bpf_sk_storage_map_seq_put_sk(struct bpf_iter_seq_sk_storage_map_info *info,
+			      struct sock *sk)
+{
+	if (refcount_dec_and_test(&sk->sk_refcnt)) {
+		sk->sk_rcu.next = info->dead_sks;
+		info->dead_sks = &sk->sk_rcu;
+	}
+}
+
+static void
+bpf_sk_storage_map_seq_free_sks(struct bpf_iter_seq_sk_storage_map_info *info)
+{
+	struct sock *sk;
+
+	while (info->dead_sks) {
+		sk = container_of(info->dead_sks, struct sock, sk_rcu);
+		info->dead_sks = sk->sk_rcu.next;
+		sk_free(sk);
+	}
+}
+
 static struct bpf_local_storage_elem *
 bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 				 struct bpf_local_storage_elem *prev_selem)
@@ -729,6 +758,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 			/* not found, unlock and go to the next bucket */
 			b = &smap->buckets[bucket_id++];
 			rcu_read_unlock();
+			bpf_sk_storage_map_seq_free_sks(info);
 			skip_elems = 0;
 			break;
 		}
@@ -796,12 +826,44 @@ DEFINE_BPF_ITER_FUNC(bpf_sk_storage_map, struct bpf_iter_meta *meta,
 		     struct bpf_map *map, struct sock *sk,
 		     void *value)
 
+/*
+ * Take a reference on the socket which owns @selem. RCU keeps the element, not
+ * its owner. As long as the element is linked under the lock of the storage,
+ * the owner has not got past bpf_sk_storage_free(), unless that has given up
+ * on the lock. Then it still waits for owner_refcnt.
+ */
+static struct sock *
+bpf_sk_storage_selem_get_sk(struct bpf_local_storage_elem *selem)
+{
+	struct bpf_local_storage *sk_storage;
+	struct sock *sk = NULL;
+	unsigned long flags;
+
+	sk_storage = rcu_dereference(selem->local_storage);
+	/* reset since ->next() looked: the socket goes away */
+	if (!sk_storage)
+		return NULL;
+
+	if (raw_res_spin_lock_irqsave(&sk_storage->lock, flags))
+		return NULL;
+
+	if (!hlist_unhashed(&selem->snode) &&
+	    refcount_inc_not_zero(&sk_storage->owner_refcnt)) {
+		sk = sk_storage->owner;
+		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+			sk = NULL;
+		bpf_local_storage_unpin_owner(sk_storage);
+	}
+	raw_res_spin_unlock_irqrestore(&sk_storage->lock, flags);
+
+	return sk;
+}
+
 static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 					 struct bpf_local_storage_elem *selem)
 {
 	struct bpf_iter_seq_sk_storage_map_info *info = seq->private;
 	struct bpf_iter__bpf_sk_storage_map ctx = {};
-	struct bpf_local_storage *sk_storage;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int ret = 0;
@@ -812,14 +874,14 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.meta = &meta;
 		ctx.map = info->map;
 		if (selem) {
-			sk_storage = rcu_dereference(selem->local_storage);
-			/* reset since ->next() looked: the socket goes away */
-			if (!sk_storage)
+			ctx.sk = bpf_sk_storage_selem_get_sk(selem);
+			if (!ctx.sk)
 				return SEQ_SKIP;
-			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
 		ret = bpf_iter_run_prog(prog, &ctx);
+		if (ctx.sk)
+			bpf_sk_storage_map_seq_put_sk(info, ctx.sk);
 	}
 
 	return ret;
@@ -837,6 +899,7 @@ static void bpf_sk_storage_map_seq_stop(struct seq_file *seq, void *v)
 		(void)__bpf_sk_storage_map_seq_show(seq, v);
 	else
 		rcu_read_unlock();
+	bpf_sk_storage_map_seq_free_sks(seq->private);
 }
 
 static int bpf_iter_init_sk_storage_map(void *priv_data,
-- 
2.55.0

