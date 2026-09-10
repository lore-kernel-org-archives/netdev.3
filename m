Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F18492E22
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048972; cv=none; b=VmTxqxjqT1t/k3nZkvBKAxhSHhOECLbtpmwmSdPWaNZv0lRQrx1l1gZbImfBCHFMcSDOM5ezQi9TCKwFLpwMOuDTCroc2I2UI5kEVYo+nwg3ighlE3H8l66M5RN+uBmsN2lo5J/D9mcGgGJwRNxcz3hCopEGmj/G4XnqkAkAWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048972; c=relaxed/simple;
	bh=cLyaiCj3QBYpac/QkfMsFPlSx/mFitzO1+OunaflwLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFUNyRiMdpWSwkgRFzfKz156dNLyGKfvKJ205yLd9nKRVstP8dU2KcyJT9MLKnG56B7+X7FgNat5yxUpQG2FJ+9HuxPtYUlVT/Sr0SeImw/o39Lv0b0dZ2rixaQ4UM0jXXJvhO9ee8W1P/8ZJ7DqMrP/ZlIdpNbP78Gnhd8ZjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J/x4qGim; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J/x4qGim"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a63667b78aso11500483a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048968; x=1789653768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbXf8585cFr9URoNTZ3Ji2Y85DOqLtjzR+C/8UskNBY=;
        b=J/x4qGimgGaz8RyECCWXfg8/CObvy4OZ1cSZw05UqM4+FuhdqvFo76d6It5cBunRMd
         vJyzm/k5m8J8r+c6ruuN3gtHA4D5c69urmq1VJJOLEXRWzh8xrypMBH6XNUUVOuzDmdt
         J6ZLDMA61iEkgTBMtIwAW0OhqyFy/tQL4eejxHoCg+iNaosNIQZVKr9zuBlEIOsD7zNo
         +yhyLpzkctt6spuu80M8Rrbxl+c7JTzLnRDjxB+a0WiS4+uh5xTfD3hwW4oBCNcgrOOk
         hUe4p8vNQna1nQD2Sfp15wMP7ynBbcwHp93LvQ8yOrQIw+J2IYgFVRNel/9Li004A526
         hE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048968; x=1789653768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbXf8585cFr9URoNTZ3Ji2Y85DOqLtjzR+C/8UskNBY=;
        b=BiPZd4r08aohgsjTXnVlfDd1ZEmbOgtDNPQA/2oX9RaedJCVQ80eyKyxZ8A+krqbm1
         b009X4WfrvK/iKm1tr7VAT3fSzjtBZOiGwQfHP3SK30Kb+2fTFHz+NR7w7p7mNntqOS7
         8jwmW1ns8bpmS8Y5WorcqkOBiXW0mpeAiW5xyYz2HU2sN5jnPU87nSixXWLggtnNTUmN
         zlvasAdJe5wO0DctiUVYunZJndvdy35m8EJQqqrNi1LIrDkNbYsOCCSiX/hiyvcIkDWY
         q75czxswPSQXx2FKnznIUZPWwkdJAP+goLSgyeZWy3URIKl8aSh7/+0zczBzQGuFd/0t
         iuEA==
X-Gm-Message-State: AFuF++nKjQI16O20Pp7ilxErgep9T1kaqXJnwRQoPMFPKuh5UHhia0qN
	BGONQDTo7qpzKTIicr3euyFfeyyA6RvzvNXlHktebT6ojbcpzRP2KQ2nFaC6KEhcRYc=
X-Gm-Gg: AYBFou1JGb/Pd9AcjOUNhKbMsMvFZwsv3ujEfjB3i/p0D0WbvoOmIqWmbrO69/mfAbg
	45/QTz6Khi1bkFr3J8npGZqFNvhe8vWybXvFAo2d93Xr29xkBUImACoWtfSzckI64krOo7vCLNK
	+TxFSujzP5Xu5w2u+z/j8/z71+JQUANG8gF0ra+KED9fvecuA+4DF9mqekmYg3dt3DNSl+M+Mju
	4/BCQptswEQYTOWQDhU/gK+T+frRU9aSHBm40sLKI1xihG0K5IRCdQI1NpzfZG9FjE8NzbvDZmW
	yO/7Jc3DFHtmM9racwxFA/g6qFgCP/w28CohqlbbONBLwZNPTU9VF6C6+Eg1RU9X1elhFC+Ys0b
	QsJy6co2Qjmq82sin7SqcfJZJWxagELZaVx9Vng0krSL+CX4oKgL73GM2ynUHFOhiIG5Mvj2Rnd
	MiHrL6S2IEBSgZxa3Sz77sbLuNztEZfX0G1zNX7aylxoQFty0LKeTg1CdzYoon1pa77UmzrbCCP
	YA8fGtb6M+WxWlP+GQ8weFXu/bP2xnsrA4IJ14kh6ycoPv4
