Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344753;
	b=vugS2hUcq3odT/HaA4XGkbcYuyWEemjA7uqFN2Pg78aHPE0kdflcx3E9W0T6wxFKjQH6
	 bnh9OokrjlcY63jeUKDS+vN4pccElMB25hzi6j7uKWmzrjKePYorLH01Fcb2vJB+IJZmd
	 Tj021nOcFZ97r1Q3J641x/kghzNbAFGOeSxtw2mA7Le7g2gOthpoTvdWuBzaAGNT4FQvn
	 EyruypnkhAOR2jkMbGVChtIlD7VJeX5YqeC2NBavqi1FTE3V3/2kDVK5n3iVy3daZ+Er9
	 93FRhVPMk2eqzuRIfxUWyDwQY4Yzw/ljyfDIc9pK7Soc6MJ0citteXHZV5zROb7n7Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vVZVlJz2xvnsRRciHhmJHZpeRfn5b7Ccf+nD0x4TgnE=;
	b=KSGJXRPvq91iOvqHWt7IjgOk3EmxJGiFE6hhO8zmxhvf/3EhQBHb4B24jYwXN7UKku6Y
	 Suo5hCMrKWds/oM8Lwbmg3jW8KBrN3N52BSgr9I32ynDfQeVvUgloXUoFFu+mmDd7cAw5
	 ch4dIfZIZg8C7hyg/WjSf6wsepMmSL3ANCI9q4rQVgK4nj9PcsWYMstoUZD4sMYjwCInr
	 fwRniM4qIhtTkgswXEe58AQAO8XHk1prfrmgw1m413s8pUWUjo5aHgfGrp0xKrUK/SH/F
	 WWaAibG+9mE0/24JcpDiToPhzsD4t53Atkf/z91H+mfgOubuzZZH6g4q6z9A5bE/Lqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b="PFKGTh/x";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50560A382B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A50560A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=PFKGTh/x
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so345096c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344751; x=1794949551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVZVlJz2xvnsRRciHhmJHZpeRfn5b7Ccf+nD0x4TgnE=;
        b=PFKGTh/xcQl+W0yBVx+SaOfczow99hFdO6cJJoZJNuz6AXxmdoWFbZ3Y9pmgR3Fvzq
         oZaYe7Znzz5zqaXwBkNJyt9JoQDKbVb28mfc/D6mAHcvttw7pRl+Bu4g7rFzwE25OWb9
         dW267fUD7hXxaHrg7UewdnzTD8UxA8YRf6+9IdM7vSjWaZ1yJkNp7RAbRe3j41nAw/d3
         vCg5UHVxkLGk2ROIRaSAtvHhWcpg4huyFEW+Y2i+8TgBJ9TQhU9LXbTbymmxVhmgmLTc
         kwO6YFnVO755/P19vG4cBGk8AMltMylGgh5CeK/yic3SWZSbK8zRZmJi51AP0MfLhx/6
         JfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344751; x=1794949551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vVZVlJz2xvnsRRciHhmJHZpeRfn5b7Ccf+nD0x4TgnE=;
        b=jmva+KnnSj8PzL6yhrsCotGoQeRZFCmjoz6zdPT6xRrNZSAp2kRjvo5rNAYTa/99AE
         xgeyKkSOhTI0S8+FhPzEGFUJMLrjnCz6y393gCM3zCqICxe9GPSp5ixazAGC2GN0Nr49
         fZEesupA590flTjobOlXPp2IBOITAV+An7TrwGVpPFkHNUSNO+5JrSkOxcAyJ2uWm4oE
         uAwi7ryaA2GxlvhwzMRnscDtNsDuMmoOv3DQRH1P97sTyf3LAGjmdbnY6Cy3iJZ/ttu2
         yxg9iXXGObM5M5MG0SkphiMREsfq9wvFkxptQtPjEeY85jeGR5RLSljlrUaIomBfxm+h
         XuSg==
X-Gm-Message-State: APuU4Z8+lDT9Yq9i7U0wDLCDCwr9LaU/lBFmkP+AmNHyGz7ZxchXfDyK
	h1TK1I91mJzMOZ5WlQ/owq9KEsOzvmMJYOsTNph15fHh2W1IyPO0gY0XdHkkY5lZqBs=
