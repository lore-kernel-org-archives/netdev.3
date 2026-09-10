Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49A490C02
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048970; cv=none; b=pXfn96QUNLOxYbeaSvHtcSXkgoBXyz/CosgDH+QZ0+DI0w9P8Q/s6ZSd7ZMMq/jGzf4maMhzMdhKea1cb39MpiwcQ5elqRX9aICv5wxB9IfJzcU23rORGpbW6qGRy5BSi69MQhSSbUQd9jSfc6gcSzV19PNEwk5IfnWLrHpG6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048970; c=relaxed/simple;
	bh=VA+xo5HMXF3HI9AKxX9bXj3LlEqiK7o4hHddPGM/sGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAOr5DAxdYGLnU8OtYPsyQD5H4onSPJn5dBDrhAqsZAaOla1gtY03x2w4qbT46934BPLAQ6TfEniFxpddxcRkDP9jKPL+fpmNa79HLWfxzStRFNkq8I5y/95Ow2L4YZDuDm69nK4lOv1sL3tTtd9d4e9c0DLtDUiZP7NJ8MBQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sgjs40qM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sgjs40qM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2946dc8dbfso151802566b.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048966; x=1789653766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZJed2cQMd+5E9NqQcTt4Hj2yvngFWqtR3bx7uOQMuU=;
        b=Sgjs40qMQr64tX4L8pMdMNEd7YbvURccgMvYArjH5C705RM4f3GC7fZP2DwxVeXZja
         LgsSOlLOJ5RH3gJPeOZfRb5N/Q+dG5IqaoJruHN0CM4q4J65qZTPpIkVA2BZ59c977+s
         gZIqGCIz6Ky8TlL1ocqPtUX4BS50gBzjPqVFXveOlhAk2a3r72iwnpdv1563ybrwwyd1
         QT6O16uKzjTZwiy98L2dGFGg3fzTm/ZZkD+G750l4JD0xImOqYkbvGZiUCaPDwX1ZeII
         Gptd2FxgnufM3Yrw0CnXyEN7LBpB0G/lEyc7CKGUuZpYjBdY0BTs66f7fULb0zPcJ2CG
         e0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048966; x=1789653766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZJed2cQMd+5E9NqQcTt4Hj2yvngFWqtR3bx7uOQMuU=;
        b=kbM5PolsujZneKtHiyAlmcyjdGbpoDOsoKh20pOB9L+nrFd12LQZpWWz3GBlKNIE39
         KnkSSaViUqii4hUNYOZkFX/joMIxluMT53Ib3/S+12+dqayqiCkFnkR87XHhteVG1sJY
         FJgZz8oTkjB7UAfrZqv36NVZ/XtOYXAjnLKyLH10X/MEkgT9KehoKfzA3HOXCYAmJ5OU
         0aMKdCHEyrH1LZ2L8zZHQusYl1tMlXNrBv3AGUc6DVSeaTe5Lf+Ko0SeJQ0nSaxA/+u1
         66WFNk/hEfth12DCOOH2sFRfE+98E7Z4ivtVbdoTjxr0S/lV6mApKkNnluUecoCaRmmc
         eBTg==
X-Gm-Message-State: AFuF++nsbLnz9SiQ6MiyVVXHkZ2cta86J3Yb3+3MM48dsDXkyZeL75we
	CuZJa3ugxEbsle/UbE5F/uL1k74y4lGLK1emiwguwD7zCEpvfKvsja4wqZ5TXRPceTU=
X-Gm-Gg: AYBFou0fWDLXffauC+3EEFU2IOHWKItiv9B+u+rf93gLS3hM2LvcYhcEE4zBoMYZ86i
	jirP3SEndF8mX1mn6GPWYVfIlEiDX5pq+I/x/E3YnYeauHoN68n8MT6QkRrmbLhRZCTXokFLDLq
	HwmCDwvrUWYr1dzGNOx3dRRAxIVMRT61N1lIfOmGzYbQ8XM+VeR5QC9B69M2M/9jH8gabQ95+xs
	2hMukA6KxBpExx1fyonEey61pW8eIfGlATFW0jpLn5SzncEEyf4YrZSBhEnyWdeikdtgCYM3jeU
	44lE9b/wnMcMCxMhSe951ulWWUEceTKnbZ7p1xdcl8FuOj4hgdfnmSm8y1+3AjJ7tS64KOE1RVP
	lF5sQbyN+1F1klZHgdhttYa9kootLh6xbHebESEotXysq/gSAHafkYVj8zeoW9cvHCkfXwDixKn
	P70CqEd+4jTwVyiXGOae4pjxVhHTwU/qTkQbKHAIRwslDfagIedgqWtlj8CpluaQfoIvHGHarSZ
	CBLzGB/0Ix+wZtiEAcwaIoetSCuSjdlWEmSe23asZ0ioOjPeVfbYC6RajM=
X-Received: by 2002:a17:907:3e20:b0:c26:19de:9aea with SMTP id a640c23a62f3a-c2619dea888mr1621678866b.41.1789048965884;
        Thu, 10 Sep 2026 07:02:45 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa0b9sm927429266b.11.2026.09.10.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:37 +0200
Subject: [PATCH net-next v2 02/14] bpf: Allow access to
 bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-2-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

sock_ops programs receive bpf_sock_ops_kern as their kernel context, which
holds a pointer to the sk_buff being processed. Mark bpf_sock_ops_kern->skb
as BTF_TYPE_SAFE_TRUSTED_OR_NULL so that BPF programs can dereference it
and pass it to kfuncs expecting a trusted sk_buff pointer, such as
bpf_dynptr_from_skb_ext().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9029cb56128f..e82e0b4dd2ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5891,6 +5891,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5933,6 +5937,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0

