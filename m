Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521068;
	b=JE+VS3cpT9R1T88UiV+9pBpAgPsCz8D5mi03fHVd+jTEUkRdvfb9Eo7J8CRa/V4MgbPW
	 DksQ9W8D4/6H9E/V0D26BIO0Eb8/3OHvWbdFYJcow+nwOuoH7XuLrnLeCtZjCUhy1lpNP
	 WCLz7oMRQz0tyuA6fos3sww32OZvn0IbWxFMvCtj+6VAtPephy/FbIkoLM/1sR4HkRBDM
	 uOLX1nSZawFj/Y1uHGGHBWNh/yLCXy8uqUwpsdPf9MkRaqJcb3fXnvETAH64JRmJwsrbv
	 RMey91XTQTkeV6u/vm1JLaGcEq5Bwu0ceDUFLjd4zgolQdWM7xb2Q2NX7jTfYKynzcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PquNKABWi0C6tGTol3B3b6YxtKfoZjVRBFpfFj8hv80=;
	b=hZdz7FI9dAwLgILIHdmdCu9bmSYOMEqGjTqTqb2EqBNs+8sPnb9GQGhxVx81O6rFcx3w
	 g9oAzSAPo79Cq7qJsjVdRqlh1u2lwpPgSfOEefBWG7lPh4yZ4uanVcP6sYvabCJYPTco6
	 Nmb4Mh7pox+dHHJxiLBtjgHKPTY3DLJoeTtgqGhdfWoxNQFgds0qvH1qImNJnJxdjAGiY
	 oOtTq4N5WQSo5eBIOF4Vzk+eN33TC+hB++H/9gF0wBFVe6EtnV6LN0EG62jecjRY1D3os
	 K7GrYZb5OUIhxz61GTSx+DhlAaG+MZ1nD5vTV/98cGGLrlbctWCFNyoOEfbFuLO4TGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guLijxjT;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC7606A329
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 08:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EC7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guLijxjT
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1136435a91.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521067; x=1794125867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PquNKABWi0C6tGTol3B3b6YxtKfoZjVRBFpfFj8hv80=;
        b=guLijxjTMJ66lfe8n6JMhPGpbFDCjjgWc1gp+wR2hHlNR2BFETzJHyZvtojeB4V0ap
         Qgwr4Nvp8zeubBiwsErHaPxQ1dx7Kc7iHSxjfoPrKEWUZsMzEYzwxmPsEtixyD/TD4du
         bbF6dCwa5HSE96wTUvihfcqYutieQhyyGuWmo3VZLWpubLCrtbKsz0pk19k16Avhp6fN
         GIhlUnytDFwfQZ9K/HjeNscYCWHrrUx9rXrg/28tR/2dZ14Vc0ohkzEocbO5MD5IQvQ2
         9w2oIAkyHdT4HMU1jnxuj+bLqxrxjRCVVkkNINuzWr877xU+8FfrXRogVQuqZYziny95
         /+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521067; x=1794125867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PquNKABWi0C6tGTol3B3b6YxtKfoZjVRBFpfFj8hv80=;
        b=BYScKuxZlv7qfrWmRx5E7or0BY2twrWdWbM64jcs2AWCpuTVcNV02O/kZkMNY3h54y
         rMmfz210SrnKBYgoo6rmCF2Lkk3k4YxYCXYa+XFF8Xzl4fd6y5IHxqk584stzSmGxEPn
         /+K9I68JKG/S3N9jgXVxKLklqoTwQ188pUoBKDNXM2tER7cbCYQEN8O3BL/lwfhHEhgG
         CAvVp4T/GLnsZJgtrT1Bc9Cj/axPYOeAhA6XSymmU9UmuK651+89h5nOoBlJ6wQrtdHW
         DHjOoDYOh3Lnt7KgE0kkXVSst/VmgafoEte/UE/bYz8zr96JiKmJSb0/dy6U9Miz3u5+
         8V4g==
X-Forwarded-Encrypted: i=1; AKwUvBwLUfpewXXvOOJe4kJnEmnfCgbtZh/atAUrm7ujvI+ytZCZmXtE3Z1Rd6xN94ZF+RRts6/KWyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N2oIFQCgy8qNJkkN7MQKP/HQgAI8kNNPhNSTfhMWtfcpx7xrb
	bBDpUT2P8niJY05d94MtGlP/EASVBjfwZtuZwknaaWHy27HZL9RMvf0H
