Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575638F254
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271411; cv=none; b=i1mAOy548wyGhaop6teWyp4szP3EHVnJdZ1y5VMqAP6gFsmGswz5RU6slLxSO5ctgZXj8gLioSbBLE0LY/MmI4MAIC+y4gHbzw16nVrlHqcP8Gmv6e6FmrSjgRPS/bDUqXP3vja1AOcHvqRJvn9fkad2EUfTxIrFIsPtUuwCeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271411; c=relaxed/simple;
	bh=/D5+jnWrGXf/9Ql4Y4axRz9xJrB1SxATj+tGKiu91es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb//tWW2cSFtaFiwkhnPe10WvUM+wHWnxgc4k5qOUDClpsbzH3MpD2ArmUIEGX8fuiSxvSmIEBEFGJyULR628XOgFuFDTAXMkiOSXLiYhb0axHGA1FXyW+SkUwq8ct7C3v1P9TKPqL0ZW3sj4aEaw/jtCXjuFdU/JI0ZV10iDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfB+0PjB; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfB+0PjB"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff148dfdso5636401fa.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271406; x=1789876206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s5kc/PoxLnieZdrdEa77M8eaMfDxxTd0DuCYS/9794A=;
        b=YfB+0PjBaHhwhYTXye4pgTWDj+v7qXtkeYamsuNWudb31ngXa1NFn6NiFG5yxTIHw9
         HXjEIUe57IKtUtjga+c7l6oUKvd9V0VPy1X41Ck/h3Ba1otONBtZSuaUhlKb8zGGugq3
         1BDBXkM1ygLvulCe7p0j5V/O26/6Og6K8Qx2esdOktN34jECep6M5XQWljNSUsk/va4l
         q00UKUFKbOGfJP9xzCiYc1g72MbtcBO5GIachxwbBL/a77ZxzlyRlqTECxFqU8P6x9Hs
         JyXjeHN1H+BWiv4NFHcdGm9m6cBW4iRKK5FJdCiieLIX7GHlSsIRJqEU7uCONLZmoLXW
         kC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271406; x=1789876206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s5kc/PoxLnieZdrdEa77M8eaMfDxxTd0DuCYS/9794A=;
        b=VeZRdQfVcmKTUC9xLJsTgDEGM6xlK6ibr/4m5GeYn1JcRzlmMXJPcndV9U7tMqHg5N
         P2auLl8Jee8dYONFWLs5pcOK+H+A5gz6gY+ryIjUsX5k9fk4Vr/zGCC4BRxenJlP2lMM
         nraFw7PWvs0ALm9hgNegUdd2jhfl6FhNniqQb5jiK/8VC2WEMgzlEKFzCDh4ew5QdzYz
         Bck5hwYqe1FvU6CGJT+EUwl7+e35SpArvN1k3dGAf89UGE03Ag9wQMymOIPwF5eLeZMR
         +5euUDE4TI+BwDWa+8HL4v2QcwGy/12W1rmHSYr9F4yzr/oneot175Y0J3qa7bs/4hhQ
         9KBQ==
X-Gm-Message-State: AFuF++kJsFLqVZhujGL7yUvv1kLezHNj6Uo6EvqveUt1mhMP+0IblxyL
	yhPR3I59ZJlr6KkhEH6Wg37BthJ4Uq/tjsW2Ezig4CpIcFeJCpf7mm/2IJ8sSZZyiJg=
X-Gm-Gg: AYBFou0KfehS5qogw/mUuqQHBih+MYE8lcr/JyB6AQWjPqllBeK9HH6NFhQzXnOLq+r
	Y0Hqaw4teVK2v976lLB1/aSAlMnLac+8a50wwlVDE1MUGRvWvQGokMpj95GkO8fuf4SKdn9Smo6
	EYOL2IVD4AbhS2haGmfDT7UMGC2bv1Yt0HHAEXAXT0YmloJ8+XgIGztWd/DqBds7ypAwYkm38C+
	BINegLulw+YdhEtMSjsfwq7UvjZP44tWljtNNGNyCUS87vxNGoqruTNtG9WS57OLxUh4qOfWuzr
	wCnRA07Z+vtyMa//EIEOoGhRsbjFYMb1YxxoRggQ/25mMrV/IJ0t6GVHES5Apdy7Pi9lOoK1fhv
	OwKD9b7Q4TXwD+e5GkrZx/Bbom+GmZGPhMzJZcWzNtiaDFwXFMGNtwML+2woZdjCnZL6RLlTCdg
	lza+k8U+VyLGdVoo+nwQCml+c5wTc0NHd7oTCVNp4KmceN1tYgDeIF2SwlACCYtty/sxQRBzhVp
	+cTiZBVqg/mUz74skgWP+vaDG3QBrTMKWVPEEQZ2EUF
