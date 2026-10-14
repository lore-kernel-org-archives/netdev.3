Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069459;
	b=Yx6vV01hDE6egkKI5OHM/C86ze+zExE5JwMM91WtZP5KmvUkNpBjbJuBiLEAl+/7elAa
	 fBsonTlq+mcYF43dJA9WMk0h2/WI5zg0QIgqjNZkFZQLPEQb/BzIFGVn/wKyqDv95/E0p
	 ArFdR656asNwfY3Ptj6timwKReGYgST8cTB4/VAvZFXQ6j1WD+htFfb7r9uR9tewgIj73
	 muG7gUIQ0boShoQvffEhq1W603pBFa+nYybbCOcusdVVHTtxR0H3o+gMApX61fgIu4Rbd
	 MDeSK1XtXEN4wGdEx9AgxY3ef8OxBCNXKhFHs/j6lndrmzAj7wIri1st4vBit8WOMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:
	 In-Reply-To:References:From:Date:Subject;
	bh=eK+WYOUFELHHjea/x0NYiMCaugcTpDunS7GxJSBv5co=;
	b=gluPScGlc0HPbERx23lmvpSarVZ/al+2n7738i7J7pHDfvaIC8heY5NeDksDNfUZtYt9
	 +eiSyAJNVx9MJYWr/dvcKAc1dPCCMIpCaG1S9aHJQofSrMk0hBewnxwYJ5izNdQDrMOya
	 5Uk6OJwEr9tWZq5DXbfy2MobD50rRv51HA44SeKZOr91c4UyOQW+3AD80KxYgpHe02JXU
	 qBgC8VQD0CCf5QQfVNQJQZO/Z+CTgSWdTikEkNiquQbkrm/PeOSQlX7ZAXZ5eUCzPzZLo
	 zaMBUvrFWEd6qsATE15mMnAP/nD7qZ0yp/BcXhiN/Ujp5HmdrENGaPRKc+4W5w3oTNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VFoYJa03;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67460606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67460606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VFoYJa03
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e74a32a07fso3709665ad.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069459; x=1793674259; darn=vger.kernel.org;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eK+WYOUFELHHjea/x0NYiMCaugcTpDunS7GxJSBv5co=;
        b=VFoYJa03ilUbofE0jNoZ9YmZxV9rormaKeZkCxpOyO1ERKeRWbNuUPgyDTMAwCSqGG
         9xHorPDHGNChsMYh2uinruRGJ0QsHxRSLq9q2dE12TO7sY6Hj9HUOdS4WxfvrjvHE5ZO
         WX60R3P1k3s4WKJliyq/ICieZqt2aQSLEqlG8xrv2eZinjW4jvLKTazuyxvfnAa/0sfz
         RtukRxEWs2rpfvYfFzBCIi8A+toabrx6tvv92Uqhd9WVj5jykUnwn16G+FEZYHayVFPL
         FGfU6ILt70urw0lVhdUS2MGdPqxxPf8nudWLoe7JN/z3pynYMRspo4YNQTX/nhJkPDh0
         UZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069459; x=1793674259;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eK+WYOUFELHHjea/x0NYiMCaugcTpDunS7GxJSBv5co=;
        b=rYEPhWUxeGddPFUcn0fNGyI4c9R/9M5dTM8Dcyxp/MkRpAqDLjXEh/Sck7rvKlI6u8
         32HfksbeDevoJiNFPaUcrwik8m0shvbd+Ztaeg+Y8roySvViDszUyy7E+sf+6T2lddMM
         7nPxEHPD7SbE6otNNFK6bD4HuHihu6Fmk77H1fj4pP+CQmD9igXxHPjDdBUND1zQUWOB
         EDzKjK3KTm4Uo66ttvCysiN4hF760A0Sa16A3q4vs0wzZlMcVtTmQ0F5qucd4JQe18kk
         FdRomHrfu/DMlay05d3A8/DIGeaRUgqoMZ7AAbEosbPXrf72XUw5AIhJHPX0Up1Xqekk
         h0zw==
