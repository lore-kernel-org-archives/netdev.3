Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620147D93E
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115342; cv=none; b=GJO0EzXQ7ZScSex1Yj+ZwTs9Ur01+5QGNL9sr+rdQi041RisybFw38SEc8u7ra9m7s5k8fHIkGwdhU/cKPrMW2p/Dy3cI+oh1r22icz3Fap8xwznoCYzT+wSIAtf6pvENth0T0a3SKSRhyhCoAo7nqi6BI1BD/GwbE0yguQ0IzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115342; c=relaxed/simple;
	bh=0D8CTYmDCMH6i7rohPrLX9uQUUqlJjGhNFP9nt80Dvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4ezuScor0Vw9LSN6gZyfAbmTG0GsxQvGpbGBaP2ChfRNGlQtu6BTYXh1YMTZ9pw213Vcplxwz9DazZEov274vsf5r/hMNFZ8K/LO0sKWznqVHT+l9HNuqG5EnmxOeYIa/3xJ7CdAPRmXwaeZvDi23wGqaMoCcAQco6Gs3xok8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0PtSNEC; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0PtSNEC"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74dbc7359so265505e87.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115328; x=1790720128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vugC9m47cNYpmmwFdzF5Qy5U2YniLLjKVsm9PIdJu5Q=;
        b=o0PtSNECmp+usg3CpaFaSv+QzQsFAax656m/nG52apHNWN+eB5QFaYJfVc8KVekgBe
         oZDeAFMj8xiZ/EvS45pNwmw/9yI2Tgxb4eFkuDepF22OInxQg0ln/fi75Q0mitUdECyu
         Nbat3O4eH/JtgTfQrkn/seOCwz5cHaHjLWdFZa4MA5jcHQeqg6ijFaInu6KzR3ywBCjI
         9SX9zV/5pI1xQxizKvcMdAiwd1vY9js0mauUa9qkDJ3mbJI6dWFQSiDnXWa33bL1BhuG
         tf19HXvwgW56TBw2sUuLI+b0T+4tpABap79p3dILqfHbMattauPZZhOCxNR9juMwXYlC
         Vo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115328; x=1790720128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vugC9m47cNYpmmwFdzF5Qy5U2YniLLjKVsm9PIdJu5Q=;
        b=IGCphsnVk21WXgrBTzRBpja3qG0ZjzSv8zgcag74GpgmXh2EMjFepUCUVmrq6+iUB4
         GTRZCae1YIPznAaQ4RD0/xelgSblrtYAh1Bl9E8J+mrZCuw8i/oQN4OXtezRXZCEi89k
         ezpBSie3YHVgZlOX7HtEUrXRXT5/9GeeyXpvt8+v/MzSVd70bM/McKoDibQy+EbqpSc7
         ii+4u4aTijjWzS8Cn14cNBR9/c/v3+uUAsw4TONDk6Gj1G5+l7Zr902o/a52e+0ox8uz
         l7ToioaPixT0XNwGDCsP2v97YVbckC3Kjce21vP9IVDOBXxQAWlCf+2qmlW32q5INLCS
         0SbQ==
X-Gm-Message-State: AFuF++kXDTS8XYLPuxUVZAOy4tQ1iceza7wM25sQcFofa4RnHxDKIS9K
	9odRKvkjM6HULahLD+OrjXSt68RhjMnATgq93KKfdZ9Rlym/hduTnddZFiKFtm3WQKQ=
X-Gm-Gg: AYBFou2S2js5cG+bjIpq80bNBqfBIfIrW97h3w3FFP6orl8xldKoCobT3z9sSMzSyDA
	ecqvZLAaI/rmJTxrhDCdDOSVEQr8YMc6VJkmuJ3zYk39fc2c5A7Br49j8R6EYFH6XCXwu3ILZKV
	NU5orkHB8piRb8tfvcCEetCyEH4Ulr6woqOdb8kBfM5xDc/jjAezlgBPLr9EmgQAx92ZC1RqSSw
	j1cvLOW3b0QdpyaBba9wNDQD6lHF1WeY9Top6/dRmdHg4/IfSA0Up1klTKHFQgO7ay8KV3gUe5r
	o3zC1qOKjs+mirpdjOgFMWqVwvffqzg/lE52zq2L4Vo4mQtFSIficV72Vi6P8fK2YPlI+AsCseK
	HEQjkaxnZO2lWlXGR+Bhe6EWj9eUmHRF2WlbBkkc6eL4Ll9aVAUJCqLuzAzlftgl0oRDM82HQMq
	wZIi5xOu3FXhw3A3U7lnU0bDOrlgNi4d7BTikn9jejMXAR008p36sjswyZwZ84X5RA/UyKkTKOj
	PtuAbAT8uG18dOTk8kVNRHQXjMgTB+6S1b8hj5xku/4/s1DEzzpq05sVOoF6Q==
X-Received: by 2002:a05:6512:65c9:20b0:5b8:b3a6:719a with SMTP id 2adb3069b0e04-5b8d8987155mr127380e87.30.1790115327614;
        Tue, 22 Sep 2026 15:15:27 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:25 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 05/10] ip_gre: add drop reasons to the RX path
Date: Wed, 23 Sep 2026 01:15:02 +0300
Message-ID: <20260922221507.3268127-6-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
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

