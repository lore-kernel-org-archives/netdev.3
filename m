Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19042527581
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793578; cv=none; b=pyil7ZszOaFQK27YTayFXMQ1QFDzbuTBncmC4pFTfX0C79CwFOJb9RMNbr7PcwfO7kHOaG5BSePyKc4cePo5QTh+2FjN0Ky66P6f7/WNf3dEYPd/NunT4ow9jQkklDsQEY3IX/L0gtiuzIYcCISnv39oohA2n9U3DgXvFnTu/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793578; c=relaxed/simple;
	bh=c5rW7wi/kCjYet+dXYhtF8xcfQvy+M7tfR6pJD9JMOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYM/4eQHLeyHZHLEUs0zlJflgC6V/3fYtSJJhGiduE6La/5UXwu64KfbkJ6DDuL6Haz9kcejdkoX0TkrmiZS7J6dz3Vd209hdY+YMVW4VkxcL/OfIBWAto84pGxf1peSxvAdOD3EpkfZ/OoInxeC+B4ZNoBOPs4Wx8weAZxV96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fput5fB3; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fput5fB3"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8f490bb27so3192227e87.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793574; x=1791398374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0QCN4WmNXZujQk5XthywDUtDIDAmvZjA4O84XF9Smw=;
        b=Fput5fB3rxX/wC/1LO237i1rt72vBoLJc0AOxqsPkNXmkwDSC47iq3RxyvVsZSm2Vq
         I+0R84T0z7sP5c4TQW6skgZ2smk56FkV6P/lJjrCHXj9eXTBipS1oNrmcNO5555x1iWW
         1wI6E0y8lYVoyarWc0MTEP3b4EUuUFLGwbG7xFHaeFQ85FMDK8n+VZTAyVpC12UP6OO5
         B78JHG1mzFksqSS+zLyfZMPifl9TUYEUkxdPjlUMymj4+3qEF6LaSj/InJYR5KwY+MrZ
         pgqWkOrvMBdNvZ8o0Zolgtxyauzi1Y8+SuMq1vSNIDsHs0KKIDlq9OD/TY+Z8VonFXzY
         ZD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793574; x=1791398374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B0QCN4WmNXZujQk5XthywDUtDIDAmvZjA4O84XF9Smw=;
        b=N2UMKybpLaXOLQDS/1ko9fLKqV6xmUFJqlGzJEK3jfpDwkFlatCXhADwcIDN2DS2J8
         R3yzncxx+GFm9jhjL456PfTW7uQf0Vb5XrdPoBO+/Y9UTCxUb36DYCPbM+n5cHsluoVn
         N0RHvtCaZvxaRfG4eg/JnMPEWhWJzLBrqZCJzSbFqmFYCfgo/zH0K502f+wD4CSz6UeJ
         NmcPYULQJu4QJG1OhXISE0Or2sG8aNLx0AP5FAuBt8jja8iZ+6C0i2oztCrFoEngd4kX
         f1QRvaL734Ng9rACQohpe/NEp4WQ2FL5lLzH/ONG8q58o7o/SzyC2YTtf6o6IYwCq2b9
         CLag==
X-Gm-Message-State: AFq9FYIqDAn5FfM7e0s7qSCjJsU2INcx5lGkhVEiBR4J2gfDnLVbsgJq
	qnRoVGFptlR2AIhm4uxmT5R74hsj2TD3ypgXZx5iyZxh46P5avImF652nopUDQCl
X-Gm-Gg: AYBFou1tKZcZsUwWIPz7fdzxyrDjJRHUtWLCAqgraSZBX04GdmwTXytdY4fqq+rsaTU
	gLgGNf1P/k5GYchyz2MLNrJWvyXmkQfK68cBo4CmD8Vga/GEBrvSd5WrN2+tcj6tljx4RVnyJ08
	gLM2lEvU2KpH/nlCRsl/RdMuU2zj1GoJQ/tEqs+YI5T0burgX7VqDNONJqR3o0iWh8jwIFAdqM2
	/KJh1PAnBflD5l5khZ2hJhmgDSYzLyZuUTyzGxnkHt3AbW5AjtJttnNDq8G2mcBBzlGWRmfZUcm
	tJJmJuAbYzdU15B3KpKC8cRLvj8uPF0N8P3T05s2xj36AKvLs/h5y3phTb6WhUcqHpYu0ci1Nn6
	5H1RgqXiC0R36/jieCvP1a7ZzhAdCGAriNUP9TwkF3Pi/qGfS1cjBW1fW6Jv3NBOKkIhuWCjnwJ
	4zenAO+apwkgO2hw7hX+83UJj1XTkNgIFUQ5yTls6U7QpJ7bIv6I+IoO7v4Q9ogMz0N5HMdYASv
	i22oijzCHOLBCd2+YwlgG8ytlYxQVQqv1K3vJtw5U/U
