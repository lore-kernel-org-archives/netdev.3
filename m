Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8E360EF2
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200070; cv=none; b=a5wtG9ytv19AuH+bytns6tEr9Yxi5fvurz4dK8nm/mfMQw+yiAdQ7GPrzzZghikPeKTwkzvOpdsYqJbrAjj2fvX2yMNfFDdEwDZ0NkrcywbyF6oUhPoR5lzfME7MH4LMiGIeemM0SCUoO+GN9FR+1H7pib9IxHKrfpgKRqJWh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200070; c=relaxed/simple;
	bh=FKqteCSXO1CbRVOSlk9/EvC/7gM2fsr0/PRO0BW8AjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbHs3FRfStyP8CVOEYfQ7Ryhg0+1wiYfhckTE0DdU1YQ6fbsqHL0vSQDUR8KjJlX499SFtad8EvsdzNE4v4FikPmuP53A+Qak31MP4E0kXIS6zKBSZpyxYVTCNourOZZoN1vepwL0XvA/S5/cHaRkWj7ktZU21AY10Pn3ZFlbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTIEAFUp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTIEAFUp"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd623dfe420so428919a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200067; x=1792804867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLOTcel4mG6H6gLmD7SemEC02pAxD8Wu1dMrbttEvSQ=;
        b=hTIEAFUp6S1DOyCNO3Cuy4C16n5oS3Cnvwt9YpbHBScXeDVQDOIPkqPmZs7hHUxedm
         AcOIjdzfGUpWJO+wNkjzVQk7+0oZ5qn1+d+62uU62+4NNf/U2VG2hMZw9dXLi7vgGr5h
         GW78NBVHOEbOgwcKwLcPH3/UpwtTlAlmsGEGWTPDW/5e7d5145x7doJLC/zvrZo0e+EI
         vugF7y4+E7xPZ5/S4Ag53hDvxhSE5HY7wMp+gL2uXp0uZiUiNaBhdRGyWUWcIOawXKoR
         +SNBdqMnOdVsObvFUsjR7JzbaidB2rhW06OEwI4rmfLQ4bb76xcpKZX8ME6siV635uvn
         E4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200067; x=1792804867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLOTcel4mG6H6gLmD7SemEC02pAxD8Wu1dMrbttEvSQ=;
        b=IiZu8KmeIohy0IwGIeVXI0hX7CFh5qSaP+Ji3un9Ngd1PLcnHKvaGaSQwdroAWm9iv
         CVbqNAKfaKy4UEIzWeyL/ScQuSC8WQSlqA0YbwRb6vS5+cBGuxeDBCu0jpynXbIONwdE
         KZdbpGGvHbIaMB/bbn7SJt2EnV0PYMOfeYm2lvQcAlajme2IqyW9WBV9QiKr3+UyS2Lm
         3XttQlAuZ8odrfMLjVqxI7WxKKLjnb6pWguOqd7Er2tduQnuU0e1GnkXSTGSCZKC/06f
         AhW6nKjxBt8vQVUr+hAk5pQp1uC/GMAZgLqcod02Hp0oWzcqwyYLxz0M3GuS7kpFcBRe
         if+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgBL3JHuUfZ2dxRviO+vSTRjgscje233eDfs/Csaxhmx+TNgs6lDIT1zpteZ4yFHa40gxGToE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJX7k77q+W0NOyw4SEU0ozHcXXaSDgD2wiAtfMwiDGOjeC4xwjw
	YbvQPF1LvJm/M7S3/Jevw37xFLfGSUAhCugGXXwUvePuQbbf3IqmtIzk
X-Gm-Gg: AYBFou3B5iXpgvVPFMRyNQh8v/R1PU2AO50PSlAjM2aEOrI56uCCSNFKTaGk6u1QRC9
	9017AVXk1oW+Ryt6g1rK9lf6hdStFX+yg2XPGeTe9oMw1EMQ718h69r46vKFrqFMz0jUAihSZEY
	hfbcTtcZ52QcOrbs2QnvExsJ1WAezXEKLCSwf/CrwFpg22HmMM6jKm2SH2/tBiGS+UEmMiYP7Fv
	XTITgLkEJKrF8szmCduE2QorLqGiW0Rt4C3WfmHxbC1AYvRK1EwGWo6EhuLeKq4DTHBwOJW7BM1
	+Gw5LxUQIsyH2tvjwzOc32EtTQFHLx4ivSYRBs/qUGCbPfskmvSugOPJR8RAF+nxtfWo2j57WZz
	iwonICnOU4fqWJAuHjOTuUXbnviP/H5YkAKTabK39I0P5Jnh9pTnx7PU7UXNSQloO1/CZcnsPvx
	a+yO52hMKJkdGZ1wP9SOOo3qv4LNOcZFcPdZzecv6yzkwnHypemA4ahgqj2FSDD069U349Jx6l9
	K4MThvow6li2ZxjZje1aXCOmtfrync5TafLR0pjuN1Pjqgvlv2XdLVOqARqVDoFVcGyKlJ0FxDT
	AQIOCL7UKGDzWtya1PNevqPhcCnpxF2PrUo22KCYDRI=
