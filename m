Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2C4EA384
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576902; cv=none; b=r3/KH0jZeyKrgHOH+kFQtmSqBnqsl9GzlOvBgjOW8Oh9jcCDwM/QLClaMoQ+yDdcZA/xKY7ZWvLbkBbSDHGUvW5K1KMETmUhrJpvLq/XDy69tDg/W6Mc+ilJ9ZTCZHsHmgUd9vBUk+yYAc/QNEw6yQQ1dhTN0erq6mQRMqmkz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576902; c=relaxed/simple;
	bh=VY0TAGdJv85A2ijXW89CHS1kiI1orXTG/LqRzg+kjXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTWPwbSi2GbXPvsCjEJh04bONK1qAyLdzDsPVpSGLa1dSJHFGYFKdf2bDEzOGsCG/JMwQAFvw/Nu5T18il613Gd5mp/YH7os3JSwOp9Q3mwtzctTEwL3cRAA8vi3tlXSPOZT8J8+v/z2Sc4E9865cpY5pKzNays4e1nnXY1uGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=jzGtbcgr; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="jzGtbcgr"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-351767ef18cso203195eec.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791576900; x=1792181700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLAm1Mcy+oY7OHbF734SMCtUPAhjxFAoK6CtyMhqiYk=;
        b=jzGtbcgrq5KCCtTv2/muacSlLajLorQc7gfIozMNNkQiV3zUNEfuXTegygqpLeCF7Y
         aCznDDIccWQj99RCfagqWtTR8RV9sHYb30fGcoBkvWbTtowbwixwQnx3yeqAF923t+qN
         0faQ7haWD8TS7QW5s8wjLvAupnNniScuIXAwAu3TZM92oIc+BVVu2aBdo+c0XKlPCzdc
         4xJ8NwwKiLeSjtbNqexbfBjXfG27yvOw8lRTafYvDgSw7ThZ/kyz+84S5kWUNsCxnygH
         F/0sU2lcQAZNuULzE+l5GuWpREoWbpKiXu3gzpOYK80I6psDFdUQzloX6dTTeBq2sfR1
         7Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576900; x=1792181700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLAm1Mcy+oY7OHbF734SMCtUPAhjxFAoK6CtyMhqiYk=;
        b=NqGgGAB41fag193HzUl9wDQh10J/nOgVNXBoY4l15EaaLRflGcSEzE2+dezvAI64fz
         KeSaseEVQgiubVyAq0IudL/fTmJMNcLKhtKojjB3HpHfewsyvDmbIJOLSQpZk0ye7dcf
         ciEpLNvMOPacFPiFzjJWlVGA4zAt0Gy8vLeznukyxkwZBCYb1O0a2nwuDu/fnEEN4hTy
         IAagqVFBjh1UNC6Tj9p9alFg9ytIKiUK/9PGqaF54WKHnpizz7YBK1hmIK7SFM92xgCF
         +GFV4aWlZvQDbLBFI5y0/1VHfiG2J63FtqtB4jZqzbqvd8RhsICiOVNzBsIdzF05R1La
         I7fA==
X-Gm-Message-State: AFuF++kydJm6wPGtUPN+SHjVa9dKVxp7xp6XnebRddvUN1jCwtpsDH7t
	e/xidW6UeCnAX80Iq8Y7kJYgE+AMzwIn3w2QqEs+F9expFoO1MBrkPshYfbPuyQokJo=
X-Gm-Gg: AYBFou3FMsMilSghG6+v7e5xZJ7F+yNZ4vrLnGpZRplreu6dVWHA7G3O2DBEjjXWn8n
	mhn8DTZDDyxd2j/HXf8VNjArl5C8UAKg4j010F4PGFpaJIsGnh8ESJ0t805zu/X1RYiu3iU5VzW
	DKUg0lGuo/M5xcenmDEHWUAz0Xa/rrRVjPT8T1xqdRwFqqs1TfT8YP+9VT6k2zzu1U+yECTWwTW
	Pmk4pSV6U4PxPNJyBBO5s5dLF29FIe7RhmAipuMw3IIfusb+I/jICYmPBig+S+oQykFMLQ4QooO
	HGhIiWpDY4f2XbWEx/hX8s2knSOmbE9hVAqJuIsLU2tQttAYnY7nAv9j4KNrrjmBHiveLEn90Pc
	I8kCP0W5zn5YIgcYJDx/RWhunzzSD9VGTxUc6tVFSm2CpR8XSnvzluoyjM0UZUzRpETtjzOIbBe
	sAwZSIVfj8bIoiJvFxzacs+1ruLQIXmAm2kc10kwVda0apz4KThkFxEBIZ9zSnmiyrNllTc17GB
	WdJszCzX1WzvE4/MMhv0QgqChMqLR+MUO+JxwWb
X-Received: by 2002:a05:7300:7fa3:b0:352:2e10:10c3 with SMTP id 5a478bee46e88-3537e0858edmr5760942eec.36.1791576899760;
        Fri, 09 Oct 2026 13:14:59 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm8994643eec.5.2026.10.09.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:14:59 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 1/3] amt: key relay tunnel state on the (address, port) endpoint, not the address
