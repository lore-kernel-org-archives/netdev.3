Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE743CEF5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695274; cv=none; b=EKy8WON2BqrljsToMp6K80Mc1fES5BAzzUGWAq+34a2zShu30wzr0XVZRd9Hk5NfKXvS5cRYS8oBm1UFnOFUHJox1JFWC3J4y/+f6s0Km4+R1cNqp8jFtpZrQw0Az3H6JNz+iUOenKZ4Vx9a6LtPLWYmLG3HLYPXVIcflqgj/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695274; c=relaxed/simple;
	bh=UE5DRFZOKnQaYeGHQLt4eABPM3k+kmQkLB0O6N3lk/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Or2VkMfu8rIaZfIzKZGNSkGYMCqd1MHamiPdgMKcRNgiFJ9TznWzhWjPbLQfhhbGbhogB2EKhdId0Efvdgxjf9hi/h+T+amMUK/yQsVIYDjQGvQBHQL874Hl3mrPNpSi2o4CFlFB/bd95NjcbUVV8t00GnRC5knFzXkYgMOigQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VB/uxmJF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VB/uxmJF"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso1015916a12.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695266; x=1787300066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdS4PTcnBXYPQ/ZcnsNa4+BIFfCsI8ES9G95f05212Y=;
        b=VB/uxmJFeYRltX0v/6h1K2iV1hqfVOjYFXNSPv+u2qwfHgoKGEqeOQPjYf04G2Q6JX
         tTGKvbq9VX5ZDH3USE/5OkxUY3/VFeoz//mmpjqVXKiMzPxRIVvbqrSbBbvHy/f+9/tM
         g3gpbbpZHnPlph7P74AmxnQ+cX9notCNPOhVLMJIvrxpS61Es189jAgfVSrbM/ciMC8G
         RRKdjNprJ/y8eioVLDsl+BAs6t6fDTpa4zHdVVZNjPpastdEJ3L2fSzUqHfkogdQb00T
         dAOMrN6eijMpb6GEBd3xjXwzZdiNPI8reezbu7LP9NoLi5n8q8hz9Mck8CEgjc7ME9IR
         OukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695266; x=1787300066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdS4PTcnBXYPQ/ZcnsNa4+BIFfCsI8ES9G95f05212Y=;
        b=Rywi0mmxQNzjI4Xenu8LYDmf7s1gIzY92BOsqBsxbhxp/En/znkRJuFjh8XpWK7lZI
         CDid6G9W3qU6syFxI0xMu8zkiKdEXXyQwrLWtLIXIHz+JIurTeJD0hIwiaYkjl5XIb9M
         algO22XKU3GtD7nJSBjkCK3O006Kcg7Ov3c4vOuhiD5i/JcQYjvy9CCFeqQuqGBG9pTe
         uoD0Jcir/Fys0wf+S0wq51+qFhozO+x1rKGKX/gHcW3yB9R9wIu4gmJDmc/tSMHCml7e
         NoeHjWKppraDpfTCXT0E+S2f6uJ5qwSVgyQmMv/qTgXY6Oe5pbudpV0ISTOAGDmvq3FH
         3s2Q==
X-Gm-Message-State: AOJu0YwJJF1Rl94DSAOuAsah31sgSq5cS5fOYqvteWSfV4zpGJHoxz5b
	pNw3jbC1Z6Fw9a613oYunIiqGIKv/u9DPrPBRey7pmO1NPmeLe6+sgLszwFQN+EPU+g=
X-Gm-Gg: AR+sD13+G6D1RDGiEDXHKPCKPvuhHor5He777aTKgYGWvk0wMuI+DWaLYYUQhD8Oa9v
	r84V9Idz/P8sk8XYc789w1hk9T78tna/FQ4mxmMt9s2cyuA43Cxoq4VPUwxEpIQvQrDEiTLtGuE
	0Da6JT4NHUyT3i/oWPR0WCvsAsK0kIzRUGajnRsIdmt0ApsYgofmDN45HMVpO2UZhiSWdYCNFzN
	bPgsjCd59lOVxAJ9ZIfiJtLrUpvtqi7nvI8l2+X71IeaFbG5NQhwZiOBxK+vCMdBn4NB9WB+3Xh
	ISwVkviAJaIUlckoYlFYgBf3NQTRlF6t1YmcXub1b10eSm+MH6Mws3t8H0Ah/rOWC36NtZT1Hrn
	ua549GiIQsyrxMC7aJp+qnaAVEUyD3YMxq36fr6CkfLHMUvsidlumLfCzVIlqLC7bGDDz8IMo3i
	bWkbJfgFlzDwdzrrZiW9Vd6x9VxKGULA49GuDgo4pHb4wtBVtKf67WcQz1N0hG0tNuwYWrQpUbd
	GV1AEXLHt23MroncFlD/xgAga0eUAyFwTq6ow==
X-Received: by 2002:a05:6402:249c:b0:6a3:8586:9b73 with SMTP id 4fb4d7f45d1cf-6a38a926287mr1781400a12.6.1786695266582;
        Fri, 14 Aug 2026 01:14:26 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38d79e437sm407521a12.31.2026.08.14.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:04 +0200
Subject: [PATCH net-next 03/14] bpf: Make BPF skb extension survive packet
 scrubbing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-3-767edd862656@cloudflare.com>
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

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).

