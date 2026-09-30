Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB05328C1
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793588; cv=none; b=Lnh6i3QvTLk/j5EHQiC9jNG9i8kBCgNMULhkkMO0QblFHgD9fHaZCzNWdphkPNhXCabVkQRW9QQRgCybd7sUusRH3TwrPbs/dnVZTkV/7qwD0omybcajTTBs1PkwT4QP6Yn928tBzsGJ4AmzVRYfrButrMlAhyz7dWw68KHZQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793588; c=relaxed/simple;
	bh=i9lFyp1Sq6/WbIiGgCXDSwMme0fljp4k2GB7IY6iS18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tji1AokuZyS2efNoFPD4Y/JbNkD9hHwyXuJ10JKtMAjEDqj9C/5dSSJybYtBNjLnu3ZhHkXodyG8j4pTu0MjathO+SETBVdITIlwId1eBE2DUJLn9e6ugCitUHBSlDm0PyDHqaSgnwNF0vqRlEhbv4pZgcsiV+2dBWtGD/+snso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiCiW0x0; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiCiW0x0"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba42939bfeso419269e87.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793584; x=1791398384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4dhH5glJ7kbZJ2EVYGxwej2JrsTXNAqIrmHwMJRFRDk=;
        b=oiCiW0x0+mXTuB8kyer7I+yuQ52Q7MGdp1TcMALMT2UcW7XS22utFriQryXT6wxLkT
         JINMkxlU9jelAKfynEPkvijjFzRi4gvJBXMoQfNTa5JXcAz4Fnrr9su69RGnmY4T99hx
         0Q32zH74QbQs+t0yIoepC2VEGFVsLIjOWpci7etqdnWEdyI7SF9iX6UiAFMkDplE+7//
         ZQbK+YhX77uDVRbEIOcfyDXrPM8sZGQuSR9Au3k8wE3LgREYiaZF/NJFoeUtoqg0aP3s
         KPkznhCgVRoX85sgpFxeZKXKMROYmnySe9XZqL2cCHlLZJcu9cWkLI1RohdFAB8ka9L3
         8/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793584; x=1791398384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4dhH5glJ7kbZJ2EVYGxwej2JrsTXNAqIrmHwMJRFRDk=;
        b=nUi2z2b4BsXTw/T6uOLnV5+B4sGKMn2E/tHhvSeslb+rgO1ThGCHu5VbPMGK2ZPBlN
         B+PzsaYFvxdO+sVmOKLSh2lmHNjO4nJwdfEVtjuWT3GvtmsVWYMmp7qsEcyrPVi7BMe8
         YhBH7EMlDmlZlK4MZZa0JVHZN98rzCi/OEvOY3by8Eo2qlUvtMQ9S4YBv044SE3szPMm
         WDYzNPp8vVX4Nh17APD1I2CuFP8+orhgjuFcqzwdyC1EWIDw2m1Y4nmyAhUMT0uL72EA
         DJx+OaKCv1U052hLI9yafWzHbnT/coJ3e8MnQYHMJP8PTc79TPCQ0YM3i4LgZfoLc9ij
         4PDA==
X-Gm-Message-State: AFq9FYIYkjMR+/4hLx5YFN/gnRNy9VbBBczyA0gQqSvrEAs+XaI/U1Wp
	UYEr2kjM4VehEy+EoHlPmEbtqfDlXqrQ688WpsSGFSEzKwsgxZ0bWQ4CHtKjdxrE
