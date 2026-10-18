Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FB3BCD2A
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302285; cv=none; b=QO3dJIeHDJqV0zIcU3tUZNb3oud+0bU9vBrAS2ZnUyByxj9jmb+UhGuAjIHZuSQni22yWG3ZeDGgxI1Y2XeYZxrBDGMjcNJmeoBbp+ouNKGs7NzEZbIlLTwmAVEUoYefV5y8gjd44LSav/PwoxJwnwbJe3eTkMZ147f1q9wxzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302285; c=relaxed/simple;
	bh=PfFOLEl10bm88lZvCW+94Ynn13otX4fg+WsHv6u9jwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfUD7bFJAOHu/YbL5klpxxGImJaClJ9CRODP5PucLs8KcnTcBnzZ1t5b6M1J4sD0ClWJEzNtva1dzfol0ot0HNl7mx/WxvGzbu3cm+bbvjX2MXM8zs4XZ0l+2tIGTQ4hN+pUDrBy5L36WlE6urf7OpxKQsMLRit6KBYAEZW7zaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NyxObFbh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NyxObFbh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8fe8e343fso4594545ad.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 22:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792302283; x=1792907083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tUpqFT7+4DKv6BqP/j4tLG6zn3HcHz36dVin1nnDJCE=;
        b=NyxObFbhYqtYwD9k0B0HZHV0cY64QocPSUshnSB0Kfp+Y1r3fCSfe/IyFd0aVSzOvB
         I8BrmV2irbyFyoGOyfXC99mkSodG0KKBe57JjrLbaEdlHzCnEncksnY9jNvBz66VgtJR
         1K+eBFaRXyOs1mUtsUR9V/qIKAVseHNI1SQljmg72ryYGsuIn4RTWvwQAImC1VV+ZK3T
         2mqA4No58sTPWTR7VP2BgzKutpxE46Ff2vhSw7lt5ZV7oJL6LZQlvl7E8ocMCIrTTvo9
         boojjqH9joFPDbDyviaaoQJ4otN4pmnjUw2/u8edvcUXmruUTdFJzMJVo/BkYL80ZT9+
         pZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792302283; x=1792907083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUpqFT7+4DKv6BqP/j4tLG6zn3HcHz36dVin1nnDJCE=;
        b=WD+QGiojkFiGAilEOQxcNzUrS2fyoE0UDk8OplaYkO9iMufsApa2zHzOmHvuTkgDmR
         qOr4LZO+jrZj8kl/09T/T4Q8dfNpjGK2BhymbMcCZELCsps1u3bFYPdZvKlYH6BvMx3n
         4Qur5BMmDXhAaEvWyKL9HhdnfX255SKQ5SngaXMpBVLJGdVvqoJwNX0o08jk4lCmSbTy
         1zRrW3d/Ec87JWT6IXz0cRVBKk1tajBXxBK76RSl9E94Zgys3dkgwzdio9AHxLgQPmKy
         K/n1M6G/nI5F0odpJkEAPbHWO9AQmUpHX4qAvpgCgE8Wvts+URlIR9wMO1zaDgf8GThn
         JqoA==
X-Forwarded-Encrypted: i=1; AKwUvByL0e40FF0nlS09BgOMPsM7iykleItjSer0JCjtb7CdqhaTb5VO5rBLJU6tvB0CsW8+P6bIPjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPHTSyezbbcMrRUTf5Hro1x7weKq6iyWAguSHfyCgj36+SOpnd
	EtQzBRk5O/Hn9Hkud87MczT4cnOD8kC6oSQtI2g0bnf0+5eDsSqhR7SgDElUm07BHE4k
