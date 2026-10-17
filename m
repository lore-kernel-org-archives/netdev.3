Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65D37C908
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200578; cv=none; b=T1t1ASfr2vn4X6RN3ASQsq5xY1bQl9PJ4IBw/jf9OXcgeTQdHP9dOxdo9PBOPhWIzSNGuZ+Cqos22Ybw+cjbkA1+WglnjAu3Lt34hZZLwCaOrB40n0QgQMKuijUOQ4H2E8Fk9HwXXpguRuzwIlY2AzLHzYWBH3gY5do3DBxn0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200578; c=relaxed/simple;
	bh=y55QZuB+jWL7YRU5PCkD2HxfmFhEhzDjX+1PIEhsJLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoE1+yFwBnHYLqkaxVyHjVLvpRLrYlkkALN8G+ZN/AOewMkYT5Cbm1kjlxnsO07DuDfKN4ZpZ/MdU7rIndAgcSbfvwahcHlCPYWbIrfxTehLrl1e2wTO+Y+KekakHGS93cZ1dndCiW9kdpFlSbXG/TNzQO2Ws401w86mBa4KJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fagrZ5KX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fagrZ5KX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso398715a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200576; x=1792805376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yu+nw0DnZBOPglmG7aC0UEDpISgGOuyD+cGc5tX2Utw=;
        b=fagrZ5KXz9QS9MRbjyhHnlf7zqeY9p7yKGLn9GRiydt8ewv5sbiL1pI18R3b71WVlJ
         rYptjYb7W13Iqwl/yLzjTn7nWF9mketXJ0IKfhZ3Gae67mg9NoosIK3gLBuntDWvfhUa
         sSLwXACOeUhNCRSu2NX2Jc8emiXoVytoXrTTL9ZUDmbqRjVR8G6LXcj6uiTRzRP23eig
         MOONLzuofNv4iHJUufngPJ3FXJ2VmP6M9aZz2SbcU2W4KWTodna2JoQUmCyDahlA2tyl
         2Cv5YAmz0KSrKrJFC+jgRyAarLY/PC4VRMBgS5OrHPBVqHG4iuhWAJND1+bzdKmDlyT7
         m7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200576; x=1792805376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yu+nw0DnZBOPglmG7aC0UEDpISgGOuyD+cGc5tX2Utw=;
        b=BukkLN/iGxLVQJmyjQKyNCcRocMe47nN2TMIBx5hYok9qsOfVGXU6zn6cvOdvg/DSR
         gIs5te3FF6OMzztviEyf3cxpY4aJt4azrfpDle8P4/hZFKtGILyBzbf3nOK6VpChNbEl
         ZSz5V5LqH+QnszJ2DPYOeFS4x0jBGtVCg9E5DVB4FqnZPows+eteWSRORIbEzHfv8OE1
         IL4MewjJ4RMjTyldwZnvdGAGfdh2DFHU4uWH4FUZ7hopkJ6n0QRtAShkiPXAt6rq9Ywy
         jsW/Dj727ogM5fFJOnmU5W7BYbMf17gtxT6D5HsbZWadUXrIz8Jf3/at/P/cBJAe6FE/
         pi1w==
X-Forwarded-Encrypted: i=1; AKwUvBycMQZeZQdlpIpMW2KUjzeLNQbtDiXAw343WrOeqOiXE2tBG4D6UUxQNo7Ag9RilhBOmbxFVFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLQ5z9T2MwBZyYV1qHkYn3rQZ9LNBUIiK1puA+vt9KVWOo1l4+
	1MW9RWYLPHDBlwwsfJJHx96ZlqWnDBONUNTP8/yCtUNELH/+TavZkbgs