Add SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND for it, in the spirit of the
existing SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND.

erspan_rcv(), __ipgre_rcv() and ipgre_rcv() now return
SKB_NOT_DROPPED_YET where they returned PACKET_RCVD, including the paths
that free the packet themselves, and a drop reason where they returned
PACKET_REJECT or PACKET_NEXT. __ipgre_rcv() only returned PACKET_NEXT
when no tunnel matched, so the retry ipgre_rcv() does for ETH_P_TEB is
now taken on SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND.

The length checks reuse SKB_DROP_REASON_HDR_TRUNC. The headers are
pulled with __iptunnel_pull_header_reason(), added by the previous
patch, which reports a packet too short to pull as
SKB_DROP_REASON_PKT_TOO_SMALL and an allocation failure as
SKB_DROP_REASON_NOMEM. The metadata allocation failures reuse
SKB_DROP_REASON_NOMEM as well.

SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND is documented without naming an
address family. The IPv6 side is converted by the next patch, which
ends its lookup failures with the same reason.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  6 +++
 net/ipv4/ip_gre.c             | 74 ++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index ffa11206b6ca..186d9e70e9cb 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -133,6 +133,7 @@
 	FN(TNL_OLD_SEQ)			\
 	FN(GRE_INVALID_HDR)		\
 	FN(GRE_CSUM)			\
+	FN(GRE_TUNNEL_NOT_FOUND)	\
 	FNe(MAX)
 
 /**
@@ -638,6 +639,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_GRE_INVALID_HDR,
 	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
 	SKB_DROP_REASON_GRE_CSUM,
+	/**
+	 * @SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND: no GRE tunnel found for the
+	 * endpoints and the key the packet carries.
+	 */
+	SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index ae50fd0f6792..e158d6e9d42a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -264,13 +264,15 @@ static bool is_erspan_type1(int gre_hdr_len)
 	return gre_hdr_len == 4;
 }
 
-static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
-		      int gre_hdr_len)
+static enum skb_drop_reason erspan_rcv(struct sk_buff *skb,
+				       struct tnl_ptk_info *tpi,
+				       int gre_hdr_len)
 {
 	struct net *net = dev_net(skb->dev);
 	struct metadata_dst *tun_dst = NULL;
 	struct erspan_base_hdr *ershdr;
 	IP_TUNNEL_DECLARE_FLAGS(flags);
+	enum skb_drop_reason reason;
 	struct ip_tunnel_net *itn;
 	struct ip_tunnel *tunnel;
 	const struct iphdr *iph;
@@ -290,7 +292,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	} else {
 		if (unlikely(!pskb_may_pull(skb,
 					    gre_hdr_len + sizeof(*ershdr))))
-			return PACKET_REJECT;
+			return SKB_DROP_REASON_HDR_TRUNC;
 
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
@@ -307,12 +309,12 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			len = gre_hdr_len + erspan_hdr_len(ver);
 
 		if (unlikely(!pskb_may_pull(skb, len)))
-			return PACKET_REJECT;
+			return SKB_DROP_REASON_HDR_TRUNC;
 
-		if (__iptunnel_pull_header(skb,
-					   len,
-					   htons(ETH_P_TEB),
-					   false, false) < 0)
+		reason = __iptunnel_pull_header_reason(skb, len,
+						       htons(ETH_P_TEB),
+						       false, false);
+		if (reason)
 			goto drop;
 
 		if (tunnel->collect_md) {
@@ -328,7 +330,7 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 			tun_dst = ip_tun_rx_dst(skb, flags,
 						tun_id, sizeof(*md));
 			if (!tun_dst)
-				return PACKET_REJECT;
+				return SKB_DROP_REASON_NOMEM;
 
 			/* MUST set options_len before referencing options */
 			info = &tun_dst->u.tun_info;
@@ -354,19 +356,22 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 		skb_reset_mac_header(skb);
 		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
-		return PACKET_RCVD;
+		return SKB_NOT_DROPPED_YET;
 	}
-	return PACKET_REJECT;
+	return SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 
 drop:
-	kfree_skb(skb);
-	return PACKET_RCVD;
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
 	struct metadata_dst *tun_dst = NULL;
+	enum skb_drop_reason reason;
 	const struct iphdr *iph;
 	struct ip_tunnel *tunnel;
 
@@ -377,8 +382,10 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 	if (tunnel) {
 		const struct iphdr *tnl_params;
 
-		if (__iptunnel_pull_header(skb, hdr_len, tpi->proto,
-					   raw_proto, false) < 0)
+		reason = __iptunnel_pull_header_reason(skb, hdr_len,
+						       tpi->proto, raw_proto,
+						       false);
+		if (reason)
 			goto drop;
 
 		/* Special case for ipgre_header_parse(), which expects the
@@ -401,40 +408,42 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
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
+	return SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 
 drop:
-	kfree_skb(skb);
-	return PACKET_RCVD;
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
+	if (reason == SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND &&
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
@@ -453,16 +462,17 @@ static int gre_rcv(struct sk_buff *skb)
 	reason = gre_parse_header(skb, &tpi, false, htons(ETH_P_IP), 0);
 	if (reason)
 		goto drop;
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
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