X-Received: by 2002:a05:6a20:ac44:b0:3d3:ae50:97ce with SMTP id adf61e73a8af0-3e22629e2dbmr846324637.27.1792200067394;
        Fri, 16 Oct 2026 18:21:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549eea48sm1848788a12.19.2026.10.16.18.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 02/38] bpf: forbid sleeping in hash map for_each callbacks
Date: Sat, 17 Oct 2026 01:20:22 +0000
Message-ID: <20261017012058.355787-3-alexei.starovoitov@gmail.com>
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

A sleepable program (e.g. SEC("syscall"), lsm.s, fentry.s) can pass a
callback to bpf_for_each_map_elem() on a hash map and call a sleepable
helper or kfunc such as bpf_copy_from_user() from it. The verifier
accepts this, but at run time the callback is invoked from inside an RCU
read-side critical section:

    bpf_for_each_hash_elem()
      rcu_read_lock();
      callback_fn(map, key, val, ctx, 0);
        bpf_copy_from_user()       <- may fault and sleep
      rcu_read_unlock();

bpf_each_rhash_elem() does the same for BPF_MAP_TYPE_RHASH. Sleeping
there triggers the "Voluntary context switch within RCU read-side
critical section!" warning, delays grace periods, and with
CONFIG_PREEMPT_RCU=n silently ends the read-side critical section that
the bucket walk relies on.

Synchronous callbacks are verified with the caller's state, so
kernel/bpf/verifier.c:in_sleepable_context() only looks at the program's
sleepability and the locks the program took itself, and does not know
that the helper holds rcu_read_lock() around the callback.

With a SEC("syscall") program whose callback reads a page that has to be
read from disk first:

  BUG: sleeping function called from invalid context at include/linux/uaccess.h:169
  RCU nest depth: 1, expected: 0
   __might_fault+0x29/0x80
   _copy_from_user+0x26/0x90
   bpf_copy_from_user+0x23/0x60
   bpf_prog_17d44fa39eebd6cc_cb+0x35/0x46
   bpf_for_each_hash_elem+0xdb/0x280

Fix by marking the callback frame of hash map iteration as running under
RCU and making in_sleepable_context() false while such a frame is on the
call stack, so sleepable helpers, kfuncs and global functions are
rejected there as inside bpf_rcu_read_lock(). The rules for trusting RCU
protected pointers are left alone, which is conservative and keeps
callbacks that verify today and do not sleep working. The flag is
compared in func_states_equal() so that pruning never mixes the two
contexts. Array map callbacks run without any lock and keep the caller's
context.

Fixes: 314ee05e2fc6 ("bpf: Add hashtab support for bpf_for_each_map_elem() helper")
Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/states.c          |  3 +++
 kernel/bpf/verifier.c        | 28 +++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 112ca1511da4..816948df8fff 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -379,6 +379,11 @@ struct bpf_func_state {
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
 	bool no_stack_arg_load;
+	/*
+	 * The helper invokes this callback under rcu_read_lock(), so the
+	 * callback and its callees run in an RCU read-side critical section.
+	 */
+	bool in_rcu_callback_fn;
 	/* For callback calling functions that limit number of possible
 	 * callback executions (e.g. bpf_loop) keeps track of current
 	 * simulated iteration number.
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 953700822fa7..b3d250caaaa6 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -995,6 +995,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
 		return false;
 
+	if (old->in_rcu_callback_fn != cur->in_rcu_callback_fn)
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddfa0c6d2755..883cf148235c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11530,6 +11530,19 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	switch (map->map_type) {
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_RHASH:
+		/* Hash tables run the callback under rcu_read_lock(). */
+		callee->in_rcu_callback_fn = true;
+		break;
+	default:
+		break;
+	}
+
 	callee->in_callback_fn = true;
 	callee->callback_ret_range = retval_range(0, 1);
 	return 0;
@@ -12273,10 +12286,22 @@ int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
 	return *ptr && (*ptr)->func ? 0 : -EINVAL;
 }
 
+/* Is any frame on the current path a callback that runs under RCU? */
+static bool in_rcu_callback(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int i;
+
+	for (i = 0; i <= state->curframe; i++)
+		if (state->frame[i]->in_rcu_callback_fn)
+			return true;
+	return false;
+}
+
 /* Check if we're in a sleepable context. */
 static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 {
-	return !in_rcu_cs(env);
+	return !in_rcu_cs(env) && !in_rcu_callback(env);
 }
 
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
@@ -12290,6 +12315,7 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 			return "IRQ-disabled region";
 		if (env->cur_state->active_locks)
 			return "lock region";
+		return "callback running under rcu_read_lock";
 	}
 	return "non-sleepable prog";
 }
-- 
2.55.0

