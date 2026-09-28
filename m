Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073F4AD7DF
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595631; cv=none; b=j7/uansBp0MdxSti5x/1Dk0arG3ExCBgiko/xkHb1AU2n5xktV61PtW7hNScGeosJHvzPC7XE5DtULQWZ7s5XsZNOjvmnFmJA1wq/k+wwLG3m8KsA7+sY5jZZ2U6hZU1rEQYXDNTDjQBQPn8vZaRaqJBhVv9Ay9eDnGSmzUe63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595631; c=relaxed/simple;
	bh=Yg072b+Z/X5P8+4FVQeKF8J6w2Bq4BWX3QT22OmOh/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKZK9jRS3X8d+roOfP5F4Wpaqe5kVnO3hko4FbctVXd2xISBZNoXbXz8mX/MvtJ58D/LN+Y/Q/m+hGLCDgpWmNH67CUueQwO6RfpTLXqW88a5g2hkMJslGx6JGRoyj2Sn8p+fAABs8wWz34GreA+OZ8Q5xX48w2kFxb0WXUhXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FFBXR6xV; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FFBXR6xV"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so4568252a12.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595628; x=1791200428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QMoTFhLYSDONGaqbgqB8EA2izP8bK31Hq2jsWDZJo8=;
        b=FFBXR6xVWs/CLy8tIq/bSazCvdEcIa8erdJeEkJdSBtXWt7fG6aFTEOuRlPdnK4wOu
         044llJaATBVfLd7Im8i2ITyKuWc+IiR21Aw66MwhmdjN2+WD2im+kWXyned5ZImfAn18
         9/LkY/ds5I6rZRPJAcO8YcZegazk2Q+WCRxB1kGCwqBfMlX+1nZL1MnuFzJ6Vu/37cD4
         DwVHKcX2PlyPHG5MZJqsYbcXoKipPs58OKL6/8cKbmQYbBP1L7HxvCkgRs7JH3GOmnjK
         ivs0kmGHfrG8JkMFrvlPi7UElahdSeCejNCyBUcY3MSv+ezuq3ZN21scxhU6hIrLculZ
         dpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595628; x=1791200428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QMoTFhLYSDONGaqbgqB8EA2izP8bK31Hq2jsWDZJo8=;
        b=V48b8UFF8vqrjBIIXEWkAx9ET3C2ooazgpqDeizy53W3gSZGtYc2HYp8gJNCZVMmz+
         zEGbkoBrgekD0gAUccKJeeyaDf7ZWRgyV5ZfVShRMeMOhf+Wd09HhXUL7nDUblVsaPJy
         3jziw1pyIps/zd5QSL9FICShu74+cUDdKt2KZF3uOpkwOO/Ve7Yz17RIF0lvZ1aZFW3f
         dFpIhT/7SG85/dCzFG1ApgP0mFAGN3dr5j/rr28G+LTaqATnxbwcav/Tfz2BN+3SswCx
         IEJU9R2JSSnVnle3DgzP7sWhqahEUVh1aGKL5eOeplprg66/rbxNi/bpVyyCfLKdLvQk
         hKrw==
X-Gm-Message-State: AFq9FYLYACso7cD/gs1QNxplCt8jL1Ev8hm+i5OvVztnObqPAmM7ZF8f
	vcolY/mrUiu7rV8GhFPt2e7Xn8zG5gHLJ4hQvBKFHJrD6g4hxMtUSeVohD5vx3+BvPw=
X-Gm-Gg: AYBFou0HEqfDWHRteX27ujRlsZdVQGqHdeyT3gY98aBacYt/oKPdLHQBAG6aW+0j5Hh
	1VMMxXOVtxo6TfofcZTm8SbLlXj27z1aTiXh1j+nYYquiDsNyzGfotQZRiLmf8+WqYkeYXmXl7Z
	aBy/JLHixp1S13j25zNBwat8jlz3PNkNCFJx1B4a7P4XpK+7zpjbxdUZ9ChYAMUT26zyjBTbpai
	slyn2QzojDCUUZrBhbdm8NvqvisbZM5t475rl2CKiCzVGFUdLk3MI4pUpT791hF5SPEhqbFbQA2
	+hhY0wMMOA+uSQg90XpRYVZuwronA9dhPJdaMu/iR8BNZfBShcp1KlqTbkmIFg6YrrN0RoodEve
	gsGEppRd9hahe3TsCmeh6cKphybNdMOsHHGVMeWlLvxa4Qon6sY7ChlbEkBkXe9VS5mvPaD4rxv
	C/MfEJIenNG5RzmQ/KTpoguMfMMIgosbDTzbWNDb2vULiXnCDSTd8u/m5+C7wGCYE0i5WkL628F
	ovEqFw=
X-Received: by 2002:a05:6402:13cc:b0:6ab:373:54fd with SMTP id 4fb4d7f45d1cf-6ab03735664mr4763158a12.44.1790595627662;
        Mon, 28 Sep 2026 04:40:27 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5cb94b1sm4036958a12.8.2026.09.28.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:20 +0200
Subject: [PATCH net-next 03/15] bpf: Accept trusted pointers to kern ctx
 type for kfunc ctx args
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-3-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

A kfunc argument declared with the kernel projection of the program
context type (struct sk_buff for __sk_buff hooks) is classified as
KF_ARG_PTR_TO_CTX and, until now, accepted only the raw program context
pointer (PTR_TO_CTX).

That is fine when calling such a kfunc on the context itself, but it
blocks passing a kernel pointer derived from it, such as the fast-clone
twin returned by bpf_skb_fclone_twin():

    SEC("tc")
    int tc_write_twins(struct __sk_buff *ctx)
    {
        struct sk_buff *twin;

        bpf_trace_skb(bpf_cast_to_kern_ctx(ctx), 0);  /* ok: PTR_TO_CTX */

        twin = bpf_skb_fclone_twin(bpf_cast_to_kern_ctx(ctx));
        if (!twin)
            return TC_ACT_UNSPEC;

        /* rejected: twin is PTR_TO_BTF_ID, not PTR_TO_CTX */
        bpf_trace_skb(twin, 0);
        return TC_ACT_UNSPEC;
    }

The last call fails to verify with "expected pointer to ctx, but got
ptr_to_btf_id", even though twin is a trusted pointer to the very type
the kfunc expects.

Accept a trusted PTR_TO_BTF_ID pointing to the kernel context type in
place of the raw ctx. Restricting the relaxation to trusted pointers
without unsafe modifiers keeps the guarantee that the argument is a
valid kernel object on the current path.

The type match is only applied when the register points into vmlinux BTF:
the type ID comparison is same-BTF, so a module-local type ID cannot alias
the vmlinux context type ID.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41b49c56e123..da5d6de58650 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12891,6 +12891,23 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		case KF_ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
+				/* Only accept trusted kernel-context pointers from
+				 * vmlinux BTF. reg->btf_id is scoped to reg->btf,
+				 * so a module-local ID could otherwise alias the
+				 * vmlinux context type ID.
+				 */
+				if (base_type(reg->type) == PTR_TO_BTF_ID &&
+				    reg->btf == btf_vmlinux &&
+				    is_trusted_reg(env, reg) &&
+				    !bpf_type_has_unsafe_modifiers(reg->type)) {
+					ret = get_kern_ctx_btf_id(&env->log,
+								  resolve_prog_type(env->prog));
+					if (ret < 0)
+						return -EINVAL;
+					if (reg->btf_id == ret)
+						break;
+				}
+
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
 					reg_arg_name(env, argno), reg_type_str(env, reg->type));
 				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,

-- 
2.43.0

