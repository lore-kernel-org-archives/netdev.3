Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5551CF66
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115328; cv=none; b=doYxWO6WRCG87UdvT+Jp0WZSwLY+R3LEZKOQUJhn6J+beWiXGv5Q5508zbhLeR4ufWDSkLR5pQ8FzrqJxnkE6bIc8NBKeCi8hBGvGfdKX9z5KV8XiRNDTHQQKFvNM1l9v+CjZaL0/0PUqJR5Eaab3V9ZrirfMp4jfAMY+C68vMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115328; c=relaxed/simple;
	bh=tTFIjP2lUqDo4uBQnAC7/4MAr+5gOE+O65czI4FkXPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVA9RU0iRfEavj24N9uqqYacXU2ZxDQRQYPisttSOdo/BDSYI9UJYHLu+Tw9OujWYHcZRkx2ffOffsiHT84y0wdBHM1Riq/HW1VRRcjyfW3nIM2nq4Alq+uNBu4rNAZQdEOZPMJoWVD/fpxLigBrdhuhTvNJe1TMDenUQ3B7QlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnL+rlg5; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnL+rlg5"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1744eso210041e87.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115316; x=1790720116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxrxF4xisblpUZV/JRrokwxludzSUbZ0J3lAsXbm1I0=;
        b=RnL+rlg5nByHOOINTtjiqgEfFvNOHTeWZ9Xe5lRmUk6ASPhycB7gWamQgp0lt30gAL
         pj/UHyIGn3QOZgQzPR3hGTIj4gCBLlFcvwqadbAA4pVkAg7FAkW9YcQgvs4daC9FB+f5
         Q+NY09q0LudgyVlpuR4L+ghv+to8FGyBr7NMBHud9mUjeiz048kC+n1VjCwNBgMCHpoz
         6HsYDN0l7oFOEEmTRY8gsCYJGAQ4mt/df/3qNUcVXPv/MONayoPVtWHELJCfH/S1xi2s
         wiDdu7XoUp2EinzC1DZPADEZnK3+V9Qedw7qr5ha9P7KvA0s6X/IqUXSMiDeJYgNW/Ts
         yA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115316; x=1790720116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxrxF4xisblpUZV/JRrokwxludzSUbZ0J3lAsXbm1I0=;
        b=dlXQFjYuOAXMjFJmpIqAGmdzYla7G/WRDtqYB1Qzbx103AFq+00cGoPbxMJTQ9/ZsY
         2rzXhVcbAR59N2rCc5iZqhpELByEeBn0Vbu6++hbMD+hbb9xYoCuN+ldWUfeDYqwOP3B
         r9AbueFRQ7FO3AIbJGp34dPHuawGu6N0RRkQbPhxuRjJB6qdDbmj9VO3f9BpP4S/rIoL
         K6bMmeg2V0fua6Cy12OHDNrWBoCh4Am4lVBgq6TSTXHDuPYMd1hlhcJcr3wV10tC7cAq
         QAvU/ufIRc6NEityHzYz3NS0F5/ADXKqlorXhtH3H/LQMj4+cLv+ovrCCAnwRr/cNUML
         dBJQ==
X-Gm-Message-State: AFuF++mxixrs6v8T6k8kOZAu3zsV09KGblM5t13wXsoV0i1wURMV1R47
	mqsx7M+E25RmYGxvkW9YDmVO1r6IHeDvz3GbeoOHChK2YNK7NvTB6TCvGGVObqA2pfA=
X-Gm-Gg: AYBFou2/Rixt75pNFeIehrJlt2UGHi1PPX5OmNU4UFAg4EfIwmO4dgDxHX0ZWkhbvZN
	OJxDCnt4MGWOglWmY6gGLYXgX153xBKYRLd/6HJh39D1W2pZmU91Ywzxm0iJ8d5kFMdomLUcxff
	t8iQVd3bs3MAEMSyTBpds8yKvvBBtbW6vkiPeuaiCzfHXZNcqG+/KQX8ApTy3H745ujx4byZ05z
	Vzl0Ub1mBZWe7cRkr4t+1cn3HyTPWYsfxSWUR8AyI0q8Z27WifcBJy6SzkKERGvr0g9ueGDLZzg
	RWden4T1XpmsGPNETgRNXnuT02igxbsSDlqEBKOAhQ8P9FJtTU0o5YvKU3Y5YAut2UeYKFUpNBq
	DCny6N/VSEAPdhk/FMQ/0CIJeokQTD2GSDSReloXmmT10wfp9zKhQKXv82jR/zy6V5/wtcTjD9c
	H4O3RS+Y2B0OAk53JA0yZKYLtPf9wnUXHe/it/X0PAPY8AZKY9ygKlUh41YlXok/eHYUIwLXXRx
	6eH6Gky6AbrinnNJ2HqPtD1D+Gkx2xDc2Gv8cIzAWqpQa3mCkyUCYoxK1J6Aw==
X-Received: by 2002:a05:6512:2241:b0:5b8:99b1:4875 with SMTP id 2adb3069b0e04-5b8d8971e57mr185828e87.28.1790115315639;
        Tue, 22 Sep 2026 15:15:15 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:15 -0700 (PDT)
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
Subject: [PATCH net-next v4 01/10] ip_tunnel: add drop reasons to the generic RX path
Date: Wed, 23 Sep 2026 01:14:58 +0300
Message-ID: <20260922221507.3268127-2-littlesmilingcloud@gmail.com>
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