X-Gm-Gg: AYBFou3BKKCKjAZRoB+ILzZeDYf3r/uw+ThxNOsldJ+9xQ3PPuRZE2U3dcEXBUeYxBR
	Xt7253ga1DpKhHIhLc6p7Ph2NuBkDwfh/qK520BOtTerh2HQ6vpA5+2V+ew63H40JW3zxYn8zQz
	spvHHIGkDOFakKzAOcT7z/aHK1a0XkiIaRP8yvriQxGaSPo1wsJZXWETWToz7Y79UmWxLf9Y/6R
	/8C8i+6VobbYrOGxrI5FL/TQ/XNeAfpMSgCQDulYd/xWc+WayZoZW1Wyesn7YIt1Gjjfl2CdYsG
	cSrQGNF53fa+BQBk8lx3/0MUYeyn9wd7fLTpQOWoQUSVE/HrGfggD/Jbjb/jEph8ul/u2CukC1+
	Z2Fk7RGRga2arpd3DylF0mTFUR0X3mCsAh20mM+iR4dtyCaaKW8L9ygbSCHOAO64Yq1LtaGezAT
	NVpcqRgjnLVx+2rrnsnmXOTaJKbM+Jnlrr0qtgQJOkOJYe9ByZKcBQ1+jToycaM1lakmc6vSZk9
	2RlWhW9CQyBu2UgFS6hboFiHCBdHqmXdbWoccksjWMN2428voTkAHXtjRMFFITCA3KL8yr+TJQ3
	1pxOUNNXR8vjbPzIwP4TDK8lXW7k6JsblGobLnHAcPJRHaj4aPIA5wJWzbe27jn/of42/EQ=
X-Received: by 2002:a05:7022:ed07:b0:188:ea93:6cf9 with SMTP id a92af1059eb24-1b3c0359347mr89087c88.43.1794344751021;
        Tue, 10 Nov 2026 13:05:51 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:50 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net v7 5/6] amt: make pre-query report drops visible
Date: Tue, 10 Nov 2026 21:05:36 +0000
Message-ID: <20261110210538.217936-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110210538.217936-1-omar@blockcast.net>
References: <20261110210538.217936-1-omar@blockcast.net>
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

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family.  The Query supplies the
response MAC the Update echoes, so dropping an early report is required,
but doing so silently leaves operators with a dark multicast path and no
indication why the join never happened.

Emit a family-specific debug message before taking the drop path.

tx_dropped could not show these drops either: amt_dev_xmit() reaches the
same tx_dropped increment after amt_send_membership_update() has handed
the report to the tunnel, so in gateway mode every forwarded report was
also counted as a drop. Return NETDEV_TX_OK directly once the report has
been sent, so a report the tunnel accepted is no longer counted in
tx_dropped.

The device is LLTX, so amt_dev_xmit() can run on several CPUs at once;
use DEV_STATS_INC() for tx_dropped and tx_errors, there and in the
control-message senders that update the same counters, so concurrent
increments are not lost.

Found by code inspection while debugging an IPv6-in-IPv6 forwarding
failure in a selftest for the AMT IPv6 outer transport. This drop can
leave one address family dark, so it was a suspect, but that was not
confirmed: the failure was later traced to the selftest, which sent a
single datagram without waiting for the relay's multicast routes to
converge. The drop has not been observed in production, and there is
no oops or trace. The Sashiko AI review of an earlier posting found the
tx_dropped miscount and the non-atomic counter updates.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 99cce0a14..de5b7dbe3 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -735,7 +735,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -745,7 +745,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -790,7 +790,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 	amt_update_gw_status(amt, AMT_STATUS_SENT_DISCOVERY, true);
 out:
@@ -826,7 +826,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -836,7 +836,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -883,7 +883,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
@@ -905,7 +905,7 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, false)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -949,7 +949,7 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 
 	if (ipv6_dev_get_saddr(amt->net, amt->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -993,7 +993,7 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, true)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -1353,7 +1353,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		goto free;
 	}
 
@@ -1366,12 +1366,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Gateway only passes IGMP/MLD packets */
 		if (!report)
 			goto free;
+		/* A validated report can only be forwarded after the relay's
+		 * family-specific Membership Query supplies the state echoed
+		 * by the Membership Update. Log this readiness failure before
+		 * the shared drop path accounts it.
+		 */
 		if ((!v6 && !READ_ONCE(amt->ready4)) ||
-		    (v6 && !READ_ONCE(amt->ready6)))
+		    (v6 && !READ_ONCE(amt->ready6))) {
+			netdev_dbg(dev, "drop %s report: waiting for Membership Query\n",
+				   v6 ? "MLD" : "IGMP");
 			goto free;
+		}
 		if (amt_send_membership_update(amt, skb,  v6))
 			goto free;
-		goto unlock;
+		/* Sent: the tunnel consumed the skb.  Not a drop. */
+		return NETDEV_TX_OK;
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (!data)
 			goto free;
@@ -1400,8 +1409,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 free:
 	dev_kfree_skb(skb);
-unlock:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -2777,7 +2785,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2787,7 +2795,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2833,7 +2841,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
-- 
2.43.0