X-Gm-Message-State: AFq9FYKYRiCnLFU5BZ1E+7p9+pXbLHmoBA1OvMNiIddIH7sA1+PX2oqN
	s1YTNVwD9m5HLZonnfK2kW/mA1P/+J4Fzms24eZAd/EkTYtrrWLIxnXN
X-Gm-Gg: AYBFou2H8qhHnF5MUOnsUvA9s+1zC5i5puHIRaCHOFuad+aytPXy8kX5O2v0ieNjg64
	rsuqWqmQXr5lIjWVxMCv10gMQe7wES4GLD4gLMocrqqEjJEa7QzEjpJLzO7xgOzAB1bGMXMekJH
	f12LiiG9EaGNLDXAm78Aq2QEljGaPmY/Mh+2hJaqvv+7BnVQslwqibL+fkJqBEUsTt76y03dGaT
	d4Pco0jRclj0qdi83QMFcAhFGtwXUBxn/VRDDV6QmB2M0pPIsilnGe8d1OA4Mhnt+7KKzdpOscr
	+ah1pvhrrf2rvgsx/05GICVAyeGwsAP9LTbFQEr6gl0DZyWhjOSawAn1vFYC5DSYpHZVNbHnJVc
	DH6766hi0uU9/ZlfT/ld0A6+Id5So1rSwMLHNDtoeGCVG7pr8/1e1g5l8+gM/Wd88/JHIqe6dpa
	7IobgxWN0zjwVn+hcd4oEoGuazkjdHOQ+puzhVmKRf6NNlKz2xgE9ePeB5E4PHJCo6BzFITWp2a
	SEFtaulMKOr2ejbltygQmjVoPE3WoD/E3yLN6EZw5MCEg/Gv1kumYamL1UtXy6wB/v6GNlYu+mI
	G2GOQ5xu7yGusilXbylUPscvWCpKb3Ax9ORyHAfLr0EWHfGz/rzZmH/wgo5oeKDKR9G7Bck=
X-Received: by 2002:a17:90b:2e10:b0:3a8:1759:2217 with SMTP id 98e67ed59e1d1-3ade9e52430mr12674925a91.2.1793069458756;
        Mon, 26 Oct 2026 19:50:58 -0700 (PDT)
Received: from msg ([188.253.120.77])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc90d74sm2052536a12.20.2026.10.26.19.50.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 19:50:58 -0700 (PDT)
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Message-ID: <20261027105031.19928-2-q.h.hack.winter@gmail.com>
In-Reply-To: <20261027105031.19928-1-q.h.hack.winter@gmail.com>
References: <20261027105031.19928-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 14 Oct 2026 21:17:00 +0800
Subject: [PATCH net v7 1/3] xfrm: use skb->dev before dropping the reference
 held across async
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The skb->dev reference that is held across an async resumption is
released before skb->dev is used, on two exits of xfrm_input():

  - the drop path runs the receive callbacks after the reference is
    dropped; xfrmi_rcv_cb() reads skb->dev->ifindex, so it can race a
    concurrent teardown of the device
  - the decaps success exit calls gro_cells_receive() after the
    reference is dropped; gro_cells_receive() reads skb->dev

Use skb->dev first and drop the reference afterwards in both cases,
matching what the transport exit already does.

The early drop for a state that is no longer valid releases the
reference on its own; let the drop label handle that reference too.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
v7:
- also move the reference drop below gro_cells_receive() in the decaps
  success exit, which used skb->dev after the reference was dropped
  (found by the netdev AI review).

 net/xfrm/xfrm_input.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 5ed87d51392a5..cfd5cea033127 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -496,7 +496,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(dev);
+				async = 1;
 			goto drop;
 		}
 
@@ -747,9 +747,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			sp->olen = 0;
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
+		/* gro_cells_receive() reads skb->dev. */
+		gro_cells_receive(&gro_cells, skb);
 		if (async)
 			dev_put(dev);
-		gro_cells_receive(&gro_cells, skb);
 		rcu_read_unlock();
 		return 0;
 	} else {
@@ -779,9 +780,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	if (async)
 		dev_put(dev);
-	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)