X-Gm-Gg: AYBFou0jXU6PDLMa8+/d3Qxhzi+DSaRNhO3Uz5RzirDPskpDlkXz0XTce9TqFMmblMf
	pVo2tJwvVwQaVxF2yVFxNYLg6Ecc6q5TFTdGr8dWbAekmKj4s9Gzw7gtTO1mmplob2bljgc6nLJ
	ZRgFEsDJIv0260FFZCXpxsWINe5JQrBXe9MjjnF6rByToP8tBWg0ZdGEb4N578oi8XYO7jfym6z
	S3s9J3GhON8yQnojJIoC0XwU2IBUtZBTaN9eXcQml+4dX2MMA5gfPxKpIhEuHcA0XTG0AmQvGrG
	DoL4DaWnt75i0gEXhD9zroPk4E6S5HU+NEazWlQHH1743YQWuPax9clcpSOTp8WEHKnS2raCpYs
	c7NmAfdT5W+EXcOKuFxDl4A2a4/rdFApqmWZ0gvRW90chQ1XpKbm4XUaNIFuTnOyMBbmsUWAwuP
	a8aY/ee7sqdRERZIzQkNoy/ogsy7Kbu1j7YnNiqenIg5k4mxDS9p0WqeXQhxjlMDFSKCS/6rraq
	BgXpZP7/fU=
X-Received: by 2002:a17:902:f607:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2e9a6c1300fmr34688465ad.54.1792302282973;
        Sat, 17 Oct 2026 22:44:42 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804e80sm27011525ad.23.2026.10.17.22.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 22:44:42 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	sdf@fomichev.me,
	drosen@google.com,
	ameryhung@gmail.com,
	xyx2021@mail.ustc.edu.cn,
	chenyy23@mails.tsinghua.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf-next v2 1/2] bpf: Reject packet dynptr slices in mutating helpers and subprograms
Date: Sun, 18 Oct 2026 13:44:21 +0800
Message-ID: <a49e4bcfaa33c4efd7e2f15e0d8fc117ca254780.1792222148.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792222148.git.rakukuip@gmail.com>
References: <cover.1792222148.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

When a helper or subprogram changes packet data (e.g. bpf_lwt_push_encap(),
bpf_skb_store_bytes(), or bpf_dynptr_write() into an skb dynptr),
the packet head buffer may be reallocated, for example via
skb_cow_head() or pskb_expand_head().

While direct packet pointers (PTR_TO_PACKET) are rejected for these
helpers because they do not have pkt_access, an skb-backed dynptr
slice (PTR_TO_MEM tagged with DYNPTR_TYPE_SKB, DYNPTR_TYPE_XDP, or
DYNPTR_TYPE_SKB_META) was permitted by check_helper_mem_access() after
commit 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in
helpers") stripped DYNPTR_TYPE_FLAG_MASK for ARG_PTR_TO_MEM.

If a dynptr slice pointing to packet data is passed to a mutating
helper, reallocation of the packet head invalidates the slice while
the helper is executing, leading to a use-after-free read or write.

Reject reg_is_dynptr_slice_pkt() (as well as reg_is_pkt_pointer_any())
arguments in helpers that change packet data in check_func_arg(),
mirroring the pattern used for global subprograms in commit
a6c1edfbe240 ("bpf: Reject pkt arguments in mutating subprogs").

In addition:
- Model bpf_dynptr_copy and bpf_dynptr_memset as packet-changing in
  bpf_is_kfunc_pkt_changing() when writing to skb dynptrs, ensuring
  clear_all_pkt_pointers() clears existing packet slices across calls.
- Mark subprograms invoking BPF_FUNC_dynptr_write, bpf_dynptr_copy, or
  bpf_dynptr_memset as changes_pkt_data during CFG analysis.
- Reject passing packet dynptrs to subprograms that may change packet
  data in check_func_arg(), preventing global subprograms (which assume
  unspecialized BPF_DYNPTR_TYPE_LOCAL) from mutating skb dynptrs and
  invalidating slices across mutating calls.
- In bpf_dynptr_copy(), when the destination dynptr is a packet-backed
  skb and non-linear, fall back to safe chunked copying through a local
  stack buffer instead of passing a slice directly to __bpf_dynptr_write().
- Update ing_cls_dynptr_write() in test_xdp_meta.c to copy data to a
  stack buffer before passing it to bpf_dynptr_write().

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Closes: https://bugtracker.nebusec.ai/f/11304
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
v1 -> v2:
- v1 Link: https://lore.kernel.org/all/68db88ada2fd01fc03f17dc7d54a705aa245ddea.1791433504.git.rakukuip@gmail.com/
- Retarget to bpf-next tree instead of net (Alexei Starovoitov).
- Reject reg_is_dynptr_slice_pkt() in check_func_arg() for helpers changing
  packet data instead of patching individual helpers (Alexei Starovoitov).
