Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D6303A04
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200922; cv=none; b=jAvrMB6JgROjbikuZfB8hIBd+RPus8N1F8HqMYoYKHtxiQrbrveGXahzEGo6AZ/Dj/WYfQuy8WKdTDHHv9kPGiZ+Gpt/o2kH8bs+VnWIeYJpBfBbU/7TGAbhX9NpdYJzMMIq91WEbef7zA+wse5LEKkeZh0eoryCv2qNON99EpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200922; c=relaxed/simple;
	bh=j072dmJGJh9JYnWnegUC4HEcIamnTJExfBdocQj1cGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwFu/xA6dnkEYyKFnASEWX4EfPW1+TxFUZuCs2pFWAM1K0VOIYm49kcwHxUhdKmKzln6PY0yAQiNSTJ2OuYJB1vtGvB4+y46xMIECtV8crDLMPorY8re27Tmr7q9dzaDNFZwFKRNiSBoGpjjvRrDhDdljEePd4djBezAYXDkGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez9ioo6c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez9ioo6c"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso518435a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200921; x=1792805721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGU7UzSXLv0MNZMeCBzs4ACNNB6+IVjvaLOnGlb7tVg=;
        b=Ez9ioo6cHOI9/mex9TFv8lBM9ONoIQ6bQDaJbjZAdlbXusMCHpUWDaEdoQ3UR1Qo8Q
         645l5zLsPdTmrNaW3ohKX4/Y6IPSyMOfsUPJN8z9qcae42QgcWR5wToDYetTr7IyJ5xx
         EZqavyZLgA0aY7uFxFTHBXUgio5hxKAI5Wr4lZR23DxpYN4KSrbRbA05xI5wPiRyHnSr
         lyT9tpt5FlN5l8bPm8BQuMPaTO7XMCcwVdP3VQZbDOxWWv6Jb0pBms3sh4oHfBGgRNuB
         G30QKq8N4WI4FFX/7JmgMyGhpfe9AgpmJLpBkFItrhV46wwgLr8kIhpkM1kSOrVGP03V
         d1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200921; x=1792805721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGU7UzSXLv0MNZMeCBzs4ACNNB6+IVjvaLOnGlb7tVg=;
        b=QmtCwGGT7cyIjr1MTnwV58oLWgZlVNuILflnyeYZMdu3stm97Ft20e0gjKYnhikzxa
         8RSXYR17XETijkChOb6mkQSJvkfAj15+QWBvLtLx/r/CKK8t/xP2NBZYPSMUYw78O2S4
         8MJwuLNFvsPGrmF/+VprJMVK/Egxb9d5ArQUzuQHdm/GlIp0YFATP227xjx2Y81o22TO
         ztBcYMjNAFgjFC/yuB9ofz5LPIypKNhqalXMdYgIcNvitvo7bxQjw6AvaMTUWIDNccWD
         +1B+vty4Xqqv8oQdZmkDU5lqpLljrrNb5CTLZL1XOtBBS3Hsh6Jv22wOSXOdfv8niot2
         KNfg==
X-Forwarded-Encrypted: i=1; AKwUvBwdT+KDyyN/Pn5TTYZdi5QB+HH+dHEM4QLwvCFcV9hTYrjXBXIkQdmwYfzhwXuCHCIcZ3y5Ejo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyTOH8iZFGj8rhQxf6xky5yz6g1Xo/Q+8M2TIIc4FDHQq72sa6
	2/++gdgZD08n9bH8+5eePxKTeXDoBlZilMnUqz2OyLS0Ge1QX1RFZzE8
X-Gm-Gg: AYBFou3zi09CIK5VvFXIkHcCNVvKEnDbpx3V8aJ9cYs0qGEIxKpoO6WJkaZsgDbj9+c
	hXf/B9UigYdr+idn0P/6CuSZIf4rF9yZA9MBZAd4t6nZXqbqjSXz3It8fueap078aaEqBuMF47/
	DMkkSdyWFhcMAblHRV+pBuymglmIZcAJ0PYrFfcawiokOombRpGfGzlJSe9m5uLrmQ+hbQnKwNX
	+Hrp3By8mOmIv6jgfX58cABEOkGzZSz4N1g89t8BAWSBKbRp42rVqzZWk3+tmQ4mlvOPrUJYiz7
	fwE+LHzCCchy8oyO5xPIw2wfePOMXd7tYzxMYuSGbJWkOBoEuiIBup7OrUec6q13PhbfoV1FRWe
	XC8QoNZxQySPaOys9veD8nTsKwtMkkhPpqpAX8KzQu+Z05fvVBISTs2gG5duXKSU/UJwfPMyMv8
	WB0MBHAmPPdtSHs5jj6YecazRKqEdxWqJiHgda/bch7LHOX1thcRflH9uVsj2B/zpD3hUL62yZW
	VGftATbwaI/nldDPNl/s44cOPJMbI1PYWIuPINysjX1NHtXQpR0dCFe0y/g8HctE7BUT+iBK0xW
	TSgw8PWgVnr6EbJjbo1yA7o8FCyPpCeCWqzxr+uNCGuC
X-Received: by 2002:a17:90b:1d49:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3acef56d593mr1172956a91.47.1792200920498;
        Fri, 16 Oct 2026 18:35:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm6754771a91.0.2026.10.16.18.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:35:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 38/38] bpf: Refuse packet slices for packet-changing helpers
Date: Sat, 17 Oct 2026 01:24:51 +0000
Message-ID: <20261017012451.364800-30-alexei.starovoitov@gmail.com>
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

The helpers which may change packet data do not take a packet pointer as a
memory argument: they have no pkt_access. bpf_skb_store_bytes() makes the
skb writable before it copies from its source, and that can reallocate the
head which the source points into.

A slice from bpf_dynptr_slice() of the dynptr of the skb points into the
same head, but it is a PTR_TO_MEM, and the verifier lets it pass. The
helper then reads the old head, which has been freed:
bpf_skb_store_bytes(), bpf_lwt_push_encap(), bpf_lwt_seg6_store_bytes()
and bpf_lwt_seg6_action().

Refuse a slice of a packet where a packet pointer is refused for that
reason. All other helpers take slices as before. bpf_dynptr_write() and
bpf_dynptr_copy() can be used to copy inside of a packet.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03b19829f27a..1cf7f2e57a16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9693,6 +9693,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
+	/*
+	 * A slice of a packet is packet data under another name. A helper which
+	 * may reallocate the packet must not go on reading from the old one.
+	 */
+	if (is_helper(meta) && reg_is_dynptr_slice_pkt(reg) &&
+	    bpf_helper_changes_pkt_data(meta->func_id)) {
+		verbose(env, "function access to the packet is not allowed\n");
+		return -EACCES;
+	}
+
 	if (arg_type_is_raw_mem(arg_type))
 		meta->arg_raw_mem.mask |= BIT(slot);
 
-- 
2.55.0

