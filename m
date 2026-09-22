Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595E576EDF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097654; cv=none; b=ZJ+8K9KGahYDpgBdybZST7ywLApvXWIFzOZJWVxLDlzOfryY4/wKJgbIH7qNPygY4sHq1vTTEi+AIfviSv8CvuWelVgId1WdV4FZYzKdJWaIhRjPE+9WnnqxTHqOqzSJbVYWYnoDvkohe5wpg7pWL6SCoLCq/el1KJu79mXqRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097654; c=relaxed/simple;
	bh=rB1Opw5B2LOg6P/GYytAjPU/kxjLmp3Q4k3S84pEe1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMtFAsM0+B4RIFxGwfam8jjhu2VYaypORES7+7oTr+MxCHkFz4Che0/N9ClHiHG0v5qr5VvoqhHk6ZCSvhlIAGyEcwuk9hHc34aNgRBUab0se6je/Uc5Y6fyatlg0JgKXkHH4JlZNCTls2D0hBEVvxUKY8GaQbyd64B8seFJZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=s+6rxN65; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="s+6rxN65"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso95402a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097649; x=1790702449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yOnggd3RxTs4DSXKpObmRaWjKX2daePFjv5dqgMAGTw=;
        b=s+6rxN65ayx/N6+2AX/Zd4Ib5vblSugXczah/87RncsbdIPmYJCT1KXE6wAC8HZTZW
         VCvXrkQgxc5gNz4wQitGwhaY1zqFi46jFcPuajLX9L4zPmZjD/mikLaK8N4cjrXtkQKL
         ID+D5pEEDSEZBweCxqtsM/UAg+yOJAoGg6Lv973Q99um45/YjtzPcXw5gYDRI7MXXi6F
         K9l/3QKWmVTVjFo0MK+iQ4DjXcj1cFxh0qbgoKxRthm8GzCBY7YNCmBxzAzyqits0NjW
         bit8jdPklnqyaNOsa4L9+bxBMg1HJAk/WnZbHakfcMMAT7B0oK3oywAoiaKr/oM/+DxU
         WbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097649; x=1790702449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yOnggd3RxTs4DSXKpObmRaWjKX2daePFjv5dqgMAGTw=;
        b=v4AQb4goUOVNNYGMUOu+tdD+YitVUb0c5QzbLqtYmJ7GvXvQrUfyT1b/GxdLhJlEPK
         LSZMtkDi7Q/93SpyWUpLZEEvBRJkUAjhw3DI4sPdip0LugrAz3q1RqAj8IB9oL4e9Zgp
         86wSsNUQxo9Z1gSvXJ5UbJX/BBDIu9026ZGBIG0v9f8p5jHcbd0TwqbTqZjT92TI7Nre
         +UMzCTdle0E9RYG5FydmzKPWWEgvcYZQSL8L2pEAVfT/T2Qv46WOfHPoBLc/46ZJ5paX
         ItvLwPXsOJ2NGGCCVFT4elNkxjUu2yWILGlNoGqEUH4tkFemqZzqjYRLLIoPM9UlVsJ/
         3GRw==
X-Forwarded-Encrypted: i=1; AKwUvBwfgtUPUC9KYg4lFNDL5hnZvN9w/kbbO5tgi2STbFWb/6009gA4U8R39yrzhz6baKitrKixhWM=@vger.kernel.org
X-Gm-Message-State: AFuF++kFWNXi2VTzdr1kTsz5cOWKU0YMumdghQCkIHEMZF4SWauqicDa
	hj7X2oZI6b1TY/kKKUk0UH4o0ynR/TQfRl0ricAV+2ILJWYtj5DtoOAxP9AdI+UEa/c=
X-Gm-Gg: AYBFou0G5FegvbIRdOH6dh8A88slWM2vQsyd0J9/ja1ie8aqu5S5LvBTJdceJUdJhT0
	obfQkZhIfzi0zHuYFRIbXrN5hHlov5vcjQS+gyIM4ninQrmGUtagYUDcGw8nBSCvh0H9GiCDG1z
	B4RNksv8y9jWnc9m10VVAFOXj7t08USivKamrlwbPR/iYiPOpW+pcF9bP72gH0HMVcduV5+RKe8
	waFAwBYCHbhbuDYfgmHEhXe665OCY5lbqyUMbBzJpURa51XRHRJc7khs1tsMFxFfXtNfe9Gmh6X
	vOXROLeVTIY+yP+wcbkEJJScb9dfEQWvK7FGav6TiIalXB3f5TBPHbH36Slv57yBKDJduI+Y2Uf
	n5Ow+XvcG8hIl+LH6/h4Carih7F5DYT3ZZtFLsuJLzAvvmkpvzcbWCT954ttwXcb562SIVVgZ3V
	EnEVT0ikRuURaYQBM8+dOK6FZLOvBuEAdb/BBiq4T6FJchwcckCOgJgKdZhfAP8fT0mGRcav0e4
	NbTu9kS4CuC0c7MUg6bPJVNCW6t8uLj6DsgLxrJtA==
