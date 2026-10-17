Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36873B6C06
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255303; cv=none; b=ceac9iWfm+53JpRnBnAJ+1Gg24jPpE4pAXRUyPMRo+PeRfhL2lUMDGJSpb/FrTAwhrv9bccncMDNd+lJG/aMg9ntT9YNfPP8TOK+gyitauSfhz07s78FubEBiRmaLOPb3VpYojv85UpCBdJDfBGO8e3CwJlHYQRUG5meR567xAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255303; c=relaxed/simple;
	bh=tJigTw0JH8PMkS+hFVeAA3nZT+Ia4ZT+mat4RhnpN/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO+YZ7cEAZPSuPC+5uRiczcp7KhEV2JepNl6IYp73UQf2B7P/A8qSTjT673/wSCPG5m9+K6P42/yZoJf0WpbrXFg08F/GnSAw0E+LzVfiB9+qTOJuZg84u6iubvg5MquBBqqlZ1nl0iDlSaYcVAFAHaPe3il1IzQ6EckILn6pf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3gZZSoA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3gZZSoA"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e946155442so6448095ad.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255301; x=1792860101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFKA1h6lBnJi01euuLf1SIEyyzMcQm/kiIVNIE10hfU=;
        b=Q3gZZSoAoiryygmvXMeoO6i8Q7nWpfZX8YwLINhQEzoCDFkYOoke8+RqwuOJ/WLuFL
         /eiAI8OA2BTHE6yXEb7b7cNies2iX0QTEh6HMgPUXcKyrv6do1STEHW1hOtdWnqrwDs9
         PoB+sTFIJgbwfIdGEaxK4dUXHEhaAzZBJM12s8OGUfxgIQPppSXgoZb/PY6DlJr/SA+k
         ZyuXr+7czGh3cHaZ7Omx22tdlYn+6c2Sk14ifciRSrQe08pf5HnNs6XCkbfd3hdP4dJS
         WqbmqoLSGwp13GjdaQsYXzLW0z/IJ5V1r5gldHLReixWhuRtGjoa627CapLJ2nIxzBXM
         ImFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255301; x=1792860101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zFKA1h6lBnJi01euuLf1SIEyyzMcQm/kiIVNIE10hfU=;
        b=R3lNZrsMNPgTsuNq3qigDFBwyQlAK6QrBB/vOk3LlixYu0hqlcb7vElvmvNz793W/m
         J2oltvV+fEpbqOmjUd+ASN4O7/rKY3Gqi3Ng091X9YcVq9T6Q6xy6Y4L5Tj8bRWRR+W0
         N6RV8QEWyoLWRLH4n8IiXE4n8vf49M1Cl3mqgGxRgXUC/3dLO0xpahlDkXvntA5iZnqi
         0tgtSsjQNZLzyNRZQnPDQPgy49kdxy94OeFgKxlKb/rKaBNB7Lp3tLMdF3xgMKFnE0f0
         6zTlhrZtHwJXuvPnd+NMctcdmOFQM2iRt253PPudaql56p7hzMKWlUD3hbYKZROv3w2B
         RgGg==
X-Forwarded-Encrypted: i=1; AKwUvBxNdtvZemsjxYTxNH0/c0nI3I8PczhdaZgStpsNlijsAsdsQJWpPWNnpx47YaM4NvEBFU0Nz08=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaP+spP1e9KnpqHsq81gWsEBL/iuLzwGoaMap6E1SyDu9PKMQD
	4YBsfdldOycLrJfopUfXX+dTpB//1UJut2iAaOP8xdCOtFcc/PP8eqPy
X-Gm-Gg: AYBFou2LZYafkK8MvaXs21sIm/jMZrB3pzCKqFoyw8oTuGf8KfQ5lFiY2MN3V4A4/DR
	61DuLl1AVuzq+46sPujlfduBQ4ZQk94BTA3H7qnvsSb7vzUvSNzVH2B5lNIRAJ839beNgDWQ+a4
	OePtLUQwPczyEIQ0o+iy0yGq0uWC93Z3xDSprmf8tEouS+bDr7F4aYDkXzxds1NHxvZ/oq3QytE
	uUn47Y9tuy67trswa6Cpy5Dipuxuj8BL8A2s1s8YNMkF9rQn8LrI0avnrloE94qFAN6NIZ5jwPp
	ENIGUFpVzuoNLvNDq2aRQZUHGeULgVF+OUU5Y7MkYnJbTG35JLVUeCAnL2N8GnqkM74atQ6u93m
	wySAIAKjcfsH4Mf5yjpbSmr/Gf7SBtGOR55lU124H4dEKxg1CrWwRA93aHh3DWeZXUXhEskWBl7
	gr+b/6CV4Pc0ap4WfwvSui7aY3aHEJRcPjaGxcgeXYjO5X1kXV+PMnjyOgy7f6e9yB8InoWaEy2
	D9QAvnEaN7HwpPzHSDaC5MuLdrhMMqXfc7bNXsK/8tb3zBPMQF5lpYEhdGwrVLCm5iUFks+zmEy
	WfF9nIUPmQXkVF3O5Qc9ZjasgVteDbN7dtW6vodVtsKRWjcyUno1abM=
X-Received: by 2002:a17:90b:2e90:b0:3ac:8ee9:c8ed with SMTP id 98e67ed59e1d1-3acef101ea9mr2886999a91.13.1792255301041;
        Sat, 17 Oct 2026 09:41:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm8699361a91.9.2026.10.17.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 38/43] bpf: Don't take a dynptr argument for a local dynptr
Date: Sat, 17 Oct 2026 16:37:40 +0000
Message-ID: <20261017163745.3341787-39-alexei.starovoitov@gmail.com>
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

A global function is verified on its own. A dynptr which it gets as an
argument is assumed to be of type BPF_DYNPTR_TYPE_LOCAL, but the callers
may pass one of any type, that of an skb for example.

The type decides whether a write through the dynptr invalidates packet
pointers, and whether a slice of it is invalidated together with them.
Inside of the function neither happens. It can take a packet pointer from
its context argument, or a slice from the dynptr, write through the dynptr
and go on using the pointer, although the write may have reallocated the
head of the skb.

Report such a dynptr as that of an skb to whoever asks for the type of the
argument of a call. The type in the register stays as it is, nothing
becomes forbidden for the dynptr itself. A clone inherits the caution.

Fixes: a64bfe618665 ("bpf: add support for passing dynptr pointer to global subprog")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 597302cf7086..d384b9ec3d93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8416,6 +8416,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
 			       struct bpf_call_arg_meta *meta)
 {
+	bool is_arg = reg->type == CONST_PTR_TO_DYNPTR;
 	int spi, err = 0;
 
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
@@ -8502,7 +8503,12 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			reg = &bpf_stack_slot(state, spi)->spilled_ptr;
 		}
 
-		meta->dynptr.type = reg->dynptr.type;
+		/*
+		 * The callers of a global function may hand in a dynptr of any
+		 * type. Take it for that of an skb, so that a write through it
+		 * and its slices are treated with care.
+		 */
+		meta->dynptr.type = is_arg ? BPF_DYNPTR_TYPE_SKB : reg->dynptr.type;
 		meta->dynptr.id = reg->id;
 		meta->dynptr.parent_id = reg->parent_id;
 	}
-- 
2.55.0

