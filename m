Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101922;
	b=HXj3psmWwhAzjwQc1yFxbnfEBcAhq5QB3OKx2anWxQXuOJPp4M+O+dfYxmDnXx3SM/IU
	 y9IvKHHSJ7eaG/Axvkz6Lx4em3Ss3tqp2+EeVmQLwxd9gsDykdhPHdQaV/nHNmT91/gXj
	 6FQoiQsyUWQYFHTkIkJpk4CF3TtqdoMEropsZ4xzUR7VKCelTuWe1TzfH+vLrCNZhRZgi
	 lTDoF9tJKX3cTQvH3IBEq6FjDAru6Ybo2L3wNNZEE26FYIiW78NfV0TI1T4ghw0NATl/V
	 mOzSlM0/y7amEkad/K2fjt8MtC7qVCBFcXaVgvP/eZ6bYnc7Tw6maiY1AWAWsEvPNRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s69oIx3XXOxgLBpabmnhDrgngw50vfkdDom/Jpxm8e4=;
	b=mpS0+fnRzfMEzyOfYuY2bIeqCBN2JpyM3ReMABJXFIcdneQSIt5eV/RHPpHLhCboLMs/
	 XNdYknZd8dBdHc5oAdhka1NbGDmZD9JGmuKAlJzTxMsuZx2Bb0wFjNY4rcCCsAmMcfLVe
	 AeXkjp479wVvJFvO9EludDbMfdEAdL7aSfHU/AcRi6zW3DFy82kHOStoJb4EdZP05o3Wj
	 kyy+mtYYtPvhQENvMC0+0PwOpanmYjygvG3mIkd8WhIFaDNLz44eb6bOL8ZkHcvFWHtK3
	 qH4VN2m4Q0uv4oUAO5oB7TOhG5F9/dsJ1ibQu7CB8U2WudUcd0PDut4fjLaiiCnntmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mJf8x0mr;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE037606A33C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 01:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE037606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mJf8x0mr
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36de26cb4b3so194145eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 17:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794101921; x=1794706721; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s69oIx3XXOxgLBpabmnhDrgngw50vfkdDom/Jpxm8e4=;
        b=mJf8x0mr3nNSD6uuCKKlovranhZUDEjtUb2GPZwhhMuxWCLGmGZfvn8m/LtNphtGQo
         jW1VJcojhramXAsgAzqqZ/ZezMCRF26JUYbRfaX7KFroV4d1EmOXFdsxnXP/oT+WYcpL
         bhviZC9k5BX/BXmY54K4U403spgOBWoUpWTdz/uiolsORNV8rEZ1o146GTov2SRZyC5Y
         vhCZ0iJh/L2D5pOixHeuvJWZ+cebsMbPCdYKiSHqDRe52/8prpWEL/AFM+sZwXEkBu8l
         56GMOz1BOmIi/5vy+fMiYqqgn+c4ms6lcMqerIC1ywRV4HwMW1nR8re2Kg0gm/kTpoF9
         r64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101921; x=1794706721;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s69oIx3XXOxgLBpabmnhDrgngw50vfkdDom/Jpxm8e4=;
        b=O3xpzNGF7uO2Kx9WGRkbje5Hnkx2C+INAuTU19Akc7oNUnCv5xJ1DPCAtLm2xz+aH4
         FrSSYRhgf5nSSSUwFkUbXMXJ/p6vS4376ufTNVxAh3WbIGt9utWS7nq1Fs4OjvDHkd+t
         F0t3P/oz8W+WuQ9GXh3V5ZoETkMwDbrRU9qc6WFL+22CIAZvksJND1JaCCdafQFJvA2h
         6TT2skhZKAfmViCOH9Y5RanMqWsW0welyPHTan8PEoPFbgnNPyvt97f1dHinsvewPrWz
         ECgpeTOp7Nm2bS8v2S2wT/AcuqCWDyVbEZOHjLLA4RsF5E5n3zHogUPVWmLOZHZq26mj
         Sb1w==
X-Gm-Message-State: APuU4Z+vsyrKzYwvmqrH3+rWxXEWm1U6KwkE6T0yE3qulZSa8REcLuE6
	spAkSHCqQKB+MSJsvL98J1dT9G0VpTYgYVjwXQ1W9VuvKvgetsSyWj3FY+aBTvr9+jVbPARwXle
	vnEP0gHs6Ls2+yRcWpcn9u9A/tincvn+gMWV50nXhqcL9v3QisZ3krmmkaaWCK/zdbsJqu2BIqn
	jfP+WLYc4phZmNWoowNIdnvDS1PnsjngQJd4kBmdkzlg9pFIS3+5qFqO87CkPBptA=
X-Received: from dlae24.prod.google.com ([2002:a05:701b:2318:b0:1b2:375c:814])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:294:20b0:16f:c9db:c5af with SMTP id a92af1059eb24-1b39fe92ebbmr418378c88.11.1794101920576;
 Sat, 07 Nov 2026 17:38:40 -0800 (PST)
Date: Sun,  8 Nov 2026 01:38:37 +0000
In-Reply-To: <20261108013838.1454450-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108013838.1454450-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108013838.1454450-2-almasrymina@google.com>
Subject: [PATCH net-next v4 1/2] net: fix skb->unreadable propagation in
 skb_split() and skb_shift()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, linux-kernel@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

skb_split() and skb_shift() do not accurately maintain skb->unreadable
when moving fragments between skbs:

- skb_split_inside_header() moves all fragments out of skb into skb1
  (leaving skb with nr_frags == 0 and only host-readable linear memory),
  but leaves skb->unreadable set on skb.
- skb_split_no_header() unconditionally copies skb->unreadable to skb1
  even if 0 fragments were moved to skb1 (k == 0), and leaves
  skb->unreadable set on skb when splitting at skb_headlen(skb) moves
  all fragments into skb1 (!skb_shinfo(skb)->nr_frags).
- skb_shift() does not clear skb->unreadable after all fragments are
  shifted out of skb.

Fix all three cases so skb->unreadable accurately tracks whether the
remaining fragments in each skb are unreadable.

This issue is theoretical and was found by manual code inspection and
LLM review; it was not triggered in production. Verified with the
net_core KUnit test suite; not tested on real hardware.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f6764117243..43e720d30b67b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4225,6 +4225,7 @@ static inline void skb_split_inside_header(struct sk_buff *skb,
 
 	skb_shinfo(skb1)->nr_frags = skb_shinfo(skb)->nr_frags;
 	skb1->unreadable	   = skb->unreadable;
+	skb->unreadable		   = 0;
 	skb_shinfo(skb)->nr_frags  = 0;
 	skb1->data_len		   = skb->data_len;
 	skb1->len		   += skb1->data_len;
@@ -4273,7 +4274,10 @@ static inline void skb_split_no_header(struct sk_buff *skb,
 	}
 	skb_shinfo(skb1)->nr_frags = k;
 
-	skb1->unreadable = skb->unreadable;
+	if (k)
+		skb1->unreadable = skb->unreadable;
+	if (!skb_shinfo(skb)->nr_frags)
+		skb->unreadable = 0;
 }
 
 /**
@@ -4447,6 +4451,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
 	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+	if (!skb_shinfo(skb)->nr_frags && !skb_has_frag_list(skb))
+		skb->unreadable = 0;
 
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
-- 
2.56.0.455.g6c5a503b38-goog

