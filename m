Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3841D22E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695275; cv=none; b=W+1dUX8LxrlvZKpk6mbT4fpP2p7pRsqPewkr2O9k+u2IHfx2ycXKDukyX02iHwbhLDZK1VN9dy9qZP9GIYm3jC58VshwV1B+Sk6W1wX3/dDZkSGiHGZB79PbvJTJkEMyyPF4FXaDYb0OQyiQoK1/TSumgTj5nVHJXQMJpr4qgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695275; c=relaxed/simple;
	bh=GWMIgRU7hJHE19eCMOV5fPNk6nbqQSNe9ghsyWvs5Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgxBd++GPyVrr2T7Xr7m2fzkmkAYl3Dd6Ptm9k0iTBmmIjtIy0BYXUCM5H7Oe/UGlnuTcuyMixIjYT1rqFDIxSd+iIhIR/VxFta3Eizx1EmYW1M+bjnx/CmvsaS46lTPqAIprE465k1qstgS4vTPZRMxzY3HAtjarBnq3cPGIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YDTxZYy3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YDTxZYy3"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1671ec8692so114665466b.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695264; x=1787300064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LW5lsZ0VEj7q9b4aIg7tkbaMUTRMsphp7Z75hiq3gTk=;
        b=YDTxZYy3izrrDHZ8Xi+N8Sn+SWkzkON3Rb8TVMHxXzNrg4i7YVT8Jxped2AyTQABRj
         jfB7y9mNGU5HX4R2mc/+cLKV46ZYGl+W47DhqRuIys8eo5gdCTE2eEJ7HtVtvg5wrxzx
         ckeBKQ6e0YFwkxN8bmxJehqzqppOa1atLwacHDx7zj15EwN95pWeta0pS5Si9ggpxUHR
         ntaXcwpoeoamOkdguInqAJeU5VdhfR9nCEE6VfKX49AiUHzs3VZNRd84aEieVZ9jUsRW
         uOqD8SxFHqoMc+QhO12ZYDMbLA7yzu1VbOFF9YXhpcTbJBJgyKNdHgeJsdCj1IYPBxra
         P8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695264; x=1787300064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LW5lsZ0VEj7q9b4aIg7tkbaMUTRMsphp7Z75hiq3gTk=;
        b=Ln+DB7LqKT2m8T4uvI0VsyCuoDJCqqly7KfxsM2AEgmcpMzflK8BBjA1eVoOGtdbqw
         NBWEedffHKHA8/3pMhZHZbgqj6ufVSI/lBGeDc4mzk39OnROZxPmb2EQPAsXSxDNJFEZ
         1+a1+1drZOG+8dazD0bvqjsc4Xcw6ql7DO/UQEJXhdE2cBDntiQ2dX6PbjWc6mQaL9x2
         VhDa/bA07fBBg1kkVZicGE4Fo7IHz+9PmYGYJUKsRX89PqeTFAhrEXycqjtUWu8Apvcx
         Fg9tDCUIDHtNhUBkUgz2sAwN9RLC+CXqdbH/rGms/NoVHuxP8RDOPwP1wMOSmmZ2vMnf
         RTiQ==
X-Gm-Message-State: AOJu0Yw9f+sJr6RVKdtYYCvGnY4MkTJQgM2VoquWXDCoiJRnZTapN9xU
	TMn6L+p+Sdv5O8QWqKpwp06f4tpXgFMbogyoJuvkwmlalJQqDKZYq4YCnVWB+gsEH/s=
X-Gm-Gg: AR+sD1162MdDMVKOOX+wysn9yLvzjvpcxyQ0ntASRs05W0ka/UebsIQcsocMvsl6LiT
	sLswYv5f3xmrkYoiiJCz+4owBEaTfCKi8YEYxlyyBXj85tSW/FGj6en7LGhclpqNOB0uEAR9/XV
	B2D2SCT+yorkDvKRdVYRggfdvL7mdXbh7UbAqN2861WnbQLrqlXzQgx3qKLOKc1udRObGE0Y7Wy
	damoyN9rqcszQmrEfc9ybNieg+xYrRMrIoMcUEOegJai9OgtxqpCI0f7Y2b3mm55D5q7bsmkh93
	o2WhAYUlUZc6NwrEYj1LUKZ2JtKZiQQyncAzEHbpZSA7wbC1pQwUlFnjGZA7cvTvIltpVkDKNGG
	cK2tzlFeXhkaIdXztsAAzNW4RbV7IEeIQh0/Klz3QdmftNGzima509bSyJ4SZJWloHw51yiGjxb
	zpndXPHQA36BLPACEs2kurSsLZaAze2VB+7Mjs9uO8Iwe5d6JOXLRRaJs8t0BJz9X3RhCB9Tp/g
	HxYAxFBSsrW8rPVd3K58XHN2SL2WM0SjzRETg==
X-Received: by 2002:a17:907:928c:b0:bf0:b39:dcc8 with SMTP id a640c23a62f3a-c212a1da2bamr186235466b.26.1786695264486;
        Fri, 14 Aug 2026 01:14:24 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2123787af1sm76854066b.30.2026.08.14.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:03 +0200
Subject: [PATCH net-next 02/14] bpf: Allow access to bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-2-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
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
and pass it to kfuncs expecting a trusted sk_buff pointer, such as
bpf_skb_storage_get().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1fab69fec478..b0ddaccf61b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5684,6 +5684,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5726,6 +5730,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0

