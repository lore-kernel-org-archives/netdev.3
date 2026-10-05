Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBF318EC9
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178320; cv=none; b=HB7XJXfccyTRAZi/8PJQAfY08nTlK2ui8Mu1KvS/ndJkVL3VC3hPLx+XkA+9lFeQpWidhonyNq4tU7X9RwJvY/7yamr3kt19HiijQfxLwsyB+hklPzJyGIu+59t9yecj1+EAAQ2grehgy8olU9KwE9+lHyVRszKhRw7lRdAhXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178320; c=relaxed/simple;
	bh=w1AU6g65zu16iPcWxPf1T5Zy+nRGvXgJVdBYyvWwTJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqR/BxOt05WbiH+6ijf0CzMBSG/UcOrQ3So7nSG3zuAjB//JR0KPtI9dCqPac4j6dzUPOaDHPBoX2C6Xi50Z9jco1CwoF531SbX7CFOn5lv98A+Z5W1yXBnJnMTP77iq+XqTbpzyPL8s2DjDk/JSsm3I24ELJjjMjYEbKrgfsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eut5GczQ; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eut5GczQ"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so584896a91.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791178319; x=1791783119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbaBJP1Y6rIzs9mS+9NicAQDid/y2eJWfZoQJnhCAQ8=;
        b=eut5GczQb1borskkHC9KjejdHgKsmAkVW7HL8nimz/+FfybLfz1pP7Xx/RSTtTVORA
         OEgFLzq0kLkffc658E47Rc4wi2sll1s+zYwTnTX7awc5FfotD8C4btrEqoM3Z8iKnvk0
         wGYYQ7pQbI+xWQdewG0IP2PZdeY7IxBi1rAQIQNovCjOnD2jarcFMB5jxqp+RrTCirAu
         AfNxppRmKWpFNkpJLgOOMn8VNeyH81p+cnWsWshFBvoDWAA3Tl/SqNj9+1TMbXWQoF/m
         LiugdrS0wflW6Re+4XreEnt0Y+VlMcQ9UqmCZ1EfrHtKXPe15QAiSE7GZTbLz6zCQgqZ
         nmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791178319; x=1791783119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbaBJP1Y6rIzs9mS+9NicAQDid/y2eJWfZoQJnhCAQ8=;
        b=zUdhJJwvHSHc3+z65I4yh2AhZSER9ZpjFLr5wkwh4gUiXvmqe5nvZSN2ShKVp0C5ms
         LbPUI+ArSrsSTxhzc74VLd5wjUvAg+AslW2Ik9130gcRCy7bBY4CzWZ9eBZ0f4FzyP1T
         RbjncdfKpxylpUNgk4FM7KXbDb9/SIybxYsnS5zQzaMAmiTxH28Cmz52o554gc9nNxLJ
         iBlGjiMuBCOpul89bKKIs1WqlE8kHIs9INgU58SlehvPPHxQIu/JQF3fusA0rg9WyFHC
         TmsGfOAtwvxuLtbZcfyGRUstCvQYYb8Y20ibfHjxPAvVL6yxex/4jBacFH6LGoidzpxH
         a+vg==
X-Gm-Message-State: AFq9FYIq0DAgaAWd26jzGGuJeyrsnRBHfkTJqtHk2p8o3Z+Yzc8FMzqe
	sbBWK7ZdomErs2GHGfgoPlXdCeEnp6s7dh15bK56B6vchnRYGLJ2Ukul
X-Gm-Gg: AYBFou2bTqek4qaO+pilDlx3hsFchGnT9Rl0ykJm9YYnDClAWLaKm3HKkzVhPxdC7Vo
	HJo1/oGHSLoxxcHsPJ9z7g3GN36dyZRnFSwyy1GPrNXy7sunCRDK5TyN+z6302tOkDx1fSRPVQT
	/nSyxiBnjsT6QrDKPoraP/rs/qT9FN4FC0x2LXH6K42fqOBSvjM0eQpUNpjqpXgoHSvGukFe5lx
	dV67G0AqJDXECH9GSb/LqVOY0q0K0Of+69soyJtemK+zAPk1+4sRVK7M3rKJlRXhUhxBCfUWo25
	gMsCTPh8WmtSkw6q8vCqj3517WOYSaLp9KWmRFxQQNCYZavjRE6fwhoa7dRhFBDlMG3WIhvS8Dv
	LZxN0p7p8zAfpyWBuzVYl+Qty2B1mDsB5vxagDntGde/ZrhH6+CjWRrahtmVW3nsgFhUf+XRuz7
	oRKSrZuRcqzgbVUgYQslhnzQdY1xRUQVWJe1oUU24niGiXC0qrp8zIbR7nEm1/pDbsxyQ6UjYTw
	NPV0a2Y
X-Received: by 2002:a17:90b:3ec4:b0:39e:3713:c2e4 with SMTP id 98e67ed59e1d1-3a6ce6e7c05mr7678297a91.14.1791178318604;
        Sun, 04 Oct 2026 22:31:58 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d59f1cdsm9419306a91.0.2026.10.04.22.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:31:58 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 05 Oct 2026 14:31:53 +0900