X-Received: by 2002:a17:90b:5343:b0:39e:4c7f:7304 with SMTP id 98e67ed59e1d1-3a07e560dd3mr131881a91.27.1790097649059;
        Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:48 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf v2 10/11] bpf: Track skb memory invalidation by packet-backed dynptrs
Date: Tue, 22 Sep 2026 17:20:27 +0000
Message-ID: <20260922172028.6269-11-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A dynptr can be backed by skb memory, and kfuncs that
write but also read the underlying area may reallocate
the backing memory in the process of pulling the skb.
However, the verifier does not track these calls as
possibly invalidating packet pointers, and does not
do so after their call site.

Expand the verifier to track dynptr kfuncs for packet
invalidation.

Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/cfg.c             | 10 +++++--
 kernel/bpf/verifier.c        | 51 ++++++++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f57730d1d..8a9b7a2f2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1589,6 +1589,7 @@ struct bpf_call_arg_meta {
 
 	/* Only set by kfunc */
 	bool r0_rdonly;
+	bool dynptr_may_clobber_pkt_ptr;
 	u32 kfunc_flags;
 	const struct btf_type *func_proto;
 	const char *func_name;
@@ -1642,6 +1643,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
+bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1ea..cb499d19d 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -73,6 +73,12 @@ static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
 	subprog->might_throw = true;
 }
 
+static bool bpf_helper_maybe_changes_pkt_data(enum bpf_func_id func_id)
+{
+	return bpf_helper_changes_pkt_data(func_id) ||
+	       func_id == BPF_FUNC_dynptr_write;
+}
+
 /* 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
@@ -510,7 +516,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			if (bpf_helper_maybe_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
 			if (insn->imm == BPF_FUNC_tail_call) {
 				ret = visit_abnormal_return_insn(env, t);
@@ -543,7 +549,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && bpf_is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
-			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
+			if (ret == 0 && bpf_is_kfunc_maybe_pkt_changing(&meta))
 				mark_subprog_changes_pkt_data(env, t);
 			if (ret == 0 && bpf_is_throw_kfunc(insn))
 				mark_subprog_might_throw(env, t);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da110cdbc..e916ce89c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8278,6 +8278,7 @@ static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const char *name);
 static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta);
+static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta *meta);
 static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_obj_drop_kfunc(u32 func_id);
 static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
@@ -9320,6 +9321,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, meta);
 		if (err)
 			return err;
+		/*
+		 * These kfuncs only clobber packet pointers when their
+		 * destination dynptr, argument 0, is backed by skb packet data.
+		 */
+		if (arg == 0 && is_kfunc_dynptr_may_clobber_pkt_ptr(meta) &&
+		    (meta->dynptr.type_unknown ||
+		     meta->dynptr.type == BPF_DYNPTR_TYPE_SKB ||
+		     meta->dynptr.type == BPF_DYNPTR_TYPE_SKB_META))
+			meta->dynptr_may_clobber_pkt_ptr = true;
 		break;
 	}
 	case ARG_PTR_TO_ITER:
@@ -11759,7 +11769,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
+		if (meta.dynptr.type_unknown ||
+		    dynptr_type == BPF_DYNPTR_TYPE_SKB ||
 		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
@@ -12787,9 +12798,45 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_enable]);
 }
 
+/*
+ * Dynptr kfuncs that may clobber packet pointers when called with an skb or
+ * skb_meta backed destination dynptr by pulling the packet.
+ */
+BTF_SET_START(dynptr_may_clobber_pkt_ptr_kfuncs)
+BTF_ID(func, bpf_dynptr_memset)
+BTF_ID(func, bpf_dynptr_copy)
+#ifdef CONFIG_BPF_EVENTS
+BTF_ID(func, bpf_probe_read_user_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_dynptr)
+BTF_ID(func, bpf_probe_read_user_str_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_dynptr)
+BTF_ID(func, bpf_copy_from_user_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_str_dynptr)
+#endif
+BTF_SET_END(dynptr_may_clobber_pkt_ptr_kfuncs)
+
+static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta *meta)
+{
+	return meta->btf && btf_id_set_contains(&dynptr_may_clobber_pkt_ptr_kfuncs,
+						meta->func_id);
+}
+
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
-	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]) ||
+	       meta->dynptr_may_clobber_pkt_ptr;
+}
+
+/*
+ * More conservative version of the above used in check_cfg(),
+ * where no register state exists and the dynptr type is unknown.
+ */
+bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta)
+{
+	return bpf_is_kfunc_pkt_changing(meta) ||
+	       is_kfunc_dynptr_may_clobber_pkt_ptr(meta);
 }
 
 static u32 kfunc_abi_slots(const struct btf_func_model *fm)
-- 
2.54.0

