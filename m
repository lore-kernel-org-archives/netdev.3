Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B83D5C1D
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789704; cv=none; b=uBpzLhYGEO08bl4TWnIVK7mlUhSDZiam2BhdTVC/udCfzGuIvfu9bXfhFk7gLItqfPnJLNwMYevU3SVQhmDopRc9F3qJ3glQZhhKQy1yLWfbxGWH2YyMvU6Wq9jmhtjJga65TnckXOsbyZQnhKrN7NuRU8kb+b3GtLc8quTFG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789704; c=relaxed/simple;
	bh=MdSXyYAsOoLOBGcvOWfpvc3qfz93fatlLaVqLMDXGwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHVeQhpn2cHco91nNGN0+cwZR1YJbGJ5oKCT7h1HQHXk6es+lOwl+alLGoSlireRQWc75wrBGnD9NIDh6sM+5Y5fTxZAdDRQ2/4jUY3RTf7ghUiY9Dw8rV4z1Ebbzwo+IHB8HIUj5liqijmhXJj9IqmDM40d4dOGDvYuSORRV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Car0MeFc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Car0MeFc"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so141434b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784789702; x=1785394502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XYF6IhJVH4t/ih25pWa4y8XjdHM5r8QHzlFhQEmGoNg=;
        b=Car0MeFcAT/tVxKScU5ZhwSmwTYaSVFwNbqX76fuYoLVYlvL2OCJMOlYGb7i3vQwiv
         nYGpysubd/i92Ep69VepM8vW4lN0D/v1twNkQ+FqbfATCHlvaiUk11Pyeea0aQYcXmn9
         WLvxPZotY1zOvZjdNKufA9+wvzufdjHhkRJAnqgfviuHVnHaOXJ0nadwqinccLIZwNFY
         cNi5WHcVKiUl2ojmWNaJQ7KX5AU5TDXsVV9n8z1x/pZvCUBZh93XCSsRafEdmjU5lTZt
         4PExcQ8wgVf6L9sRSd5QqT5TxYroSICEzWYTRmL4ALGKT0myD22R1gq3vOG3eUVB+dvP
         tD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784789702; x=1785394502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XYF6IhJVH4t/ih25pWa4y8XjdHM5r8QHzlFhQEmGoNg=;
        b=E1NiH/iDKOXv6b7buc0L09VVSpG9+th7hB9jRszWD5zD881W1f++AV5wg7hCQay6L/
         3P1Jf0YkXaPQkFAJ0PUQGbuPSIfvK8i/DqsZBgFhznaEX63aoZGcCNf3H2gcr7eQ/bu7
         BcsSJdVfI3UjRNbAucPjdvqn97BeX4tYOcy5S6UNS7Bh3A4jGJfc5B1wogP2HxpFWwyS
         EjrUrXjBNdnHnYVFjHzNJJJKOCiqPXUv5qtz9OFv4cMDldM9fVhmkVr8RXtWJD5Zc68D
         sXvkazXGY0glDireMCcNyQRpgEextZUEMdfRRa5AK16vXbqvOyzNjlhCtxSGP8ER2twa
         ut1g==
X-Forwarded-Encrypted: i=1; AHgh+RpRb098P4ZFWZ+c5OvCFfnju2bTOUnjAy9UEQr7QqEd2vl3KoXpQnXZZZtNe2gqd3LxgnOzqYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMKlh/vRgXZZyGZLTZM7l4kuLqLJyoNGlH6fwT9xwSVKuonGU
	LReuxbt2EFMbQk1BpC57tboZwQiLY113VhzTcYH9Dtjbz2z6lL+g4qv/
X-Gm-Gg: AR+sD10YMtguOJ+NK8ExaYUsi4CqKYzVtIkL78dyQnIMGSKyTZ5oJBl9JtfyOjCb6zz
	vGDkPw5f0v88wyk3+pYypYYI1FdiTeIg3Pe8WNipSm95oShX+4lHCPvs7+Oy0si5+KjEZk+5iXc
	V03AEb9Ck8DfRTL811elui9E0WtMoRxWlBU6fX0k7KvRG8LBY25c6deonC0MEowT9le2bTkgkfr
	86LGR4KJ3vFwEja5CIIT8HOryeYsxGv3gSv7k2yxgsKj/7UHXc+vpx36RCzlwY09Y+e7T43ySl/
	X11U5w6rfVq9KZbGbRObDWsYhT8fuQFhBUfNFtNdHBaV6v+NvAZoFPBcwocxcNux4Byx5psZbnH
	MdJ7qnhcaOoORFdZJtp6cxS3vdXfZKjqgV1p1iv4JNWJ3hRiG17XbWU1VCQ61csWsGK7jBBEo