- Correct Fixes tag to commit 2012c867c800 ("bpf: verifier: Accept dynptr
  mem as mem in helpers") (Alexei Starovoitov).
- Model bpf_dynptr_copy and bpf_dynptr_memset as packet-changing in
  bpf_is_kfunc_pkt_changing() and CFG analysis when writing to skb dynptrs.
- Reject passing packet dynptrs to subprograms that may change packet
  data in check_func_arg().
- In bpf_dynptr_copy(), use a stack buffer fallback when writing to
  non-linear skb dynptrs.
- Update ing_cls_dynptr_write() in test_xdp_meta.c (Alexei Starovoitov).
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/cfg.c                              |  3 +-
 kernel/bpf/helpers.c                          |  7 +-
 kernel/bpf/verifier.c                         | 81 ++++++++++++++++---
 .../selftests/bpf/progs/test_xdp_meta.c       |  4 +-
 5 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 112ca1511da4..117d352aeb9f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1784,6 +1784,7 @@ struct bpf_call_arg_meta {
 	u32 subprogno;
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
+	enum bpf_dynptr_type dynptr_dst_type;
 	struct ref_obj_desc ref_obj;
 	struct ret_mem_desc ret_mem;
 	struct arg_raw_mem_desc arg_raw_mem;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bce7b5abcfda..9382d1d82129 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -598,7 +598,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			if (bpf_helper_changes_pkt_data(insn->imm) ||
+			    insn->imm == BPF_FUNC_dynptr_write)
 				mark_subprog_changes_pkt_data(env, t);
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_call_arg_meta meta;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 439370d73cc5..fcf0cde53f1b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3272,6 +3272,11 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
 	return 0;
 }
 
+static bool dynptr_type_is_skb(enum bpf_dynptr_type type)
+{
+	return type == BPF_DYNPTR_TYPE_SKB || type == BPF_DYNPTR_TYPE_SKB_META;
+}
+
 /**
  * bpf_dynptr_copy() - Copy data from one dynptr to another.
  * @dst_ptr: Destination dynptr - where data should be copied to
@@ -3300,7 +3305,7 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 		return 0;
 	}
 
-	if (src_slice)
+	if (src_slice && !dynptr_type_is_skb(bpf_dynptr_get_type(dst)))
 		return __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);
 
 	if (dst_slice)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec136cf377c1..d1a1a37e1f47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8477,6 +8477,9 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			reg = &bpf_stack_slot(state, spi)->spilled_ptr;
 		}
 
+		if (!meta->dynptr_dst_type)
+			meta->dynptr_dst_type = reg->dynptr.type;
+
 		meta->dynptr.type = reg->dynptr.type;
 		meta->dynptr.id = reg->id;
 		meta->dynptr.parent_id = reg->parent_id;
@@ -9616,6 +9619,24 @@ static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg_type)
 	return BPF_READ | BPF_WRITE;
 }
 
+static bool helper_changes_pkt_data(struct bpf_verifier_env *env,
+				    enum bpf_func_id func_id,
+				    const struct bpf_call_arg_meta *meta)
+{
+	if (bpf_helper_changes_pkt_data(func_id))
+		return true;
+
+	if (func_id == BPF_FUNC_dynptr_write) {
+		enum bpf_dynptr_type type = meta->dynptr_dst_type ?: meta->dynptr.type;
+
+		return type == BPF_DYNPTR_TYPE_SKB ||
+		       type == BPF_DYNPTR_TYPE_SKB_META ||
+		       (type == BPF_DYNPTR_TYPE_LOCAL && env->cur_state->curframe);
+	}
+
+	return false;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 prev_slot,
 			  struct bpf_call_arg_meta *meta,
 			  int insn_idx)
@@ -9903,6 +9924,22 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		enum bpf_access_type access_type;
 		bool known_memory;
 
+		/*
+		 * PTR_TO_PACKET gets passed as PTR_TO_MEM, preventing us from adjusting
+		 * bounds tracking information.
+		 */
+		if (((is_subprog(meta) && meta->subprog_may_change_pkt) ||
+		     (is_kfunc(meta) ? bpf_is_kfunc_pkt_changing(meta) :
+				       helper_changes_pkt_data(env, meta->func_id, meta))) &&
+		    (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))) {
+			verbose(env,
+				"cannot pass packet pointer %s to %s(): function may change packet data\n",
+				reg_arg_name(env, argno),
+				is_subprog(meta) ? meta->func_name :
+				(is_kfunc(meta) ? meta->func_name : func_id_name(meta->func_id)));
+			return -EINVAL;
+		}
+
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
@@ -9927,17 +9964,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 					bpf_diag_reg_type_plain(env, reg->type));
 			return err;
 		}