Subject: [PATCH net-next 1/2] seg6: skip the route refcount in
 seg6_lookup_any_nexthop()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-seg6-lookup-noref-v1-1-092e84774e80@gmail.com>
References: <20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com>
In-Reply-To: <20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2881;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=w1AU6g65zu16iPcWxPf1T5Zy+nRGvXgJVdBYyvWwTJk=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqwzZJh8DOcMbZNIqKDpz+ahxbhv/BXOYnUDneo
 TCKLtZfsh6JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCasM2SQAKCRAq19F1Kl0b
 TXo2EACKWn8NsBfLQ6ySDolEihbdyQDuUDwUuwY2ZD0LZYfCYIPkwLEBNfbwa5odpRkJfYFk60W
 2K/i0EbmTiQYJeMNyh9Jt/BqTVjyfAG8qwXQBj4T48CesdsZn4ZH+DkDtlOr8EynAoBTaT8MiTW
 OWrBZzHinKEGPim25EYPEVTNX168kwRAjVZTsC1I02H6ZicUFBF6oUZb05BTZg/6RrM2iV9t2Vj
 u6h0XnZ5TqtuktmhxrAaD14inkdWHQ+z8sHz9PKSgg5YqwbrAuR4voUE5sCO93GsOxywoTGbXEm
 oz9wlPRf2cjkurBrfv92qJJBkGiRMGYlYBt7fd/LjADZ7smfCDPl9+b01TKUiWmnhDkQ8IMmsBh
 NXhRGWyMm2sDJR1OcBLpybKKhNA/omP8kgfBOYfJBGOyLKa2vQBzF1cXmg7aUwprcwxGUigH4R1
 Obuc/rv0F+WHyiY4W/dkxegZqqVqieoQsZgndt/v/6dyxICyHFKFSdlEWV4CgDrlLn6vQwRefDy
 JcffhH0JYGMfjGrSMlNpOLgfNujQTsCIyyLCkurzAZOo8Wr1Car2Du1TbCgiyvE5/AaD3T4Lu54
 s/+is/t8BMZ9DONT/USHwvYc0wDZeqCgcxp/aJ/hEbyNLD9rzbRMuAIj4XwdXYXnmjXW663UOcY
 cADgUgHpoaAajqw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

ip6_route_input() attaches the input route to the skb without taking a
reference, relying on the RCU read-side section of the receive path.
seg6_lookup_any_nexthop() is called from that same section, either
directly from the seg6local input handler or from a netfilter okfn,
but still takes and drops a route reference for every packet.

Look the route up with RT6_LOOKUP_F_DST_NOREF, as ip6_route_input()
does, for the input and table lookups.

Throughput at 0.5% packet loss of 94-byte End packets (two-segment
SRH, no payload), spread by RSS on an ixgbe 82599ES across two 2.30 GHz
Xeon E5-2650 v3 with 10 cores each, offered by TRex and binary-searched
over 10 runs of 10 s, in Mpps:

  queues  cores                   before   after
  1       1                        0.735   0.770  (+4.8%)
  10      10 on the NIC's socket   6.468   6.976  (+7.9%)
  16      10 + 6 on two sockets    6.931  10.128  (+46.1%)

With the default rules, fib6_rule_lookup() tries the local table
first, and the miss takes and drops a reference on ip6_null_entry,
one route shared by every CPU.  At 16 queues that cache line bounces
between the sockets, and ip6_hold_safe() and dst_release() together
take more than a third of the cycles.

Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_local.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 0c3d1be7f129..4bde3669d0dd 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -342,6 +342,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		fl6.flowi6_flags = FLOWI_FLAG_KNOWN_NH;
 
 	if (!tbl_id && !oif) {
+		flags |= RT6_LOOKUP_F_DST_NOREF;
 		dst = ip6_route_input_lookup(net, skb->dev, &fl6, skb, flags);
 	} else if (tbl_id) {
 		struct fib6_table *table;
@@ -350,6 +351,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		if (!table)
 			goto out;
 
+		flags |= RT6_LOOKUP_F_DST_NOREF;
 		rt = ip6_pol_route(net, table, oif, &fl6, skb, flags);
 		dst = &rt->dst;
 	} else {
@@ -363,7 +365,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		dev_flags |= IFF_LOOPBACK;
 
 	if (dst && (dst_dev(dst)->flags & dev_flags) && !dst->error) {
-		dst_release(dst);
+		ip6_rt_put_flags(dst_rt6_info(dst), flags);
 		dst = NULL;
 	}
 
@@ -372,10 +374,14 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		rt = net->ipv6.ip6_blk_hole_entry;
 		dst = &rt->dst;
 		dst_hold(dst);
+		flags &= ~RT6_LOOKUP_F_DST_NOREF;
 	}
 
 	skb_dst_drop(skb);
-	skb_dst_set(skb, dst);
+	if ((flags & RT6_LOOKUP_F_DST_NOREF) && !dst->rt_uncached_list)
+		skb_dst_set_noref(skb, dst);
+	else
+		skb_dst_set(skb, dst);
 	return dst->error;
 }
 

-- 
2.50.1

