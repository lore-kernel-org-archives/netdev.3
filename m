Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11B355F49
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255274; cv=none; b=MSm4IBV1ohfRv4QNuM1eZGnK4eA7yPxnyD92itrJVUXTD7YDQEkC3SGn6lcZQ5u9LFfCHedQGIXmpk/mwgJXsiDb1CX021QpVpelKyWQN8BgSjtlHXlsPfGwsMj49u9ELzaToVqedYPWEzzl0psQk2P+SBcPEl/TuEVlz0bcDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255274; c=relaxed/simple;
	bh=yHTUXxMmw8S0ZwsjxamZWJrKynrQRtDmuW8KiAMX72I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTlrJEVdGG3mG9Ngc+UahtlLK/Ez3gazRRgFqNqu0+FJ0KtUhV/kmMou6glfijre231kV0sSlshMvP4wQUio4Hj/+SMp+0M0iHGYdbRQBKmw8/NPaFzM9HSQsVaDHPj0A+ie/iYN1lOp7S7Chtkv6HEQX6CdNBRovZUq3YHeJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3MVM71E; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3MVM71E"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e49fbf92aaso4210105ad.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255271; x=1792860071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZMlvLLc7mAPj3qANapvUTxvaQVjtyK6dFvnxwymtZc=;
        b=j3MVM71E5yMUiRyS2Be6UTGR6TYKDQDc89fhuT/XwMY07hgvstDVBXEpkdUDMvD02s
         AUzMHkR1RbXTuAPVhEwjE4t/l9Frw43uF9J4LKJ6W4VnejE1Hf0MA1RPfl2uCDKOBXal
         kB/CqE4Nw5BAnrgESyBCsVPEAGC/QBB1vAqnoxqmd1lH4UsfBzcjyr/yqXDKzpgjYFoW
         sDmX9Gg5kzVDKr6853/dJaWqZHDXmLsymH+HNsip05TwbYSjXgcApmL7wkk/nteVyHAm
         zikhkJPY3tqZErawbUKZELdDi1BWKo0ea4F/zmebjFshzosn7HJZGAq0srHYsFKO3SX+
         9mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255271; x=1792860071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZMlvLLc7mAPj3qANapvUTxvaQVjtyK6dFvnxwymtZc=;
        b=OqvTUd6whMGYIaAlMvcerx0PxBXeMrx77ZSNmW+VN5E7ML7NZMNK0vOzO6+cuLsJmx
         yXbL1vX6/9O/RfZaxf6RmAY4o1iUSR97XCGFIvtsc8t/S4qafhbXJoES7kiKNfE1jHw9
         TmJuKLWSERfYe4mRsN6LBLPJB8z7s4PQopbBzausnIwQsBSUXqs3aco2HgpS7vVrF/AQ
         R1mbkWg2CLtedzEtLrpLK/3lE6R+whg9m+20kQQetfVqNGRdzovASHpeoIQJhBVJr53V
         5j7zBGAp8o1JQdaBtotMsOwcStX4woWJ42sUkOw7QMC4j73pZkfkZe0l14PkspiwRzEI
         tFtw==
X-Forwarded-Encrypted: i=1; AKwUvByLVZLlPXsctTWJbDLcz7kCNrAHG/Gbr1clECmiyhINkJ4OXPUNbMKCCXWxHfwyFQIHShBSpMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDNOdBEK/aCHHmwnWZPmUlHW2c84e6orVxztTP0PQwZ/zEUYeM
	A941hTDPKCtAs3lD4PJutCukrnETKZRbnCGb+kcqecj8wF9zM+EsGDK+
X-Gm-Gg: AYBFou2ZW+XkiH1KqOwVb5yIj/9ocOxFUIBELkDTbeMFIBZCm41yRZS1b2ynk479H8T
	OPJYH4+p4Io/TEoQZB5EESWR572nboRC+3SY68QwyOeDb/AHTkk2qb4+nqn1FE58n7KWg8+KrVR
	nv0eUDaZPTDgQ2AsApIEGIpF50DwclIzL+xGcrbsPtHovBfOXgBawfK1BVg8kIOcSq/AVnTQhJ9
	zTD6NKRajB1zwRwmf8+iCBfB9vpcfIZKYGm+FQvH9V837gWVV4mGrJxC8NBeOHctO9tFu7DdE6T
	YGBlSmIlSVe4euCh02csYrd/ewpdu6a6KiGVZomvUHXmTp5EBd3s3l6yfkqMxGocOM8IuwY/gPo
	3XzOyqP2zzeHlYeNKpka2Nl9j6o+0BTglqNAw/xa5KWjGrqMX9K0siagc5RIZDEmw7SJGy4pvBI
	qF68lGCaZz079FZkhMCtaVnttiNo3H0fZYQNzrfIb5usCMIc0CAKR0ol2zg5P76IbcgzjRnq+0t
	W0kZuB87SfNkotceCyczbj+ZV6nfufY/9dc7oj0QsDCgcJ2Ba2OuTHDaud7ncbeGF2PIF7I0HIl
	NmHVQKT3Cp5us9IsArB0L4ProSH8re8bxx/iERaxGoU=
