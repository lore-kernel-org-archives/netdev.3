Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84912385D79
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271405; cv=none; b=pEc0AAhycX48U1u4Nuwdhpm43iuBI3Xshv/K10m/mIUscTv/DFyJFkUqP32yYBSweC0x9eJ2azTcvMxeL7XOaG+MUjg9oK0RDOhk0sZJIjihOMvndjpAAuQVCc7sfSNoa9XFjn8B2x888cwWV1kojQ/bo3xmIaY56sSfh5SQ/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271405; c=relaxed/simple;
	bh=o48wrWvjoIliI06ZgFy+hiyAVOP8nZdeFGGfqhQTNCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcHQuJ4f5r/2gni+x2KQxWfbfaNba5h9pW2L2mYgPi37E+65FYjGUnlrbzL8U220VnU/JIMQv3U5xgClUTbOT/DcRwJTuA5Ai/7XkthzFJntA22rSQGxHXDRGGweOsXWS+zGefwfD3JuaVqJadvAgsa5EmlCbLD9MTcu0JqYRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcNHpHtq; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcNHpHtq"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff16dd47so6481761fa.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271400; x=1789876200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unzmUg06rWGBT2CRAbdUbshSQgFHbsBrT0vOi+rL7PM=;
        b=bcNHpHtqIBFY+JEfrqPVpPdQdKESsbsRs+EVNR7zKJ3+ihPYuMZ2OzG+9TpG4V66c/
         LIH5nErmecw8FR3s0lNE17gFinLshTkx/W+psYj6/ILnMXtccOf1llnQsQ4bjHWRkWt2
         BYiKMLFSk+J6vpOnZd5glpFJ/8AI8GLZDC2rFS+iMIRl/nETsAIg6LBWSiB2VKE4yRo2
         CnE1FECu+Uup17In88/txbvausTWbu0Hgwxd/YFvzRdvf1MuJZGB5ZSwhBMzU995gzCd
         MV076IFe3mFmg3Vnz1jElwF2p0QtVy4yYUGDq6IjtBRG/P+2/myD43GD20SMoR5E6pU/
         heCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271400; x=1789876200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=unzmUg06rWGBT2CRAbdUbshSQgFHbsBrT0vOi+rL7PM=;
        b=erUXhBHF8sHUdAAnL7IofY4c2WSxk9ceLneyg+5IqL526O5/Vf/9drTqZRFguQGMWL
         quW/XA3vI+c6fr3NkDGw4Fb4Zl7+FeW5ZQU8eKaLVXBPHc1xNb0dXy6zrsCE7nW0MZI7
         vQlt4YWjW3SZX9TouhgVBH4wAAFSV2LPOBg81wLl6/zhc3XD7xJI84Ax+8Otb4Mu5j2x
         QPzumi2m5cRgjM77n8hnOxh7dmU8+fnPpNyCeMwYxm4sbwfIpLTj8tk/UBmFfxJuSB4q
         uEDE7IiCYu6inC1bot6d9YRI+p5OSTp595iluY3jzDf6smaLFZgSnDDJJuHWfrLspD9u
         Nrqg==
X-Gm-Message-State: AFuF++kAZB/8y7uUJZ7EsSdFPK+/bvOp2RJV+MUjyjZc4G7KB/BKmGRz
	oJMVrfItpYimL7VDxFZIYAf4BfwmUbVVi6AvFE72lwnE5xWJhxhJ3N1lXJDm4RTkZ+0=
