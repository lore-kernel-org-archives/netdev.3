Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7223AD538
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255210; cv=none; b=IVYnu6BxDnpwAt5q+Oj4BxfYHE76jabBnWRQLKN4C3KxOp18YL4hezjx91wkAgi4LNd77R7AzEqqIsU99lQQuMXiuSw01tbKwtlEE8pGdVfUPGfV6edctuFjoCVPHPGhbHmHi2q8pCrMqWnbU6vZxAeNETIe/tXpCCB1gBP+QN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255210; c=relaxed/simple;
	bh=SAAXRollkNJKSvtBd81jZ0CEHGfPP3GidiEilu7qVTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8v5Zj2fysHNtySxjA2NvcQQn1PX5n4JeE4vJWMS7Qzbe/qa6OtmugIEyehK7kATmnGVmIc8HimkjiUQV/A2N9o4mAs6B76NKkYj4HIhuXb/QyMLSqHDIVVOWDembjf7DTUQqiId0FEUjxtX5DPKAMltnGtnfIeFPU7w9t8daOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZM75rpp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZM75rpp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd76b1361dso3661635ad.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255208; x=1792860008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r91htTh7mdvxHPiqw9RqBQt1XlcuXAaGY/UTAekuGSE=;
        b=CZM75rppB3tbXJRhUncK5zeyO7uZnBigiEQ5YIgqt8QD7zDWX6U8STys4Typu5Nn18
         QWqOWQoRfh8EvGXyI/tCgYWtyIyYX0QmPm6z8i4ayLy671D67yT2B8Y2OHtHjRXrG1lt
         ekPDQGvDVVlPyl15OEFRqWFxhNep2MR96WaoIr0SweSpVEJZN0eX5Zm4hQWMbGWftgvL
         UNep28RSzKMa6xIWNKKgJn85/F2R1D/NtybIAZ1LfNoT8TJZTtaZSgOgZhDYjv7WSDuv
         C6RhhkQabNF1A2pdhDAwFjeavtJNUeR3FCM0uOmn5+C6Phd+3iZxz0DW6EdFAc7xzp3i
         qy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255208; x=1792860008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r91htTh7mdvxHPiqw9RqBQt1XlcuXAaGY/UTAekuGSE=;
        b=kuNsL86U5N3o4m9y+olS92Nz/DloKWfz1RbCcL1ivXTJej5UIDtMlshR3cre6aWSo2
         A4pUapiw1E8UZYTvtzoo1LMzuO3Hsxc7GV8WUP+7+z+si5vmWMsEPw6QUm3fviQKpPVg
         PqLqSe5zI8CSIKl5ezd0WgL69dz0enp6DwLU0z80jJF7r6dgVUFDXwv5ULWazvX3A33/
         MCGLNPjhlKJNJzxmZf7XsQ121sIifJFkN/ICBrfa7/VEyYSOc92+IoP3bUVADHAOdBuM
         nce4SbINTyXbSwAp+mMZ0mXomPYdnG+bskZ0phxKS9/MCd9+dB6ZfeDasbfUv9h+pY9P
         cm9w==
X-Forwarded-Encrypted: i=1; AKwUvBzg+bK9WeibwV6+ObFqkvIQlUGAGAxFQ+5rCH7aYsqtcSfgUktkMSbn+q6prZdQd0RmXITKueg=@vger.kernel.org
X-Gm-Message-State: AFq9FYITw8DMOtb9X6D5YgZO0PLZaTRFU3dREVy5hBlc1oyzGKwGqZLm
	7ysPWomg5My0NTGRG//dD58YLBQ9VmnBNZCBPy12SfaxXtD/wdgPcmYW6OsqNA==
X-Gm-Gg: AYBFou2zqY3nNCFYJsrF/1vxeluVnaHGsJdVnr8Uy79A/CCuXdn8lq0VQtSt2wnO97O
	av0y6w4VIYE0VfDCGsoSIRY9BUy82sLsOsp9AWo2WCJ6ETbb0LSADNOB3LS7CI40H1ATwJSmVWo
	yLBMDuIqDJFUbL9BxWpNoCZQrB6svffKiUvUjoVfnH1eCwgzsKqg5EnxNi02KVipQol1+qw1Hry
	aE0aU/Gt03LPHkH/csrBBNxTUUX2/0PMQkCMzpgCnmMqUaUBFUZdbowB+rApPkQQndP3vtbjz1Q
	njgmlC3fgK5QyMPCHzWlAHvbOL4EVNcWNqsbr8T5vAwOzVw+CdGgTgsL2neStqyr+MRcyAzVRi3
	4nil6Rx4nZaR0Hto6BVFKAMqVZtDIgCgAPbT3Bbj1b6+KCk+Xd6D/6MdYHOXtRKq05l3DxicgMi
	681Fc1F6QLvkdwqFn/cksHHkM7wiJlHfQwhFR2buodrqwguVNuwGUkrT3slhjltXOcqVZdmN+eC
	nkjH5B75ncZjys26U9mn/R640L8Jx36DYh15OlJqHiLNhpNpLJXt9HPerm9Y5BXmp1dUxuE+Ih3
	Fco9R4Npz92lqdmphefmiE5DLtHLU+ecn80tIWubgrE=
X-Received: by 2002:a17:90b:1b09:b0:3ac:bbc9:4ffb with SMTP id 98e67ed59e1d1-3acef15c6a3mr2867813a91.36.1792255208005;
        Sat, 17 Oct 2026 09:40:08 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9942956sm3740562a91.1.2026.10.17.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 23/43] bpf: Count sleepable callbacks as sleepable map users
Date: Sat, 17 Oct 2026 16:37:25 +0000
Message-ID: <20261017163745.3341787-24-alexei.starovoitov@gmail.com>
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
index 69285abcf594..e1216927373a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3042,7 +3042,7 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 	bool sleepable;
 	u32 i;
 
-	sleepable = aux->prog->sleepable;
+	sleepable = bpf_prog_runs_sleepable(aux->prog);
 	for (i = 0; i < len; i++) {
 		map = used_maps[i];
 		if (map->ops->map_poke_untrack)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 30d570c1c9a0..c412bcd1903f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6257,7 +6257,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
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

