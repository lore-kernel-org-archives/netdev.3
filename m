Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA484AE123
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595632; cv=none; b=N44TSdRgTzRNzjDQKSo/zsbs8khljDarpZLa7Jt0bH6S5VtbX59v9+4TIELC3eZg8t+FcrlDtY//B6SGoKabz+N2P3HrGfJRzp9YVrO0tCTfBfRWrjuHC5PfoseqhCf5Sd9DJIg2sMH9oonWevgu1nye12rHhF/WeoDtzhK3G6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595632; c=relaxed/simple;
	bh=jkmTU6kLjQrp/ZWh8YUyvPUhmsRTOHZRaKbk3Zia5ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXKxFtwDlLQkxRk9sOkBh+mvDICa64Vlzv4bUuMx5V3slLP/AGQ84Aw/fy6eR6CeyICvoq6Ei4zu9tGIiA/7gKKrGWSFWx4vCnSAVxlEhf2c14JG0I2/lAA3wsixBCnXitOfqw3spcL6PC0Mq1bo9nvcM3CYM7QCDozKSh1E5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gO9NlEUH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gO9NlEUH"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6aae37d33cbso3866981a12.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595629; x=1791200429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBNPD+YUWd1t4bbSz2OciBQIkzq2bHOphQIUrzZH5bY=;
        b=gO9NlEUHebpMcmqQgSGRLibNLF3WWwkYvwmUSc2jnYQufl/kpl69bFeAW+duArWyvh
         ZpiuhnUdpgy40u3XM21W3oshqCIrpEBS4jPBqjcV9qhrBLMVivDeLVyoVJOsoGmF6Inx
         ODj+dNXFQFk8cmzIRDWu1C9We/+GhjQGg7Raun/rXh5XfqER3xutrKPaTvgX9II9VzAj
         BF4kN9znD2FuuA8YPcu87j8RIHBXunro84ZdinudXO+Nr7JtDhYryeWaKT5X0sIEKa7T
         a1J3cyc6MvAdMqNaPp+RXPgTOALM41fWBeTQKXHmql/zz15AiBOk1m7S8WvQ7fX9F1RL
         qMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595629; x=1791200429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBNPD+YUWd1t4bbSz2OciBQIkzq2bHOphQIUrzZH5bY=;
        b=KJGBqnBr6ftYEsqemS/hWLvZfdvtQv/yCZRIIiaTtCxRrYqYiJEoHM2vHwTgFLXvdR
         V6snY2QO8V7RzAIbP3neX0pQhOYy2CJwe78adMr4PMD/xCpsPJYcMjMD/dmqtg0zxjXB
         5jlL44qYdhU7cVoxwbopDBRNwlyfVjkFFZaoekA0KfRZ7nYUIwNKOm0jHnglPJG/HH6F
         YBjMVD8MdZZGNU1zu/+ia8PPjSjSnRwGHI59YhFVnHrZJPxDmxjftZEBbyg3gjJH6xWd
         WRYA4IUPas1+TKKUKcICw6Vq8CvKr9DytVaqf0JSbRG5dOFXMhV+duNyGGRqYR+67QL9
         oYpg==
X-Gm-Message-State: AFq9FYLZqFHgDKfFmdbOV7yzZgKSROQbmaaCGe6RF3I0Ulojm5ta3qwG
	jZq+Cj5dXQDfI0uT8K+1EsBKh16gCwTVETHkZmrSfiK5Hwx6DxEjjMDzVzrDtE0CPZ/wREeWgo4
	slTJ3KWs=
X-Gm-Gg: AYBFou3Aw3XvjMgyfL4D/x3xBOGFy8Q0u03mjtxIskJLSF6+PRUIn5kI9jwZJitEmnq
	kBt86LsUm/PfX2kvkk82JC4+DwzKZnLtabZHPsVbkVfjWnMFnA68hUx9PBwIG0bgGR3l4cxg2Ep
	mZhYdk+8h10ayqEqOipAlAdbs6I4tuaGf94eU/8nwcioP6RRLKn50ds6jUCGnj5RAjFECuiGMFe
	sbTuiAivfMCa7e/9YUJHo0sb59Dx807QnTQyIwkuLMn3Vn0sapJr8RbSuF6zJhG5SB/CLWmK3Fm
	CRAoCjaG3er9V+ct+wbVuZLACRkE2/l2STH2X8AOZKFtyS/qeNKx2rjKxaTCmPgMEwmWu5DOTyL
	1oBl+RvtcvzdSoDU5izGj2piCODO+NTShHRgTplsaHiTkQYokXE55tTA2Fv1kXoiiVJ8plFkXSi
	2AAB0xaKlNaZDKa3T5nK7bPpw4uWOgKFd8w4/oZ3xA4FmvV+CWUrSnPzKqB0XVzs0xmPe1PNCSj
	wfXGJ8=
X-Received: by 2002:a17:907:9452:b0:c29:519b:3aee with SMTP id a640c23a62f3a-c2ac23a7995mr1014942866b.33.1790595628873;
        Mon, 28 Sep 2026 04:40:28 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dd7941sm4315010a12.20.2026.09.28.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:21 +0200
Subject: [PATCH net-next 04/15] bpf: Allow access to bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-4-844dbf3e1edf@cloudflare.com>
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

sock_ops programs receive bpf_sock_ops_kern as their kernel context, which
holds a pointer to the sk_buff being processed. Mark bpf_sock_ops_kern->skb
as BTF_TYPE_SAFE_TRUSTED_OR_NULL so that BPF programs can dereference it
and pass it to kfuncs expecting a trusted sk_buff pointer.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da5d6de58650..ac7b7871c2be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5936,6 +5936,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5978,6 +5982,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0