ip_tunnel_rcv() collapses four distinct failures into the single
kfree_skb() under its drop label:

 - the tunnel options carried by the packet do not match the tunnel
   configuration (checksum or sequence number),
 - the sequence number is older than the expected one,
 - the inner network header cannot be pulled,
 - the ECN decapsulation check fails (RFC 6040).

drop_monitor and the skb:kfree_skb tracepoint do see these packets, but
all four as SKB_DROP_REASON_NOT_SPECIFIED from the same call site, so
neither the reason nor the location tells the failures apart. Only the
device error counters (rx_crc_errors, rx_fifo_errors, rx_length_errors,
rx_frame_errors) hint at the cause, and they are not tied to the
dropped packet.

Add two drop reasons for the tunnel specific cases and reuse the
existing ones for the rest:

 - SKB_DROP_REASON_TNL_OPT_MISMATCH is used when the packet lacks the
   checksum or the sequence number option the tunnel is configured for,
   or carries a checksum the tunnel is not configured for, as the
   checksum check compares both ways. This is a configuration mismatch
   between the two endpoints rather than a corrupted checksum: the
   checksum itself is validated earlier, in gre_parse_header().

 - SKB_DROP_REASON_TNL_OLD_SEQ is used when the sequence number is older
   than the expected one. Unlike the previous one, this is a property
   of the received traffic: a remote endpoint that restarts and resets
   its sequence numbering has all of its packets dropped until its
   sequence numbers catch up with i_seqno.

 - pskb_inet_may_pull_reason() already computes a drop reason,
   SKB_DROP_REASON_PKT_TOO_SMALL or SKB_DROP_REASON_NOMEM, which has so
   far been discarded.

 - SKB_DROP_REASON_IP_TUNNEL_ECN already exists and documents exactly
   this check, but until now it was only used by vxlan.

The sequence number check is split in two so that the two cases can be
told apart. The error counters are left unchanged.

ip_tunnel_rcv() is the RX path of ip_gre, ipip and sit, the latter for
IPv4 and MPLS payloads only: ipip6_rcv() handles IPv6 in IPv4 on its
own. The checksum and the sequence number options only exist for GRE,
so the two new reasons are meant for ip_gre. ipip and sit carry
neither option and only hit SKB_DROP_REASON_TNL_OPT_MISMATCH if their
i_flags are given those bits, for instance through IFLA_IPTUN_FLAGS;
such a device then drops every packet that reaches ip_tunnel_rcv(),
with or without this patch. The ECN reason applies to all three, while
the length ones can only be hit through ip_gre: tunnel4_rcv() has
already pulled the inner IPv4 header for ipip and sit, and
pskb_inet_may_pull_reason() has nothing to pull for an MPLS payload.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h | 17 +++++++++++++++++
 net/ipv4/ip_tunnel.c          | 19 +++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 12f909651591..edbe58a22ddf 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -129,6 +129,8 @@
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FN(RECURSION_LIMIT)		\
+	FN(TNL_OPT_MISMATCH)		\
+	FN(TNL_OLD_SEQ)			\
 	FNe(MAX)
 
 /**
@@ -612,6 +614,21 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_OUTPUT,
 	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
 	SKB_DROP_REASON_RECURSION_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_TNL_OPT_MISMATCH: the tunnel options
+	 * carried by the packet do not match the tunnel configuration, e.g.
+	 * a GRE tunnel configured with 'icsum' or 'iseq' received a packet
+	 * with no checksum or no sequence number, or a GRE tunnel without
+	 * 'icsum' received a packet with a checksum.
+	 */
+	SKB_DROP_REASON_TNL_OPT_MISMATCH,
+	/**
+	 * @SKB_DROP_REASON_TNL_OLD_SEQ: the sequence number carried
+	 * by the packet is older than the one expected by the tunnel, e.g.
+	 * after the remote endpoint restarted and reset its sequence
+	 * numbering.
+	 */
+	SKB_DROP_REASON_TNL_OLD_SEQ,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 0875474a578a..c94f4c055027 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -384,6 +384,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
 		  bool log_ecn_error)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct iphdr *iph = ip_hdr(skb);
 	int nh, err;
 
@@ -398,14 +399,22 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 	    test_bit(IP_TUNNEL_CSUM_BIT, tpi->flags)) {
 		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
+		reason = SKB_DROP_REASON_TNL_OPT_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno && (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
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
@@ -419,7 +428,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 
 	skb_set_network_header(skb, (tunnel->dev->type == ARPHRD_ETHER) ? ETH_HLEN : 0);
 
-	if (!pskb_inet_may_pull(skb)) {
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
@@ -434,6 +444,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		if (err > 1) {
 			DEV_STATS_INC(tunnel->dev, rx_frame_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 			goto drop;
 		}
 	}
@@ -457,7 +468,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 drop:
 	if (tun_dst)
 		dst_release((struct dst_entry *)tun_dst);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_rcv);
-- 
2.47.3