This makes it impossible for a BPF program to pass metadata via
bpf_skb_ext through a tunnel or across a netns boundary. The extension
is always lost at the scrub point.

Introduce skb_ext_scrub() which consults each active extension before
discarding it. Extensions that request preservation are kept while the
rest are torn down. When the extension slab is shared with clones, COW
ensures isolation. Replace the skb_ext_reset() call in
skb_scrub_packet() with skb_ext_scrub().

Switch udp_try_make_stateless() to skb_ext_scrub() as well, so that the
metadata stays readable until the packet is queued on a UDP socket
receive queue (e.g. for a sockmap verdict program). Only mark the skb
stateless when no extension survives the scrub. Otherwise
skb_consume_udp() would take the __consume_stateless_skb() fast path,
which skips skb_release_head_state(), and leak the extension slab.

Finally, make BPF skb extension survive skb scrubbing.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 78 +++++++++++++++++++++++++++++++++++++++++++-------
 net/ipv4/udp.c         |  9 ++++--
 3 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a4f88107c2d5..286f2e4cdbb1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5061,6 +5061,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
+void skb_ext_scrub(struct sk_buff *skb);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
@@ -5130,6 +5131,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
 static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
+static inline void skb_ext_scrub(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9947d2ed6635..700bee045b5c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -83,6 +83,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <linux/bpf.h>
 #include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
@@ -6284,7 +6285,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
@@ -7258,6 +7259,20 @@ void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id)
 }
 EXPORT_SYMBOL(__skb_ext_del);
 
+static void skb_ext_put_each(struct skb_ext *ext, unsigned int skip)
+{
+#ifdef CONFIG_XFRM
+	if (!(skip & (1 << SKB_EXT_SEC_PATH)) &&
+	    __skb_ext_exist(ext, SKB_EXT_SEC_PATH))
+		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
+#endif
+#ifdef CONFIG_MCTP_FLOWS
+	if (!(skip & (1 << SKB_EXT_MCTP)) &&
+	    __skb_ext_exist(ext, SKB_EXT_MCTP))
+		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
+#endif
+}
+
 void __skb_ext_put(struct skb_ext *ext)
 {
 	/* If this is last clone, nothing can increment
@@ -7269,18 +7284,61 @@ void __skb_ext_put(struct skb_ext *ext)
 	if (!refcount_dec_and_test(&ext->refcnt))
 		return;
 free_now:
-#ifdef CONFIG_XFRM
-	if (__skb_ext_exist(ext, SKB_EXT_SEC_PATH))
-		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
-#endif
-#ifdef CONFIG_MCTP_FLOWS
-	if (__skb_ext_exist(ext, SKB_EXT_MCTP))
-		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
-#endif
-
+	skb_ext_put_each(ext, 0);
 	kmem_cache_free(skbuff_ext_cache, ext);
 }
 EXPORT_SYMBOL(__skb_ext_put);
+
+static unsigned int skb_ext_no_scrub(struct skb_ext *ext)
+{
+	unsigned int keep = 0;
+
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+	if (__skb_ext_exist(ext, SKB_EXT_BPF))
+		keep |= (1 << SKB_EXT_BPF);
+#endif
+	return keep;
+}
+
+static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
+{
+	struct skb_ext *old = skb->extensions;
+	struct skb_ext *ext;
+	int i;
+
+	if (refcount_read(&old->refcnt) == 1) {
+		skb_ext_put_each(old, keep);
+		ext = old;
+	} else {
+		ext = skb_ext_maybe_cow(old, keep);
+		if (!ext)
+			return -ENOMEM;
+		skb->extensions = ext;
+	}
+
+	for (i = 0; i < SKB_EXT_NUM; i++) {
+		if (!(keep & (1 << i)))
+			ext->offset[i] = 0;
+	}
+	skb->active_extensions = keep;
+	return 0;
+}
+
+void skb_ext_scrub(struct sk_buff *skb)
+{
+	unsigned int keep;
+
+	if (likely(!skb->active_extensions))
+		return;
+
+	keep = skb_ext_no_scrub(skb->extensions);
+	if (keep && !__skb_ext_scrub(skb, keep))
+		return;
+
+	skb_ext_reset(skb);
+}
+EXPORT_SYMBOL(skb_ext_scrub);
+
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index af9603217444..865655db2185 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1530,7 +1530,10 @@ void udp_splice_eof(struct socket *sock)
  * We need to preserve secpath, if present, to eventually process
  * IP_CMSG_PASSSEC at recvmsg() time.
  *
- * Other extensions can be cleared.
+ * Other extensions get scrubbed. If any extension survives scrubbing
+ * (e.g. SKB_EXT_BPF), the skb must stay stateful, so that
+ * skb_consume_udp() releases it via skb_release_head_state() instead of
+ * leaking the extension slab on the __consume_stateless_skb() path.
  */
 static bool udp_try_make_stateless(struct sk_buff *skb)
 {
@@ -1538,8 +1541,8 @@ static bool udp_try_make_stateless(struct sk_buff *skb)
 		return true;
 
 	if (!secpath_exists(skb)) {
-		skb_ext_reset(skb);
-		return true;
+		skb_ext_scrub(skb);
+		return !skb_has_extensions(skb);
 	}
 
 	return false;

-- 
2.43.0

