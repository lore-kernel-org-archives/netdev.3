Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423990;
	b=IP21TLsDLEfWR3miaJZ8GtBTbiRak3k4lkGNDdlA3dicQHN/AFiF+RAE1hh+3PoBqhmV
	 NtjNyCt/G20m0ay/nTffSaAxNtiGcMiybd+aYkWoCAJPcNQyKEYV8HjKSteUODp5+q3w0
	 KqxBn5hFsMku0OvnNjumoslSeHocFG3cLHiFoKSgrjNVJYVroGr60ER0ASAqk8uB0RYYb
	 PiVFj2uSAViATH6nkjUASG2Rxvf+D3ofIhtWalpFEaQLJqgeXKtVI/n6aU6IyRdBvuS0I
	 DgPrIoc1q5kMYVSwye4jgVWbu8qM1gkccZx6b4RwlR0P7lkK3dJBXxkGvwAUBcoKw5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
	b=dluo+oSNljEZHWTkZcEjcdrJ9MTcaFin0ZiyedVrYaPc1FLtQxbNoI9uaiJ3l18i6ogD
	 NlJUHMEfP4WBvWIzeQUSbSIsRk3LtZtbaiooLzgxuqWwmrhodcFwwHms18JxZPmaGju5a
	 Kfr8wI9s1bXJX/dndKuJrL8qnWg29+sCTFPJMbEJ5TMbGlsJomGppeySn+49FC8FXw/In
	 ZcJ6qxZK+ms5EvLkgs246L8IkiyvSGfZoCwTvP8QS3xWyCMzFXvXbEkQ+LiPhbC+vgyms
	 2DH69hnu6x5gTEMzO9TuWqDX2BlMLBk4NSJD/soMns0FcWcpUrnRBkRK4cGRuoJJnJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lenRNYJA;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BC606C92B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F9BC606C92B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lenRNYJA
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd63b18598dso110623a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792423989; x=1793028789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
        b=lenRNYJA1b7r4MRAtOWAg4/qpU68Gcm5za8RbKRmeR5r8YTm3kL2/4kIU/FXXJ0Gyz
         VYtJkxOuQmGbGKAIlgyfG8f5awDHKuJj35Qn77SdNbdB1eLKsTTMnBXushRIbGRH8L7O
         4kRZKigWnXEYXjK8MdD9/Ty4UMiVxjMQR/JePaMaDsWSwxDP4wpslv3Ah3JlOmjhtTbB
         /ist0AlDLuZzqOmV6G7sYXAH38eUEkuox5ZF3JNdLMW1htyIGfQNp860yOb6TxLTbFNe
         FI3jett30wj3mEzkunCmHuaSBExhQlJfDF9IOGbA3Is6zWVNQtsEhAYM/dYu3+guReFO
         QPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423989; x=1793028789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
        b=VDvkcJ05MA5zVX1dZVm8NHz4KMa+inw2be4A/pca27qJHSXJbGmZ1oDq9h5mf/SVkB
         HEzWAj5PTEoeT0D/S7iGScKyINh6ZaCNgsFbo7qNH/Ih+4mnQzIxsEmQWDgCDKlFRufS
         34yKjl+ImWsaSU3p9TF9PnrVJDpFeoXUjsTPCW+McwBhWSu2JgmAnQ2xV9I1pXdRqzke
         yPZRTdIHfKuYbule14LHPWcTrsN57fIJvtIvLz0YcQ4gA6qjXwjJB6iNk/6deV/IEDRF
         ZCggL2+Z24KBLzE4VLGM+/tQT6iqVbl2GtnXoDA/37d+0V7Oq34eWeIaUaZKCk9z52NL
         UrsA==
X-Gm-Message-State: AFq9FYJJr7loBMzioJUw9cLv7mT+pX9K49ueNzdM4nYVnlRFo+yShQbV
	MRH3pfNmZwEtVC4rytxOUK5toXKe4jPFSDtAfb25j9m5lqzQiODZPeyyYvzevm/X
X-Gm-Gg: AYBFou3zrp/v8sunowSUBI/ytt4SFxpvRS/T6g4h7hoC3aEpkYrUghMgf2nBGQ8TwwL
	vT2bhH42jZHZWHzMx/3WM+hUyGpgrPr3739GI0fQYwlbBm3iJKXV1xrVtiKkc85hFvTgfsPSjBy
	c2B69iKJniNcZiQhEoqi9tSUTuDBG69A/0p7Ely8jjERizDw2pDtxN91uh51UliaLpP1qJXlb8h
	Qx1n+tzN7/9FY+Os9Am4HJfW343CxfQdc1d/PXsz6wX+kM7CbzFD2LMOcqLKQ4Cd7ZmMQ96/Sv4
	vqhHr65tIUck80IWUVV+u2xo9bpj8cZr99nQH9VWwZ2oKFtkrw2SP/58SzKLUPJl7cm6FrGaoqS
	hMBQdVeAIvWEB9MkNPGpsVMbGYjfXxfAxUyLBviisEe/vwc1ZGIXHKwpL8LpUUq79aDz+n7RHKR
	7JckRnq/QN7kQq1u82b34u8wWiCCBhJMhFql8/cjh+m2+/ZBG7y0sdygClQuYLycCpYq9PSQ0ND
	vWaxgHZwVbPiXf9pu/lmC5mjU1W3wp8tEXt/xgw82RVH/KuB3kcNNvemCLNACPIhSs=
X-Received: by 2002:a05:6a21:8285:b0:3e2:19c3:48a4 with SMTP id adf61e73a8af0-3e225ec8d14mr13488749637.1.1792423988640;
        Mon, 19 Oct 2026 08:33:08 -0700 (PDT)
Received: from localhost.localdomain ([183.42.136.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57452b16sm4017801b3a.29.2026.10.19.08.33.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 08:33:08 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
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
Subject: [PATCH net v5 2/3] xfrm: set the address family before the early invalid-state drop
Date: Mon, 19 Oct 2026 23:32:46 +0800
Message-ID: <20261019153247.89957-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
References: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
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

The early drop in xfrm_input() for a state that is no longer valid runs
while family is still AF_UNSPEC, so xfrm_rcv_cb() cannot find the
afinfo and the receive callback is never invoked for such a packet.
Set the family from the state before the check so that the drop path
dispatches the callback like every other drop does.

This is also a prerequisite for releasing the tunnel device reference
on that drop path in the next patch: without a family, the release
cannot tell an ip_tunnel from an ip6_tnl.

Fixes: 4ce3dbe397d7 ("xfrm: Fix xfrm_input() to verify state is valid when (encap_type < 0)")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 94de4f698c33..517369ba9efe 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -487,6 +487,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
 		xfrm_proto = x->type ? x->type->proto : nexthdr;
+		family = x->props.family;
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -500,8 +501,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-		family = x->props.family;
-
 		/* An encap_type of -2 indicates reconstructed inner packet */
 		if (encap_type == -2)
 			goto resume_decapped;
-- 
2.54.0 (Apple Git-157)