X-Gm-Gg: AYBFou2w22XTZNp4CZr1I4uGcc3e+cXduGMphEuwhF28UjaZ3B0Poa1/XQD3jF0nNzS
	9Dgw6CeROXcYo83OoAf/xJuvt6McUboZ00K9XuS9k8o9B5CzFXAzqpvUuDBBw2JcIs0Rm8rymTl
	Fj0eXPV09ZpCKydfwusU26R0s7V4+/RjH2ZJSnKggtNMPCGnuVetCM+DiVVjFVZOL+7+pFe/Oce
	veEy4nvQtKfuJuX4V5lmJAZN+oQ3kAPaxpwUp4UcwtVLlRRV4jq2tDpcnlqDNy1o5xDM8nxdy87
	rHECH/6p+M9lurMvxK1qIX/Tmqvg2locUIZbj4v1rlJKSg99B7FfM2lEnFisq2nyQ2oOmh9Br1B
	SYQx94zzMHPgePYcYYo1ERbhyjEmrsdgtn5sa1MecTSV89K1dDjLBnZi+KHc/5QmPwVtx7ZykM6
	D+FUqyRodMkHcrZsUR93+HpO1CnZ7sVbY7vVtXDTqQPGMedGzCF35q7Mvjiqw7SRLVa9cbx31cP
	f88L3rXTxwFit1lSNBieD7Uqcvy5ep8UBdyblN7dqwaOJez0POZAQxQ6tyKGW+tapOIpiosN47w
	J5OvY5mSPYIifvOqsktpHtguK/IZSQq8Z464gnA4epdH
X-Received: by 2002:a17:90b:4acb:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3aceefbf7dfmr1099441a91.22.1792200576099;
        Fri, 16 Oct 2026 18:29:36 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94748c6csm11470622a91.10.2026.10.16.18.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:29:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 22/38] bpf: Count sleepable callbacks as sleepable map users
Date: Sat, 17 Oct 2026 01:24:35 +0000
Message-ID: <20261017012451.364800-14-alexei.starovoitov@gmail.com>
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

map->sleepable_refcnt tells bpf_map_fd_put_ptr() whether an inner map that
is taken out of its outer map has to wait for an RCU Tasks Trace grace
period as well.  It counts the sleepable programs that use the outer map.
The bpf_wq or bpf_task_work callback of a program that is not sleepable
runs under rcu_read_lock_trace() only, and is not counted.

Such a callback can look an inner map up and keep it while user space
deletes it from the outer map.  The inner map is freed behind a plain RCU
grace period, under the callback:

  BUG: KASAN: slab-use-after-free in array_map_update_elem+0x6bc/0x7d0

Count a program with such a callback.  The maps are bound before the
verifier meets the callback, so raise the count of those that are bound
when it does.

Fixes: 8e83da9732d9 ("bpf: add bpf_wq_start")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c     |  2 +-
 kernel/bpf/syscall.c  |  2 +-
 kernel/bpf/verifier.c | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2154c18a5a4d..e98c79e8009c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3044,7 +3044,7 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 	bool sleepable;
 	u32 i;
 
-	sleepable = aux->prog->sleepable;
+	sleepable = bpf_prog_runs_sleepable(aux->prog);
 	for (i = 0; i < len; i++) {
 		map = used_maps[i];
 		if (map->ops->map_poke_untrack)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 755529888a72..3f215f2509b2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6253,7 +6253,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	/* The bpf program will not access the bpf map, but for the sake of
 	 * simplicity, increase sleepable_refcnt for sleepable program as well.
 	 */
-	if (prog->sleepable)
+	if (bpf_prog_runs_sleepable(prog))
 		atomic64_inc(&map->sleepable_refcnt);
 	memcpy(used_maps_new, used_maps_old,
 	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b15862a15e8..1f2a846ae415 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -593,6 +593,19 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 	return false;
 }
 
+/* From here on the maps of the program count it as a sleepable user. */
+static void mark_sleepable_async_cb(struct bpf_verifier_env *env)
+{
+	int i;
+
+	if (bpf_prog_runs_sleepable(env->prog))
+		return;
+
+	env->prog->aux->sleepable_async_cb = true;
+	for (i = 0; i < env->used_map_cnt; i++)
+		atomic64_inc(&env->used_maps[i]->sleepable_refcnt);
+}
+
 bool bpf_is_may_goto_insn(struct bpf_insn *insn)
 {
 	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_MAY_GOTO;
@@ -11212,7 +11225,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		if (IS_ERR(async_cb))
 			return PTR_ERR(async_cb);
 		if (is_async_cb_sleepable(env, insn))
-			env->prog->aux->sleepable_async_cb = true;
+			mark_sleepable_async_cb(env);
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = state->frame[0]->async_entry_cnt + 1;
 
@@ -20776,7 +20789,7 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 	if (err)
 		return err;
 
-	if (env->prog->sleepable)
+	if (bpf_prog_runs_sleepable(env->prog))
 		atomic64_inc(&map->sleepable_refcnt);
 
 	/* hold the map. If the program is rejected by verifier,
-- 
2.55.0

