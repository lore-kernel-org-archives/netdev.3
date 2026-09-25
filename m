Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAD48A8BB;
	Fri, 25 Sep 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329889; cv=none; b=rVxl0dniKi8CGA1K3M8dI/hLZK3KxuA2mf/tvBTJczy0Jtr8706lwB+CIT9JR8dfZPXJrwTnpCMzZUpAQBy5VGlD7vwN9Q/JPkKJg9yUsCqvBO5q12hH2hvcjR3s+8HnCrNT2W7dAhNoo4zTsR1oYrKJqyes8qoQN6kcokc0hoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329889; c=relaxed/simple;
	bh=R/JB44evHDRK+h4akJsgA0z5AKYG9LsDU3jXSyYklnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VnvlMjxwXfrij10qFhrdV17dGZxYBRnav6SDkwi3A/KJh4RnV/zm4xOXPm+AsKUHNIclP8AFHEMju0JWuVwxnxdS6KcSG8gkVnWDwqWA+ipgUVVbOHnyTe62Tmi3YtiBL7YYxB6+fNhex/ZzWJ3E3NtpUIdftDHZ2CHmC1GavvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=TgzyE/Ur; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="TgzyE/Ur"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ze0vszkbiHKl6TTID2Ugc5+r5HYnwdB3x7fg7BWlyyk=; b=TgzyE/Urq7LWq3gWYSiei6qSWH
	a9tLkd5oWnK2OqHEU9sPpfWGhHvlUezJQVffOp5iv4AaOZlHcR4+XqSza7sUqwZkSJOr8iOdJr2tQ
	JEdGRwm1JygAUAd4PGtAbpheSg1pN8FuZiHlyDRdL0ghJZtuZrQZW6T8JM1uccnhhuqjakredCTrw
	v53Uc2HAkYKGopv1oRof2LyerNWldEUeQ3tL3hWpYVKSVQbCkD+YUgvmxR8rp6eD0c0+bYbFjB2nu
	b3/mlh4naxQ9VzZqkG6Ra79ZBwZrZrwLqCSjmqeckYktoikoeAy4vilZHJbYuqWseofDjNqt4BzZe
	Q+gGSzoA==;
Received: from [151.115.150.205] (port=58720 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xA2aT-0000000EqAM-2Yhb;
	Fri, 25 Sep 2026 11:51:24 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] xfrm: esp6: fix off-by-one IV counter causing AES-GCM nonce reuse
Date: Fri, 25 Sep 2026 09:51:06 +0000
Message-ID: <20260925095105.446269-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

An off-by-one error in esp6_xmit() advances the IV counter before
encrypting each software-GSO segment. For N segments with sequence
numbers X through X+N-1, the IV counters are therefore X+1 through X+N.
The following non-GSO packet uses X+N for both its sequence number and
IV counter, repeating the last segment's AES-GCM nonce under the same
key.

The repeated nonce allows first a passive attacker who knows partial
plaintext from one packet to recover corresponding bytes from another
one, and second, an active attacker to recover GCM authentication key
to forge authentication tags without recovering the AES key.

Fix this by saving the complete current sequence number in esp.seqno
before advancing the shared GSO sequence state.

Fixes: 3dca3f38cfb8 ("xfrm: Separate ESP handling from segmentation for GRO packets.")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ipv6/esp6_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 2289552..05d13cc 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -346,6 +346,7 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 	}
 
 	seq = xo->seq.low;
+	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
 
 	esp.esph = ip_esp_hdr(skb);
 	esp.esph->spi = x->id.spi;
@@ -364,8 +365,6 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 	if (xo->seq.low < seq)
 		xo->seq.hi++;
 
-	esp.seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
-
 	len = skb->len - sizeof(struct ipv6hdr);
 	if (len > IPV6_MAXPLEN)
 		len = 0;
-- 
2.47.3