X-Received: by 2002:a17:903:41cf:b0:2d9:520c:38e7 with SMTP id d9443c01a7336-2e9a68346e4mr27609125ad.1.1792255271279;
        Sat, 17 Oct 2026 09:41:11 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8aad3dsm22496925ad.64.2026.10.17.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:10 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 33/43] bpf: Keep the symbols of a program until it has ended
Date: Sat, 17 Oct 2026 16:37:35 +0000
Message-ID: <20261017163745.3341787-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

When the last reference to a program goes, __bpf_prog_put_noref() takes
its symbols out of the kallsyms tree and frees its line info at once, and
waits for the grace periods only with the rest.  But the program may still
be running: the link or the array it was called from is gone, the call is
not over.

search_bpf_extables() finds the exception table of a program by its
symbol.  A load that faults, and that the table is there to fix up, is
fatal from then on:

  Oops: general protection fault, probably for non-canonical address
  0xdead0000000006f8: 0000 [#1] SMP NOPTI
  RIP: 0010:0xffffffffc06008f6

It takes a program that is detached and closed on one CPU while it runs on
another.  Unwinders and bpf_prog_find_from_stack() do not know the program
any more either, and the stack dump of a BPF stream reads the freed line
info.

Free the line info behind the grace periods the program needs, as it is
done with the BTF that its text comes from.  Remove the symbols in
bpf_prog_free_deferred(), which runs behind them as well.  The symbols are
looked up under rcu_read_lock(), so the images and the program itself are
freed one more grace period later.  All that the program refers to is
released when it was before.

Fixes: 3dec541b2e63 ("bpf: Add support for BTF pointers to x86 JIT")
Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stderr")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  1 +
 kernel/bpf/core.c    | 50 +++++++++++++++++++++++++++++++-------------
 kernel/bpf/syscall.c |  5 ++---
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a10af47978a4..feb7de6483e3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1971,6 +1971,7 @@ struct bpf_prog_aux {
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
+		struct rcu_work rwork;
 	};
 	struct bpf_stream *stream[2];
 	struct mutex st_ops_assoc_mutex;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e1216927373a..6e32db9777c2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3085,12 +3085,40 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 	kfree(aux->used_btfs);
 }
 
-static void bpf_prog_free_deferred(struct work_struct *work)
+static void bpf_prog_free_images(struct work_struct *work)
 {
 	struct bpf_prog_aux *aux;
 	int i;
 
+	aux = container_of(to_rcu_work(work), struct bpf_prog_aux, rwork);
+	for (i = 0; i < aux->real_func_cnt; i++) {
+		/* We can just unlink the subprog poke descriptor table as
+		 * it was originally linked to the main program and is also
+		 * released along with it.
+		 */
+		aux->func[i]->aux->poke_tab = NULL;
+		bpf_jit_free(aux->func[i]);
+	}
+	if (aux->real_func_cnt) {
+		kfree(aux->func);
+		bpf_prog_unlock_free(aux->prog);
+	} else {
+		bpf_jit_free(aux->prog);
+	}
+}
+
+static void bpf_prog_free_deferred(struct work_struct *work)
+{
+	struct bpf_prog_aux *aux;
+	bool ksyms;
+
 	aux = container_of(work, struct bpf_prog_aux, work);
+	/*
+	 * A prog that still runs when its last reference goes needs its symbols,
+	 * by which its exception table is found.  It has ended by now.
+	 */
+	ksyms = aux->real_func_cnt || !list_empty(&aux->ksym.lnode);
+	bpf_prog_kallsyms_del_all(aux->prog);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
 #endif
@@ -3109,20 +3137,12 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	if (aux->dst_trampoline)
 		bpf_trampoline_put(aux->dst_trampoline);
-	for (i = 0; i < aux->real_func_cnt; i++) {
-		/* We can just unlink the subprog poke descriptor table as
-		 * it was originally linked to the main program and is also
-		 * released along with it.
-		 */
-		aux->func[i]->aux->poke_tab = NULL;
-		bpf_jit_free(aux->func[i]);
-	}
-	if (aux->real_func_cnt) {
-		kfree(aux->func);
-		bpf_prog_unlock_free(aux->prog);
-	} else {
-		bpf_jit_free(aux->prog);
-	}
+	/* The symbols are looked up under rcu_read_lock() */
+	INIT_RCU_WORK(&aux->rwork, bpf_prog_free_images);
+	if (ksyms)
+		queue_rcu_work(system_percpu_wq, &aux->rwork);
+	else
+		bpf_prog_free_images(&aux->rwork.work);
 }
 
 void bpf_prog_free(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c412bcd1903f..ddb986324f2f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2461,6 +2461,8 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
 
 	btf_put(aux->btf);
+	kvfree(aux->jited_linfo);
+	kvfree(aux->linfo);
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
 	free_uid(aux->user);
@@ -2485,10 +2487,7 @@ static void __bpf_prog_put_rcu_tasks(struct rcu_head *rcu)
 
 static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
-	bpf_prog_kallsyms_del_all(prog);
 	module_put(prog->aux->mod);
-	kvfree(prog->aux->jited_linfo);
-	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
 	kfree(prog->aux->ctx_arg_info);
 	if (prog->aux->attach_btf)
-- 
2.55.0