X-Received: by 2002:a05:6512:48c:b0:5b8:c226:fe21 with SMTP id 2adb3069b0e04-5ba406024a7mr794694e87.56.1790793574135;
        Wed, 30 Sep 2026 11:39:34 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:32 -0700 (PDT)
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
Subject: [PATCH net-next v5 07/14] ip_gre: add drop reasons to the RX path
Date: Wed, 30 Sep 2026 21:39:03 +0300
Message-ID: <20260930183910.3151873-8-littlesmilingcloud@gmail.com>
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

A packet that reaches gre_rcv() and does not belong to any tunnel is
dropped, after an ICMP port unreachable is sent back, as
SKB_DROP_REASON_NOT_SPECIFIED from the same kfree_skb_reason() call as
a truncated ERSPAN header or a failed metadata allocation. This is the
GRE counterpart of a UDP packet hitting no socket, yet neither the
reason nor the call site tells it apart. The fallback devices such as
gre0 only take such a packet while they are up, and they are created
down.

Report SKB_DROP_REASON_TUNNEL_NOT_FOUND for it, which vxlan reports when
no device matches the VNI, and add GRE to its description.

erspan_rcv(), __ipgre_rcv() and ipgre_rcv() now return
SKB_NOT_DROPPED_YET where they returned PACKET_RCVD, including the paths
that free the packet themselves, and a drop reason where they returned
PACKET_REJECT or PACKET_NEXT. __ipgre_rcv() only returned PACKET_NEXT
when no tunnel matched, so the retry ipgre_rcv() does for ETH_P_TEB is
now taken on SKB_DROP_REASON_TUNNEL_NOT_FOUND.

The length checks use pskb_may_pull_reason(), and the headers are
pulled with __iptunnel_pull_header(), which returns a drop reason since
an earlier patch of this series. Both report a packet too short to pull
as SKB_DROP_REASON_PKT_TOO_SMALL and an allocation failure as
SKB_DROP_REASON_NOMEM. The metadata allocation failures reuse
SKB_DROP_REASON_NOMEM as well.

erspan_rcv() and __ipgre_rcv() follow the same rule for the reason as
gre_rcv(): it is initialized to SKB_DROP_REASON_NOT_SPECIFIED, and their
drop labels fall back to it, as the pull helpers store their result in
the reason.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  3 +-
 net/ipv4/ip_gre.c             | 81 ++++++++++++++++++++---------------
 2 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 0d963f18a21e..6f5273e16548 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -550,7 +550,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TUNNEL_INVALID_HDR,
 	/**
 	 * @SKB_DROP_REASON_TUNNEL_NOT_FOUND: no tunnel device found for the
-	 * packet, e.g. no VXLAN device for its VNI
+	 * packet, e.g. no VXLAN device for its VNI or no GRE tunnel for its
+	 * endpoints and key
 	 */
 	SKB_DROP_REASON_TUNNEL_NOT_FOUND,
 	/** @SKB_DROP_REASON_MAC_INVALID_SOURCE: source mac is invalid */
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index a1b44007b1d7..afd8ece02d7f 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -264,9 +264,11 @@ static bool is_erspan_type1(int gre_hdr_len)
 	return gre_hdr_len == 4;
 }
 
-static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
-		      int gre_hdr_len)
+static enum skb_drop_reason erspan_rcv(struct sk_buff *skb,
+				       struct tnl_ptk_info *tpi,
+				       int gre_hdr_len)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct net *net = dev_net(skb->dev);
 	struct metadata_dst *tun_dst = NULL;
 	struct erspan_base_hdr *ershdr;