X-Received: by 2002:a05:6a00:a17:b0:847:8bd0:1b96 with SMTP id d2e1a72fcca58-84e2e8776e3mr1427666b3a.23.1784789702145;
        Wed, 22 Jul 2026 23:55:02 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17292c31sm2445472b3a.26.2026.07.22.23.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:55:01 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [PATCH bpf] bpf, sockmap: fix page_counter underflow in strparser SK_PASS
Date: Thu, 23 Jul 2026 15:52:44 +0900
Message-ID: <20260723065244.186916-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_bpf_strp_read_sock() delays cleanup of SK_PASS bytes by
subtracting psock->ingress_bytes from the amount passed to
__tcp_cleanup_rbuf(). But when sk_psock_verdict_apply() queues the skb
directly through sk_psock_skb_ingress_self(), skb_set_owner_r() is called
unconditionally and charges the skb again.

The duplicated charge is later released independently and can trigger a
page_counter underflow.

Add a charge_skb argument to sk_psock_skb_ingress_self() and skip
skb_set_owner_r() only for the direct strparser SK_PASS path. Keep existing
accounting for the other self-ingress caller and for non-strparser SK_PASS.

Fixes: 36b62df5683c ("bpf: Fix wrong copied_seq calculation")
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
Crash reproduced on Linux tree 94515f3a7d4256a5062176b7d6ed0471938cd51a
with KASAN, MEMCG, panic_on_warn=1, and oops=panic.

Reproducer/log/config: https://gist.github.com/ZirAjs/16c95c89972ace73910d9b5ac78a5807

The reproducer drives the strparser SK_PASS path until teardown reports:

  page_counter underflow
  Workqueue: events sk_psock_destroy
  Kernel panic - not syncing: kernel: panic_on_warn set ...

 net/core/skmsg.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2521b643fa05..17260681479a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -586,7 +586,8 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 }
 
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
+				     u32 off, u32 len, bool take_ref,
+				     bool charge_skb);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len)
@@ -595,12 +596,9 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	struct sk_msg *msg;
 	int err;
 
-	/* If we are receiving on the same sock skb->sk is already assigned,
-	 * skip memory accounting and owner transition seeing it already set
-	 * correctly.
-	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
+		return sk_psock_skb_ingress_self(psock, skb, off, len, true,
+						 true);
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -618,12 +616,14 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	return err;
 }
 
-/* Puts an skb on the ingress queue of the socket already assigned to the
- * skb. In this case we do not need to check memory limits or skb_set_owner_r
- * because the skb is already accounted for here.
+/* Puts an skb on the ingress queue for psock->sk.
+ *
+ * When charge_skb is false, the direct strparser SK_PASS path keeps the TCP
+ * receive queue accounting in place and must not call skb_set_owner_r().
  */
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref)
+				     u32 off, u32 len, bool take_ref,
+				     bool charge_skb)
 {
 	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
@@ -631,7 +631,8 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 
 	if (unlikely(!msg))
 		return -EAGAIN;
-	skb_set_owner_r(skb, sk);
+	if (charge_skb)
+		skb_set_owner_r(skb, sk);
 
 	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
 	 * data originates from the socket's own protocol stack. No need to
@@ -1017,6 +1018,8 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 		 * retrying later from workqueue.
 		 */
 		if (skb_queue_empty(&psock->ingress_skb)) {
+			bool charge_skb = true;
+
 			len = skb->len;
 			off = 0;
 			if (skb_bpf_strparser(skb)) {
@@ -1024,8 +1027,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 
 				off = stm->offset;
 				len = stm->full_len;
+				charge_skb = false;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress_self(psock, skb, off, len,
+							false, charge_skb);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.55.0
