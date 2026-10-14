Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639618;
	b=v7J0mkB6/AJ3MO5M69u0JGbkGdPkbPdf7r/hS5aAqu4uAmAiBTWq9kk3xA8mc3LGb8FH
	 eL9pqP6B7gOba3jCEue3Hl7UZLAO84UNnwS16YwXNN7KwiLr/UPjcScgxtBjfd8gMgG/4
	 vu4V2jkXHGyQ3ct06d88rLQ9rEFJTeXDQg1XuEEMO57Z2HWm0wqcfTrNf1u/qn6JLviha
	 dhlOl9oVTJONaWw+A6GQRf6fXBkb7y3ikqo2plRV2N6v6Ggkx62RrElV0cXGX4E5r6YaO
	 Bfqzg4Q/xWUtl0XU5q3tLjGpIWfODH1UH37uL/5VeJYXZKImZr6PuiKkdJwx1KLeVvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:
	 In-Reply-To:References:From:Date:Subject;
	bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
	b=5oQQIY/rFMlIRuci0UzlFdsA/lJ+Pj6xmZJtRmIkAoQBd21Mc62CLBHGzOULtvkX6OvY
	 duHESkUJCu2NtFYcfT2GlnCp3R97dk+cOUj2cBWCDNfiEQkaoBbCdsU86wMT9pPQfrrZH
	 IyP7WoP3/XTnBrdpYQfXqiDRu90HsdBnr+HN48zmuQSEgk269ohreDE2jnnfhVruQdFMl
	 qbr+sUw/T81+1njAflBvLeXRqNaODxXuRNJDqMVqsrUZHEy59TZsgU4gVaTjfBwR4SFjY
	 nQ7qhcYMEFLlqqM1anm57dRmYOS/R27mtFOWZT703U4tQynE9Pv2KKOhDvhRPN1Mq7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RenVvBTx;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96990606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96990606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RenVvBTx
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-899b7b55c89so124763b3a.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792639617; x=1793244417; darn=vger.kernel.org;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
        b=RenVvBTxZ+Mns3K9tLrV4+1ovu/2xr3hcpTL7DkNDbOTeM4gnqUSJxEpD8avUSPXI6
         qov18BSMaXFgrcGoDxo6FWDlFuubqeR61Y4PDxPLdp9ilCDoo+nAm0OkWwEskAfDMlaE
         y4Ncd5Xxo6VBEpZ3QE6VBu/UBpEWzA03W+iy52G8Wh9YASgtxm53UhxQ3TYYqXTygAuU
         1ViQbjBrAloqMu2fUJnE6kkBzSOlYtPz0sJHu24PJo4kA06SerkDybRmprACcxj557zz
         mYGFkCLMxSNv1+cb19tamtvttLwetH84mszKLVm2JlRHPA6xWheNQlS5vFBqAu1POg+C
         oAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792639617; x=1793244417;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
        b=EfjDiJYgzTbvEMbm1FXbZE2iX9t5+cPzBX+Cn0Oqwucm15OyqkSCwkXqG1Xn6HklSI
         HMBgXitD1k3Mkka2TgcKSBkLooT9mPYgxBkr6O0suVBl2QhksF5nGGLqTzT2EJQZ6H/K
         BkPQeNOXh3ndJ8xRmM/JR6QpAKCo8joZLB9a3NFJouuJmauH9Q7WgGUv+sPD9fY0reQP
         /gzZIhsajn4bNQwY+edcZvXB1K/F/DyXbr2p51bRQLZotU5bPPgJ4Xx0iFXUHsFsJTnz
         uRyitskvLQneY43+LzMolv1JJHII0JERkH6YgJGcGsZBI7FnSj1b8y3pzjJq+jJE7iDP
         aunQ==
X-Gm-Message-State: AFq9FYImB0gM0jd6SG7YE2fkr5clHKK3SMs4Iya9qIhY0B1Tu+uhdDLX
	u/lJbAVcclGly+NbdyW0st8amgb97+bXyYhHLb4U6G72BnlqFbMVtJO9
X-Gm-Gg: AYBFou1vOoiZRJVOmG5XD8vse60qsRl51a1MIoeL5fowdFQL4fYmcZamHZeWEdMEKLS
	XUrHN0TsiJM7G2ESZ2VWuOcK8gI/dKvLYL56xlZ/V60pcTaARbU0F0Y7/z9onGVFc6djIq/jslp
	7+5H3q2rLdJbe5+wdIJwGkCgSyzJON2Ye0V647w9oC0AmdLQUfy/3OWeUyyfCs1vkzmqRVYGpo3
	C3PA1C87WxuWH7StwjYv5irv5YUQuXkTizNWx2YPmMqMIUNTc4WTZvOc2DAwOkXkK6GzPxLr4RA
	TwhlvuMp2WxI428tiFT0plmLYS2SJkV3l3cUIW7eDU9enq/PuH7BYiUt5j8253R9bdyIkxi0ZAL
	GRJrynDdKH4GrAPOpxAlcVoMiHYaEpCq48i+4cKvnI+nBZ8hM9glSCuD2R2uwsdE9TbsLoxcwb2
	ObB/C40gtaU7VJgbbyJZsaNKF5sg2iwvxO4PfN6zH5aNUuYPCOrP5ShnSUBvIFF3QCyGeWCTRlR
	zw4ZajZ9GGmXbrZDgTj19tlWoAv3DDj0EiQH3NwzFCHCniB771dH5q0oqhCSGc/j8SkjSJ2RRjq
	tyi2rn2WhOFOx7Qu5lY2KA==
X-Received: by 2002:a17:90a:fd8f:b0:3ad:a84b:df1e with SMTP id 98e67ed59e1d1-3ada84bdf58mr1133264a91.1.1792639616869;
        Wed, 21 Oct 2026 20:26:56 -0700 (PDT)
Received: from msg ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48ed719sm2049343a91.5.2026.10.21.20.26.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 20:26:56 -0700 (PDT)
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
Message-ID: <20261022032129.16118-3-q.h.hack.winter@gmail.com>
In-Reply-To: <20261022032129.16118-1-q.h.hack.winter@gmail.com>
References: <20261022032129.16118-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 14 Oct 2026 21:17:12 +0800
Subject: [PATCH net v6 2/3] xfrm: set the address family before the early
 invalid-state drop
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

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


