Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E6363097
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205590; cv=none; b=gzK45ehMNiKt3PoL7QcK4jN4y0jbJYVhSIVunpetXEtdcfSZwn8bDRSgPzb56D+74zUKakg+sFYK07TuAK5F5D3lzWa9eotKrU9h2ggVxcWuNmMbDTMkONtT3kF4QgA0TWWyzWtXUDVjV4FQXMloYxChMnYTlPknbN+233/DJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205590; c=relaxed/simple;
	bh=Re3FEq9QGggKSm98Ro8MAdNh+ALER15Rg3B8nWrg3iY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i/XSqtqlPostIa86xTsccdSemvfVF+FstilhtEzwRvr3DUnd2N11eBuRt5tGb2ZPdBoVLOavgCU0eYp+H/9zwLe3R8PB1wbvPEQjMtzyv+N8DSO+8j/bTzaCKyZl7XwjUqBwMOzgg0caDHX9jxIJUORc1l3eN+iH018WbN4MFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPF9u2Zf; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPF9u2Zf"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa34873bso19460285a.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788205588; x=1788810388; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L8WgGAXGH8xTW9laYYHYVOy3cGdfh/tRDSqucBl7R44=;
        b=FPF9u2ZfCYygbgDUBXMYt0lfjNgbzPLeO6lNznVocgNl8iLCK4nKjm8K7YBWsz4erf
         dgcG12yWDuBAkv633H2xpJorxSg5nVnUaOHDNH8BGdu7K1VGzgCOho9tGGHm8e/k2PTm
         tqkVoizB7fAdOuDt4velmeKCJF8YhzxY4Kd0lIrpVoJQBt1uOE7c4etiawsHtq2CYxlq
         A2SLY1zDMxSU74lQT5zANiKDmI+/el1VYY2nV30115T5diEA+p0MDw+mlyJtkiyU/IGT
         Yb7sJsA5FihH0EZdknwSv/IA3zCwQ/OyZnjtvZ91QBlBb9HX0WnUh/zQuXRkGP0J7xyJ
         WMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205588; x=1788810388;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8WgGAXGH8xTW9laYYHYVOy3cGdfh/tRDSqucBl7R44=;
        b=TWu2KoIyDxal9U+aYXmWslr5ezgh0RRwi1la+JOV8qfV1QQ5hxiHergH4ICZlOfRe3
         xecGcUZbzv5acmkWk157lV6uXlhcN+0yVOPyucKg+SP+1adgw/92oz8O9vuqFfY2pQTu
         /xQ1dkkjHrlREskjlfMnQBfBausFIeQqznWDzYh/Hs41yArltvbTOCUqUU0C4+QD9Rht
         4pT99LPy2dm6kJbVDraaHqFLHg71FGuTbQr7OLszAr1Z0AHCQcQfSojbx7YypgJXMT7S
         ecj3OVXBeOTVNiwtOzo4JAII2V/4M5GJ7c7WvUi/HJJ/yKt6vFFTZ4pjeuG+7dGUrtQD
         i1Cw==
X-Forwarded-Encrypted: i=1; AHgh+RpEfQWk07iCZxKsMNPNzlcV5T5dwqxB4J+xV7EKXljKgP6P6ppUJ09iW5+hJA+6Tz09xkAIimA=@vger.kernel.org
X-Gm-Message-State: AFuF++kc8wt9B4BBMM3J1UNjLEtXahRWEoX0HIfuzXD6O2gIFplK0J7s
	hfDNDtoyG7wadqKz4twsx85nwPnaHlKZV3ZnXZBqKyul9E/LA/3t+QIDg1gvfWw7tfu6thQkEeY
	gdWaEiWC+d/XcAw==
X-Received: from qkjb14.prod.google.com ([2002:a05:620a:cce:b0:936:e858:f658])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4402:b0:939:1acd:7d9 with SMTP id af79cd13be357-9391acd0d2fmr2239145285a.4.1788205587480;
 Mon, 31 Aug 2026 12:46:27 -0700 (PDT)
Date: Mon, 31 Aug 2026 19:46:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260831194626.119371-1-edumazet@google.com>
Subject: [PATCH net] bonding: alb: fix uninitialized transport header access
 in alb_determine_nd()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>
Content-Type: text/plain; charset="UTF-8"

alb_determine_nd() uses icmp6_hdr(skb) to inspect ICMPv6 headers.
However, in xmit paths (e.g. packets sent via AF_PACKET / raw sockets
or forwarded packets), skb->transport_header is not guaranteed to be
initialized. While pskb_network_may_pull() ensures the packet data is
linear starting from the network header, it does not set or adjust the
transport header offset.

Dereferencing icmp6_hdr(skb) can therefore access out-of-bounds memory.

Fetch the icmp6hdr directly after ipv6hdr following pskb_network_may_pull(),
and reload ipv6hdr in case pskb_may_pull() reallocated skb->head.
Also remove the unused bond argument from alb_determine_nd().

Fixes: 0da8aa00bfcf ("net: bonding: Add support for IPV6 ns/na to balance-alb/balance-tlb mode")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Jay Vosburgh <jv@jvosburgh.net>
---
 drivers/net/bonding/bond_alb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 839f7482dc18..5073aeeba6c9 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1281,10 +1281,10 @@ static int alb_set_mac_address(struct bonding *bond, void *addr)
 }
 
 /* determine if the packet is NA or NS */
-static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
+static bool alb_determine_nd(struct sk_buff *skb)
 {
-	struct ipv6hdr *ip6hdr;
-	struct icmp6hdr *hdr;
+	const struct ipv6hdr *ip6hdr;
+	const struct icmp6hdr *hdr;
 
 	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr)))
 		return true;
@@ -1296,7 +1296,8 @@ static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
 	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr) + sizeof(*hdr)))
 		return true;
 
-	hdr = icmp6_hdr(skb);
+	ip6hdr = ipv6_hdr(skb);
+	hdr = (const struct icmp6hdr *)(ip6hdr + 1);
 	return hdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT ||
 		hdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION;
 }
@@ -1381,7 +1382,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
 		switch (skb->protocol) {
 		case htons(ETH_P_IPV6):
-			if (alb_determine_nd(skb, bond))
+			if (alb_determine_nd(skb))
 				break;
 			fallthrough;
 		case htons(ETH_P_IP):
@@ -1467,7 +1468,7 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 			break;
 		}
 
-		if (alb_determine_nd(skb, bond)) {
+		if (alb_determine_nd(skb)) {
 			do_tx_balance = false;
 			break;
 		}
-- 
2.55.0.970.g62bdec98f9-goog