-		/*
-		 * PTR_TO_PACKET gets passed as PTR_TO_MEM, preventing us from adjusting
-		 * bounds tracking information.
-		 */
-		if (is_subprog(meta) && meta->subprog_may_change_pkt &&
-		    (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))) {
-			verbose(env,
-				"cannot pass packet pointer %s to %s(): function may change packet data\n",
-				reg_arg_name(env, argno), meta->func_name);
-			return -EINVAL;
-		}
+
 		if (arg_type & MEM_ALIGNED)
 			err = check_ptr_alignment(env, reg, 0, arg_size, true);
 		break;
@@ -10005,6 +10032,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		break;
 	}
 	case ARG_PTR_TO_DYNPTR: {
+		enum bpf_dynptr_type dynptr_type = dynptr_reg_type(env, reg);
+
+		if (is_subprog(meta) && meta->subprog_may_change_pkt &&
+		    (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
+		     dynptr_type == BPF_DYNPTR_TYPE_SKB_META ||
+		     dynptr_type == BPF_DYNPTR_TYPE_XDP)) {
+			verbose(env,
+				"cannot pass packet dynptr %s to %s(): function may change packet data\n",
+				reg_arg_name(env, argno), meta->func_name);
+			return -EINVAL;
+		}
 		if (is_bpf_dynptr_clone_kfunc(meta) &&
 		    (arg_type & MEM_UNINIT)) {
 			enum bpf_dynptr_type parent_type = meta->dynptr.type;
@@ -12541,7 +12579,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EFAULT;
 
 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
-		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
+		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META ||
+		    (dynptr_type == BPF_DYNPTR_TYPE_LOCAL && env->cur_state->curframe))
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
@@ -13355,6 +13394,8 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
+	KF_bpf_dynptr_copy,
+	KF_bpf_dynptr_memset,
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_new,
 	KF_bpf_percpu_obj_drop_impl,
@@ -13437,6 +13478,8 @@ BTF_ID_UNUSED
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
+BTF_ID(func, bpf_dynptr_copy)
+BTF_ID(func, bpf_dynptr_memset)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_new)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
@@ -13592,7 +13635,19 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
-	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
+	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]))
+		return true;
+
+	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_copy]) ||
+	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_memset])) {
+		enum bpf_dynptr_type type = meta->dynptr_dst_type ?: meta->dynptr.type;
+
+		return !type || type == BPF_DYNPTR_TYPE_SKB ||
+		       type == BPF_DYNPTR_TYPE_SKB_META ||
+		       type == BPF_DYNPTR_TYPE_LOCAL;
+	}
+
+	return false;
 }
 
 static u32 kfunc_abi_slots(const struct btf_func_model *fm)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 08b03be0b891..e1e2a6bed625 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -95,6 +95,7 @@ SEC("tc")
 int ing_cls_dynptr_write(struct __sk_buff *ctx)
 {
 	struct bpf_dynptr data, meta;
+	__u8 buf[META_SIZE];
 	__u8 *src;
 
 	bpf_dynptr_from_skb(ctx, 0, &data);
@@ -103,7 +104,8 @@ int ing_cls_dynptr_write(struct __sk_buff *ctx)
 		return TC_ACT_SHOT;
 
 	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
-	bpf_dynptr_write(&meta, 0, src, META_SIZE, 0);
+	__builtin_memcpy(buf, src, sizeof(buf));
+	bpf_dynptr_write(&meta, 0, buf, sizeof(buf), 0);
 
 	return TC_ACT_UNSPEC; /* pass */
 }
-- 
2.43.0