X-Gm-Gg: AYBFou3uGhQ7Sw42wG/+HPwdWvjrNQH0aazCIi7cxRjmZoetVQZvkZMs8NM0fAk6FoH
	2AyxhBr2XxMU5tzAi5r7nRSozZkuJHLu7hoSK7PqDUf2UtIIv1BM8d8S++HxPh/CXaa5D6dJPOj
	eEMoiw9NPFWA6VRONrLDUbKIUJBvtcAZUUGQNm4aYhP+T3kon5cRRNEJHRJNVNZwOxvzRuEIQDT
	XOJlbmjZFY4AoWcHsPTWHREcifXgMmC7xpeLEZK3mDb+qFiMWmBHHthNv6udBocQCvnnfZInfGP
	HAdfmUH0v+cjtKe/zuPhRC3S9LlqJk97kjXDOLAcwoL5WFfxLRxjKfRhiucBvK3h/rgv9rOFFlz
	Um/knyjMhABJASRXRz23fFgNpuzbgT373QOCp4iH4hjnSF1dfX9qlPzJ2Mvsf0aXMh3xifCgm9s
	I5UFu+SQhJQ4FTDDAx/csG4Hs359hsg2YH5EQ88ihencLg9lMrrzfxMP3TdpqMtw+1ovMsfCUuh
	5rMteIUXr5c+6O/Jz5sz/Xzq2NWmcWL1e5L0y1JpdkT
X-Received: by 2002:a05:6512:33c8:b0:5b8:bc5e:b579 with SMTP id 2adb3069b0e04-5ba40617a79mr1017050e87.49.1790793583911;
        Wed, 30 Sep 2026 11:39:43 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:42 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 13/14] ip6_gre: add drop reasons to the transmit path
Date: Wed, 30 Sep 2026 21:39:09 +0300
Message-ID: <20260930183910.3151873-14-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch made the ip6_gre helpers return the drop reason of
ip6_tnl_xmit() and their own, but ip6gre_tunnel_xmit() and
ip6erspan_tunnel_xmit() still free the packet with a plain kfree_skb().
Free it with the reason instead, and give the drops of the handlers
themselves one, from the same set:

 - the length reason from pskb_inet_may_pull_reason(), as in ip_gre,
 - SKB_DROP_REASON_NO_TX_TARGET for a device without a remote address
   that is not collect_md, every packet of which ip6_tnl_xmit_ctl()
   refuses, as the handlers pass it the addresses of the device;
   ip6_tnl_xmit() reports an NBMA tunnel that found no endpoint the
   same way,
 - SKB_DROP_REASON_DEV_READY for the other refusals of
   ip6_tnl_xmit_ctl(), which, as the previous patch explains, include a
   routing loop,
 - SKB_DROP_REASON_NOMEM for the offload setup, the trim of a packet
   longer than the MTU and the headroom,
 - SKB_DROP_REASON_TUNNEL_TXINFO for the collect_md metadata checks of
   ip6erspan, and for a packet without IPv6 metadata in ip6gre (see
   below),
 - SKB_DROP_REASON_UNHANDLED_PROTO for an ERSPAN version that is not
   implemented,
 - SKB_DROP_REASON_RECURSION_LIMIT and SKB_DROP_REASON_IPV6_BAD_EXTHDR
   for the checks that ip6erspan_tunnel_xmit() does itself, the same as
   in ip6gre_xmit_ipv6().

ip6gre_tunnel_xmit() looks up the metadata of a collect_md device before
it passes the packet to a helper, but leaves the drop of a packet
without usable metadata, missing or not of the IPv6 family, to the
helpers, and ip6gre_xmit_ipv6() checks the source address first. The
raddr of such a device is ::, so such a packet sent from ::, like the
device's own DAD probe, would be reported as
SKB_DROP_REASON_RECURSION_LIMIT, and other such packets as
SKB_DROP_REASON_TUNNEL_TXINFO. Drop it right after the lookup instead,
as SKB_DROP_REASON_TUNNEL_TXINFO, with the test ip6erspan_tunnel_xmit()
uses; the IPv4 handlers also test presence and family together. The
helpers dropped such a packet before ip6_tnl_xmit() in any case, and
tx_err counts it by the result of the lookup, so only the reason
changes; the test in __gre6_xmit() stays as a safeguard. A packet from
:: that carries IPv6 metadata still meets the check in
ip6gre_xmit_ipv6().