X-Gm-Gg: AYBFou1Q+ZynHO2aRPTYfZ2z9WDGMDLwXJNmbLD+FRnZ74HB7KcM0lmZwOB+fDQF3E2
	9wZ6tB09Xnz8Dkvqh5nYe042Tr3xLWxnPAPMiyu7DvToHzzivDdqPXAaAXgj74ZD9PFyh2yz1e8
	wrPQVAZ2j+KS/XmtEftuOKwG9gthAVxbjZXWtzLhTAu0WLHXcApux5SqH+Zv4Gnt+KhtZI4QNy0
	x/5hFRdb8LsJyYvjT7ayR0RHUebqwpfxOypTJAXFHCoCjtqjrrP7+BnUudKgSSmQlJJsmla5XH8
	xQes1womdgq2RdBemmvRFtAipVxi/7FA962Rl3D7pegj6cvTw/Yi3qYmrFFEiXtsFNF0PJEaKQ3
	MoILTajLlU6JTW7lC89w5CBbCFBK7NYJWAe2OxUnICgJR8Zyz9XwN2bBN9Q/ELOFqwoKovOtnPI
	JDl+/15Vyl9e1SvdgxiKIP3GyRE1fYTQIDAgc8f4xfFtT2SaNGHdW9LJAguamHN6w21+ZY9BAz5
	0eTOfbkh7fH4UKWlmobTzjCnZUk8KXXchF7tThbOgUSnNZPIC8Qf7L70RxxvbIqLXohpBRRScRW
	AuXxTfWnWV7t8q+yNGGjYhVc1pmpvYEi9F9q62Rr4qm/6NPXZCuAtPTBNTEh/CitotqBd720DgO
	X3lAqsBcWOoM+MsbB1wo/fPvv
X-Received: by 2002:a17:90b:53c7:b0:3aa:412f:b0a7 with SMTP id 98e67ed59e1d1-3ae89559e5emr3615666a91.5.1793521066862;
        Sun, 01 Nov 2026 01:17:46 -0700 (PDT)
Received: from LDYT9Q2G2M ([2a09:bac5:cad2:3228::4ff:28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm10011455a91.9.2026.11.01.01.17.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 01:17:46 -0700 (PDT)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Finke Lennart <lfinke@student.ethz.ch>,
	netfilter-devel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] lib/ts_fsm: preserve token types when exporting patterns
Date: Sun,  1 Nov 2026 16:17:35 +0800
Message-ID: <20261101081736.51803-2-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261101081736.51803-1-zhiqizhangg@gmail.com>
References: <20261101081736.51803-1-zhiqizhangg@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dumping and restoring a tc filter with an FSM text ematch can silently
change which packets it matches, or fail to restore it with EINVAL. This
happens when userspace reuses the pattern returned by RTM_GETTFILTER to
configure another filter. Dumping alone does not change the live filter.

fsm_init() replaces each public token type with an internal character-class
mask, and fsm_get_pattern() returns that converted array. For example,
TS_FSM_DIGIT (2) becomes the _D mask (4). Restoring the exported pattern
interprets 4 as TS_FSM_PRINT. With a DIGIT/MULTI pattern, a rule that
matched the UDP payload "7777" but rejected "AAAA" starts matching both
after restoration. Other exported masks exceed TS_FSM_TYPE_MAX and are
rejected with EINVAL.

Keep the public token types in the configuration and look up their masks
in match_token(). This preserves the exported representation without
adding another pattern allocation. Initialization still validates every
type before it can be used to index token_map. The extra lookup during
character-class matching avoids storing a second copy of the pattern.

I identified this issue. OpenAI Codex helped confirm it and drafted the
fix and changelog. I reviewed the fix, built it and verified that the
tests passed.

Fixes: 6408f79cce40 ("[LIB]: Naive finite state machine based textsearch")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
Changes in v2: describe the tc impact, split out the KUnit tests and add
stable. The production code change is unchanged from v1.

Validation: updated KUnit tests change from 2/15 to 15/15 passing on ARM64
GCC; ARM32 GCC and ARM64 Clang also pass. An isolated QEMU rtnetlink/UDP
test demonstrates altered packet matching and EINVAL restoration before
the fix, with both corrected afterwards. See the cover letter for details.

An ARM64 userspace microbenchmark of the extracted matcher measured median
paired slowdowns of about 1-5% for tested long character-class scans and
13% for a one-byte rejection case with appreciable variability. This is
not a measurement of in-kernel or packet throughput.

 lib/ts_fsm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/ts_fsm.c b/lib/ts_fsm.c
index 053615f4f..8725ea6f0 100644
--- a/lib/ts_fsm.c
+++ b/lib/ts_fsm.c
@@ -126,7 +126,7 @@ _W|_L,         _W|_L,        _W|_L,        _W|_L};		/* 252-255 */
 static inline int match_token(struct ts_fsm_token *t, u8 d)
 {
 	if (t->type)
-		return (token_lookup_tbl[d] & t->type) != 0;
+		return (token_lookup_tbl[d] & token_map[t->type]) != 0;
 	else
 		return t->value == d;
 }
@@ -288,11 +288,6 @@ static struct ts_config *fsm_init(const void *pattern, unsigned int len,
 	fsm->ntokens = ntokens;
 	memcpy(fsm->tokens, pattern, len);
 
-	for (i = 0; i < fsm->ntokens; i++) {
-		struct ts_fsm_token *t = &fsm->tokens[i];
-		t->type = token_map[t->type];
-	}
-
 	return conf;
 
 errout:
-- 
2.54.0 (Apple Git-157)