X-Received: by 2002:a05:651c:2124:b0:3a3:7681:6d66 with SMTP id 38308e7fff4ca-3a5b37f2198mr7053411fa.15.1789271405968;
        Sat, 12 Sep 2026 20:50:05 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a332737dsm17277051fa.22.2026.09.12.20.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:50:04 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/8] ip6_gre: add drop reasons to the RX path
Date: Sun, 13 Sep 2026 06:49:34 +0300
Message-ID: <20260913034937.875068-6-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913034937.875068-1-littlesmilingcloud@gmail.com>
References: <20260913034937.875068-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mirror the previous patch on the IPv6 side: report
SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND when no tunnel matches the packet,
and tell that apart from a header that cannot be pulled
(SKB_DROP_REASON_HDR_TRUNC) or a metadata allocation failure
(SKB_DROP_REASON_NOMEM), which so far all ended up in the same plain
kfree_skb() in gre_rcv().

ip6gre_rcv() and ip6erspan_rcv() get the same output parameter as their
IPv4 counterparts.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_gre.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 78854cc2dac9..047c4f57a828 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -454,7 +454,8 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
-static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
+static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
+		      enum skb_drop_reason *reason)
 {
 	const struct ipv6hdr *ipv6h;
 	struct ip6_tnl *tunnel;
@@ -473,8 +474,10 @@ static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 			tun_id = key32_to_tunnel_id(tpi->key);
 
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id, 0);
-			if (!tun_dst)
+			if (!tun_dst) {
+				*reason = SKB_DROP_REASON_NOMEM;
 				return PACKET_REJECT;
+			}
 
 			ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 		} else {
@@ -484,12 +487,14 @@ static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 		return PACKET_RCVD;
 	}
 
+	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 	return PACKET_REJECT;
 }
 
 static int ip6erspan_rcv(struct sk_buff *skb,
 			 struct tnl_ptk_info *tpi,
-			 int gre_hdr_len)
+			 int gre_hdr_len,
+			 enum skb_drop_reason *reason)
 {
 	struct erspan_base_hdr *ershdr;
 	const struct ipv6hdr *ipv6h;
@@ -497,8 +502,10 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
-	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr)))) {
+		*reason = SKB_DROP_REASON_HDR_TRUNC;
 		return PACKET_REJECT;
+	}
 
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
@@ -510,13 +517,17 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	if (tunnel) {
 		int len = erspan_hdr_len(ver);
 
-		if (unlikely(!pskb_may_pull(skb, len)))
+		if (unlikely(!pskb_may_pull(skb, len))) {
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return PACKET_REJECT;
+		}
 
 		if (__iptunnel_pull_header(skb, len,
 					   htons(ETH_P_TEB),
-					   false, false) < 0)
+					   false, false) < 0) {
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return PACKET_REJECT;
+		}
 
 		if (tunnel->parms.collect_md) {
 			struct erspan_metadata *pkt_md, *md;
@@ -532,8 +543,10 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id,
 						  sizeof(*md));
-			if (!tun_dst)
+			if (!tun_dst) {
+				*reason = SKB_DROP_REASON_NOMEM;
 				return PACKET_REJECT;
+			}
 
 			/* MUST set options_len before referencing options */
 			info = &tun_dst->u.tun_info;
@@ -564,6 +577,7 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 		return PACKET_RCVD;
 	}
 
+	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 	return PACKET_REJECT;
 }
 
@@ -577,17 +591,19 @@ static int gre_rcv(struct sk_buff *skb)
 	if (hdr_len < 0)
 		goto drop;
 
-	if (iptunnel_pull_header(skb, hdr_len, tpi.proto, false))
+	if (iptunnel_pull_header(skb, hdr_len, tpi.proto, false)) {
+		reason = SKB_DROP_REASON_HDR_TRUNC;
 		goto drop;
+	}
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (ip6erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+		if (ip6erspan_rcv(skb, &tpi, hdr_len, &reason) == PACKET_RCVD)
 			return 0;
 		goto out;
 	}
 
-	if (ip6gre_rcv(skb, &tpi) == PACKET_RCVD)
+	if (ip6gre_rcv(skb, &tpi, &reason) == PACKET_RCVD)
 		return 0;
 
 out:
-- 
2.47.3