@@ -288,9 +290,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
 					  iph->saddr, iph->daddr, 0);
 	} else {
-		if (unlikely(!pskb_may_pull(skb,
-					    gre_hdr_len + sizeof(*ershdr))))
-			return PACKET_REJECT;
+		reason = pskb_may_pull_reason(skb,
+					      gre_hdr_len + sizeof(*ershdr));
+		if (unlikely(reason))
+			return reason;
 
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
@@ -306,13 +309,13 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		else
 			len = gre_hdr_len + erspan_hdr_len(ver);
 
-		if (unlikely(!pskb_may_pull(skb, len)))
-			return PACKET_REJECT;
+		reason = pskb_may_pull_reason(skb, len);
+		if (unlikely(reason))
+			return reason;
 
-		if (__iptunnel_pull_header(skb,
-					   len,
-					   htons(ETH_P_TEB),
-					   false, false))
+		reason = __iptunnel_pull_header(skb, len, htons(ETH_P_TEB),
+						false, false);
+		if (reason)
 			goto drop;
 
 		if (tunnel->collect_md) {
@@ -328,7 +331,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			tun_dst = ip_tun_rx_dst(skb, flags,
 						tun_id, sizeof(*md));
 			if (!tun_dst)
-				return PACKET_REJECT;
+				return SKB_DROP_REASON_NOMEM;
 
 			/* MUST set options_len before referencing options */
 			info = &tun_dst->u.tun_info;
@@ -354,18 +357,22 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 		skb_reset_mac_header(skb);
 		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
-		return PACKET_RCVD;
+		return SKB_NOT_DROPPED_YET;
 	}
-	return PACKET_REJECT;
+	return SKB_DROP_REASON_TUNNEL_NOT_FOUND;
 
 drop:
-	kfree_skb(skb);
-	return PACKET_RCVD;
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
+	kfree_skb_reason(skb, reason);
+	return SKB_NOT_DROPPED_YET;
 }
 
-static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
-		       struct ip_tunnel_net *itn, int hdr_len, bool raw_proto)
+static enum skb_drop_reason __ipgre_rcv(struct sk_buff *skb,
+					const struct tnl_ptk_info *tpi,
+					struct ip_tunnel_net *itn,
+					int hdr_len, bool raw_proto)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct metadata_dst *tun_dst = NULL;
 	const struct iphdr *iph;
 	struct ip_tunnel *tunnel;
@@ -377,8 +384,9 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 	if (tunnel) {
 		const struct iphdr *tnl_params;
 
-		if (__iptunnel_pull_header(skb, hdr_len, tpi->proto,
-					   raw_proto, false))
+		reason = __iptunnel_pull_header(skb, hdr_len, tpi->proto,
+						raw_proto, false);
+		if (reason)
 			goto drop;
 
 		/* Special case for ipgre_header_parse(), which expects the
@@ -401,40 +409,43 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 			tun_id = key32_to_tunnel_id(tpi->key);
 			tun_dst = ip_tun_rx_dst(skb, flags, tun_id, 0);
 			if (!tun_dst)
-				return PACKET_REJECT;
+				return SKB_DROP_REASON_NOMEM;
 		}
 
 		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
-		return PACKET_RCVD;
+		return SKB_NOT_DROPPED_YET;
 	}
-	return PACKET_NEXT;
+	return SKB_DROP_REASON_TUNNEL_NOT_FOUND;
 
 drop:
-	kfree_skb(skb);
-	return PACKET_RCVD;
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
+	kfree_skb_reason(skb, reason);
+	return SKB_NOT_DROPPED_YET;
 }
 
-static int ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
-		     int hdr_len)
+static enum skb_drop_reason ipgre_rcv(struct sk_buff *skb,
+				      const struct tnl_ptk_info *tpi,
+				      int hdr_len)
 {
 	struct net *net = dev_net(skb->dev);
+	enum skb_drop_reason reason;
 	struct ip_tunnel_net *itn;
-	int res;
 
 	if (tpi->proto == htons(ETH_P_TEB))
 		itn = net_generic(net, gre_tap_net_id);
 	else
 		itn = net_generic(net, ipgre_net_id);
 
-	res = __ipgre_rcv(skb, tpi, itn, hdr_len, false);
-	if (res == PACKET_NEXT && tpi->proto == htons(ETH_P_TEB)) {
+	reason = __ipgre_rcv(skb, tpi, itn, hdr_len, false);
+	if (reason == SKB_DROP_REASON_TUNNEL_NOT_FOUND &&
+	    tpi->proto == htons(ETH_P_TEB)) {
 		/* ipgre tunnels in collect metadata mode should receive
 		 * also ETH_P_TEB traffic.
 		 */
 		itn = net_generic(net, ipgre_net_id);
-		res = __ipgre_rcv(skb, tpi, itn, hdr_len, true);
+		reason = __ipgre_rcv(skb, tpi, itn, hdr_len, true);
 	}
-	return res;
+	return reason;
 }
 
 static int gre_rcv(struct sk_buff *skb)
@@ -456,12 +467,14 @@ static int gre_rcv(struct sk_buff *skb)
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (erspan_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
+		reason = erspan_rcv(skb, &tpi, tpi.hdr_len);
+		if (!reason)
 			return 0;
 		goto out;
 	}
 
-	if (ipgre_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
+	reason = ipgre_rcv(skb, &tpi, tpi.hdr_len);
+	if (!reason)
 		return 0;
 
 out:
-- 
2.47.3