Date: Fri,  9 Oct 2026 20:14:52 +0000
Message-ID: <20261009201455.1904698-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009201455.1904698-1-omar@blockcast.net>
References: <20261009201455.1904698-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_request_handler and amt_update_handler both look a tunnel up by the
outer source address alone:

	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
		if (tunnel->ip4 == iph->saddr)
			goto send;

RFC 7450 s4.2.2 defines the unit of relay tunnel state differently: "an
AMT 'tunnel' is identified by the IP address and UDP port pair used as
the destination address for sending encapsulated multicast IP datagrams
to a gateway", and "each unique combination represents a unique tunnel
endpoint".

Because the port term is missing, two distinct endpoints that share a
source address alias onto one tunnel. The second Request to arrive
reaches `send:`, overwrites tunnel->nonce and re-derives tunnel->mac, so
the first gateway's subsequent Membership Updates no longer match and
are dropped at the "Invalid MAC" arm. That arm returns rather than
continuing the walk, so there is no recovery path: the first gateway has
had its Request answered and its membership accepted, and simply never
receives data again. The failure is silent on both sides.

Two deployments reach this, and the same RFC section names both:

 - NAT, which s4.2.2 calls out explicitly ("this address may differ from
   that carried by the message when it exited the gateway as a result of
   network address translation"). CGNAT, a single-WAN site with a
   redundant gateway pair, or two subscriber devices behind one
   residential NAT all present as one source address.
 - A single gateway host, with no NAT anywhere, which s4.2.2 says "may
   use separate ports for the IPv4/IGMP and IPv6/MLD protocols".

Add the port term to both lookups. amt_update_handler snapshots the
source port before iptunnel_pull_header() strips the encap, alongside
the existing pre-pull reads.

With the endpoint keyed correctly, a gateway that re-Requests from a new
ephemeral port no longer aliases onto its own previous tunnel: it gets a
new one addressed to the port it is listening on, and the old one ages
out on gc_wq. That is the same stale-Membership-Query symptom addressed
by refreshing tunnel->source_port at `send:`, fixed at the cause instead
-- so this change supersedes that approach rather than stacking on it.

Also count the "Invalid MAC" drop in rx_dropped. It is currently a
netdev_dbg only, and an Update dropped for failing validation is the one
delivery failure a gateway cannot observe from its own side.

Note this removes an accidental bound: while tunnels were keyed on the
address alone, one source address could never hold more than one tunnel,
whatever it did. RFC 7450 s5.3.3 asks for that bound explicitly, and it
is restored in a companion net-next patch ("amt: bound relay tunnels
admitted per source address") rather than here, since it adds UAPI and
this is a fix.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index b53f8ec5566..ed82f8fac3f 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2471,6 +2471,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	u64 response_mac;
 	__be32 saddr;
 	__be32 nonce;
+	__be16 sport;
 
 	saddr = ip_hdr(skb)->saddr;
 
@@ -2484,6 +2485,8 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 	nonce = amtmu->nonce;
 	response_mac = amtmu->response_mac;
+	/* Snapshot the tunnel endpoint port before the encap is stripped. */
+	sport = udp_hdr(skb)->source;
 
 	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
 		return true;
@@ -2491,7 +2494,8 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == saddr) {
+		if (tunnel->ip4 == saddr &&
+		    tunnel->source_port == sport) {
 			if ((nonce == tunnel->nonce &&
 			     response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
@@ -2499,7 +2503,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 								  * 3);
 				goto report;
 			} else {
+				/* The endpoint match is unique, so no other
+				 * tunnel can validate this Update. Count the
+				 * drop: an unauthenticated Update is not
+				 * observable from the gateway's own side.
+				 */
 				netdev_dbg(amt->dev, "Invalid MAC\n");
+				amt->dev->stats.rx_dropped++;
 				return true;
 			}
 		}
@@ -2705,7 +2715,8 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 		return true;
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
-		if (tunnel->ip4 == iph->saddr)
+		if (tunnel->ip4 == iph->saddr &&
+		    tunnel->source_port == udph->source)
 			goto send;
 
 	spin_lock_bh(&amt->lock);
@@ -2743,6 +2754,14 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	spin_unlock_bh(&amt->lock);
 
 send:
+	/* source_port is part of the tunnel's identity and is set once, in
+	 * the allocation path above; the lookup only reaches here on an
+	 * exact (address, port) match, so it is already udph->source. A
+	 * gateway that re-Requests from a new ephemeral port no longer
+	 * aliases onto this tunnel -- it gets its own, and this one ages
+	 * out on gc_wq. Do not "refresh" the port here: that is what made
+	 * a colliding Request steal an established tunnel outright.
+	 */
 	tunnel->nonce = amtrh->nonce;
 	mac = siphash_3u32((__force u32)tunnel->ip4,
 			   (__force u32)tunnel->source_port,
-- 
2.47.3