Such an ip6gre device is an NBMA tunnel: ip6gre_header() puts the
endpoint of the packet in its outer header, and __gre6_xmit() would
take it from there, but ip6gre_tunnel_xmit() refuses the packet before
that, so the device sends nothing. This patch does not change that; it
reports these drops like those of an ip6gretap or ip6erspan device
without a remote address, which has no endpoint at all.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_gre.c | 73 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 9e94ea6b6c20..dbca78230815 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -889,14 +889,28 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	enum skb_drop_reason reason;
 	__be16 payload_protocol;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
-	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
+	if (!t->parms.collect_md && ipv6_addr_any(&t->parms.raddr)) {
+		reason = SKB_DROP_REASON_NO_TX_TARGET;
 		goto tx_err;
+	}
 
-	if (t->parms.collect_md)
+	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
+		goto tx_err;
+	}
+
+	if (t->parms.collect_md) {
 		tun_info = skb_tunnel_info_txcheck(skb);
+		if (IS_ERR(tun_info) ||
+		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
+			goto tx_err;
+		}
+	}
 
 	payload_protocol = skb_protocol(skb, true);
 	switch (payload_protocol) {
@@ -917,10 +931,11 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 tx_err:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	if (!IS_ERR(tun_info))
 		DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
@@ -940,18 +955,30 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
-	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
+	if (!t->parms.collect_md && ipv6_addr_any(&t->parms.raddr)) {
+		reason = SKB_DROP_REASON_NO_TX_TARGET;
 		goto tx_err;
+	}
 
-	if (gre_handle_offloads(skb, false))
+	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err;
+	}
+
+	if (gre_handle_offloads(skb, false)) {
+		reason = SKB_DROP_REASON_NOMEM;
+		goto tx_err;
+	}
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len)) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto tx_err;
+		}
 		truncate = true;
 	}
 
@@ -971,8 +998,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			truncate = true;
 	}
 
-	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen))
+	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen)) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err;
+	}
 
 	IPCB(skb)->flags = 0;
 
@@ -986,8 +1015,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 
 		tun_info = skb_tunnel_info_txcheck(skb);
 		if (IS_ERR(tun_info) ||
-		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6))
+		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
+		}
 
 		key = &tun_info->key;
 		memset(&fl6, 0, sizeof(fl6));
@@ -999,10 +1030,14 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 
 		dsfield = key->tos;
 		if (!test_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
-			      tun_info->key.tun_flags))
+			      tun_info->key.tun_flags)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
-		if (tun_info->options_len < sizeof(*md))
+		}
+		if (tun_info->options_len < sizeof(*md)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
+		}
 		md = ip_tunnel_info_opts(tun_info);
 
 		tun_id = tunnel_id_to_key32(key->tun_id);
@@ -1020,6 +1055,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					       truncate, false);
 			proto = htons(ETH_P_ERSPAN2);
 		} else {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto tx_err;
 		}
 	} else {
@@ -1030,11 +1066,16 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 						 &dsfield, &encap_limit);
 			break;
 		case htons(ETH_P_IPV6):
-			if (ipv6_addr_equal(&t->parms.raddr, &ipv6_hdr(skb)->saddr))
+			if (ipv6_addr_equal(&t->parms.raddr,
+					    &ipv6_hdr(skb)->saddr)) {
+				reason = SKB_DROP_REASON_RECURSION_LIMIT;
 				goto tx_err;
+			}
 			if (prepare_ip6gre_xmit_ipv6(skb, dev, &fl6,
-						     &dsfield, &encap_limit))
+						     &dsfield, &encap_limit)) {
+				reason = SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 				goto tx_err;
+			}
 			break;
 		default:
 			memcpy(&fl6, &t->fl.u.ip6, sizeof(fl6));
@@ -1053,6 +1094,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					       truncate, false);
 			proto = htons(ETH_P_ERSPAN2);
 		} else {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto tx_err;
 		}
 
@@ -1087,10 +1129,11 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 tx_err:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	if (!IS_ERR(tun_info))
 		DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
-- 
2.47.3