X-Gm-Gg: AYBFou333BqdDTXEZCn6Vk7zRZtdLL+z33KCIaozSStUgFmuww01EMbDCCfZy4b9jbT
	DGl9/sqoTvVwPMrB3AJkBSEA3ieKuAlh5+1e/d+adIgmAsqtXmddS/uJ7Ti/EtKdBUut7l0OAfQ
	r3xYiPXRSEL6N6MMtMWKdNNkvU1fO4l0nAYJjy6aFLxvlhPAzB8elvNjpzC0pwjp0DRyPJg/wn5
	u54HymB7/PFysk14lQ0xC57AXM93EHAGcoH/lWK4EuL9a/I124xq+ooYBnog4HX7FG/ei13T2zb
	xdwoNgyqlzwiNOPitJIHmDPoGIETKABcuopsr7S1Euy7vOon/hlxyhARzlPIjXXI1tgO49bgqDf
	MGAnwmdIuuk/L48W9/MzKR9REswsH2f0NOMIIppYynAO4eX3eGRHwUtRtD4N9S1MSPTHdz+Q+oI
	cEanQVTJ2tFxPtzgN/v7tfx52ainHhMcJPcKC/KX7NriUxLRwe2mbtaWlvMlZK/XpVPz6hE4L1Z
	Spe919ui5bqwnUVhPAo53dUASkD+0Vd77/c12d4HhKM
X-Received: by 2002:a2e:9a15:0:b0:3a3:74b9:8a7a with SMTP id 38308e7fff4ca-3a5b382d744mr6509791fa.19.1789271400106;
        Sat, 12 Sep 2026 20:50:00 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a332737dsm17277051fa.22.2026.09.12.20.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:49:59 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/8] ip6_tunnel: add drop reasons to the generic RX path
Date: Sun, 13 Sep 2026 06:49:31 +0300
Message-ID: <20260913034937.875068-3-littlesmilingcloud@gmail.com>
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

__ip6_tnl_rcv() mirrors its IPv4 counterpart: five distinct failures
share a single plain kfree_skb().  Reuse the drop reasons introduced
for ip_tunnel_rcv() and the ones the length helpers already return.

Note that skb_vlan_inet_prepare() returns an enum skb_drop_reason that
was simply discarded, and that pskb_may_pull_reason() has been
available all along.

__ip6_tnl_rcv() is reached through ip6_tnl_rcv() from both ip6_tunnel
(ip4ip6, ip6ip6) and ip6_gre (ip6gre, ip6gretap, erspan).  As on the
IPv4 side, only ip6_gre sets the checksum and sequence number bits, so
the option mismatch and the old sequence reasons are reachable through
it alone.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..458ce328311b 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -813,6 +813,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 						struct sk_buff *skb),
 			 bool log_ecn_err)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct ipv6hdr *ipv6h;
 	int nh, err;
 
@@ -820,15 +821,22 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 	    test_bit(IP_TUNNEL_CSUM_BIT, tpi->flags)) {
 		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
+		reason = SKB_DROP_REASON_TNL_OPT_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno &&
-		     (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
+		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags)) {
 			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TNL_OPT_MISMATCH;
+			goto drop;
+		}
+		if (tunnel->i_seqno &&
+		    (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0) {
+			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TNL_OLD_SEQ;
 			goto drop;
 		}
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
@@ -838,7 +846,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 
 	/* Warning: All skb pointers will be invalidated! */
 	if (tunnel->dev->type == ARPHRD_ETHER) {
-		if (!pskb_may_pull(skb, ETH_HLEN)) {
+		reason = pskb_may_pull_reason(skb, ETH_HLEN);
+		if (reason) {
 			DEV_STATS_INC(tunnel->dev, rx_length_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
 			goto drop;
@@ -859,7 +868,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 
 	skb_reset_network_header(skb);
 
-	if (skb_vlan_inet_prepare(skb, true)) {
+	reason = skb_vlan_inet_prepare(skb, true);
+	if (reason) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
@@ -881,6 +891,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		if (err > 1) {
 			DEV_STATS_INC(tunnel->dev, rx_frame_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 			goto drop;
 		}
 	}
@@ -898,7 +909,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 drop:
 	if (tun_dst)
 		dst_release((struct dst_entry *)tun_dst);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
-- 
2.47.3