X-Received: by 2002:a17:907:9345:b0:c26:2ff1:cac2 with SMTP id a640c23a62f3a-c262ff1d066mr1340591766b.31.1789048967439;
        Thu, 10 Sep 2026 07:02:47 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5921e2sm918728566b.46.2026.09.10.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:38 +0200
Subject: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
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

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
etc.) and cross-netns forwarding (dev_forward_skb).

This makes it impossible for a BPF program to pass metadata via bpf_skb_ext
through a tunnel or across a netns boundary. The extension is always lost
at the scrub point.

Introduce skb_ext_scrub(), a selective variant of skb_ext_reset(). It
deletes every extension except SKB_EXT_BPF. Scrubbing is safe when the
extension slab is shared with clones: deleting an extension only clears the
per-skb active_extensions bit, and the shared slab payload is released
lazily by __skb_ext_put() once the last reference goes away.

Replace the skb_ext_reset() call in skb_scrub_packet() with skb_ext_scrub()
and also switch udp_try_make_stateless() to skb_ext_scrub() as well, so the
BPF metadata survives queueing onto a UDP socket receive queue and stays
readable there (e.g. for a sockmap verdict program). Only mark the skb
stateless when no extension survives the scrub. Otherwise skb_consume_udp()
would take the __consume_stateless_skb() fast path, which skips
skb_release_head_state(), and leak the extension slab.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 24 ++++++++++++++++++++++--
 net/ipv4/udp.c         |  6 ++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0202bcb9338d..509d447179e1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5091,6 +5091,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
+void skb_ext_scrub(struct sk_buff *skb);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
@@ -5167,6 +5168,7 @@ static inline bool skb_ext_shared(const struct sk_buff *skb)
 static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
+static inline void skb_ext_scrub(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
 static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
 static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9c03cd7c63af..a479e25de564 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -83,6 +83,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <linux/bpf.h>
 #include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
@@ -6290,7 +6291,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
  * operations.
  * skb_scrub_packet can also be used to clean a skb before injecting it in
  * another namespace (@xnet == true). We have to clear all information in the
- * skb that could impact namespace isolation.
+ * skb that could impact namespace isolation. Note that BPF skb extension is
+ * meant to carry information across namespaces by design.
  */
 void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 {
@@ -6298,7 +6300,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->skb_iif = 0;
 	skb->ignore_df = 0;
 	skb_dst_drop(skb);
-	skb_ext_reset(skb);
+	skb_ext_scrub(skb);
 	nf_reset_ct(skb);
 	nf_reset_trace(skb);
 
@@ -7307,6 +7309,24 @@ void __skb_ext_put(struct skb_ext *ext)
 	kmem_cache_free(skbuff_ext_cache, ext);
 }
 EXPORT_SYMBOL(__skb_ext_put);
+
+void skb_ext_scrub(struct sk_buff *skb)
+{
+	unsigned int id;
+
+	if (likely(!skb->active_extensions))
+		return;
+
+	for (id = 0; id < SKB_EXT_NUM; id++) {
+#if IS_ENABLED(CONFIG_BPF_SKB_EXT)
+		if (id == SKB_EXT_BPF)
+			continue;
+#endif
+		skb_ext_del(skb, id);
+	}
+}
+EXPORT_SYMBOL(skb_ext_scrub);
+
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b3887c42adfd..cf093b0d66c5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1540,8 +1540,6 @@ void udp_splice_eof(struct socket *sock)
  *
  * We need to preserve secpath, if present, to eventually process
  * IP_CMSG_PASSSEC at recvmsg() time.
- *
- * Other extensions can be cleared.
  */
 static bool udp_try_make_stateless(struct sk_buff *skb)
 {
@@ -1549,8 +1547,8 @@ static bool udp_try_make_stateless(struct sk_buff *skb)
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

