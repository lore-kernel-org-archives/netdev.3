Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5645208D5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793572; cv=none; b=eB7ADoU8pZz2jVnZ+S2eZIT40lVnU0PZOy4lQpmiyvzcO1f6T7KXI+/4+KN+imUj6UxZAhoSxtjITu3VVSdHtryhDBGVgQ8hnE/PMOD6oi2r/sDwoAyUoZU/lBWqH0sKtZCnt6iXBkoVMgONAhHFfCVHRei+iKa21B3s8Hr9c0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793572; c=relaxed/simple;
	bh=/M7jRAcTUnFr6Fn9q5QJ7UlD2GB2NblnZHIzRiqBxPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ubn6kBGQ+7sUOJBF5yTyoXUxlnIc1AlIFgkPUhQrsuP8ixoO6d+KyUVsiBOXlJSf5EC+ox1X21RX/vrCjp/XzYTQ+777hEoOf+JUBGHcbpw1qifAJ3eV5eKUikqZ35lLFPK4LpahJzIDfZo4nF8re5ChPCW6MfLS1boeVNeNLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqid2CFf; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqid2CFf"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e6ec4dd4so4452869e87.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793568; x=1791398368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoMU6K7v8vhHo5wItw+motBZbxKiQ1CoXqNZvOfiOtY=;
        b=jqid2CFfHEZQedqBEP0+Op6Jpbiu6q+IYhZaGV+p7M7IEraMyumEq7UaWJjp1+5Z5T
         BPfJDk9F6Q4hFFBJ50ZfMhFN36rcIfFxz4OkNZpU3kKledk9pkcxTOmaAlRqd8vasK4t
         YbUEgBpm6XIVs/ghAQiNgXTVez3dNq7CmNFKVk9pzGTOM7LocR3GxSNlq/tniHK3+rxI
         xpUvuSXbfOXADrQio/+QLQtnHPj3Yw0yiUxykGcFvO+SRxm/d7wt4OSxTYeTuQkN5w+Y
         +0psEZ4ygiozjhz/XdtHzTPpe64cwMalHSaUg5LON4wZemW4ieaxP6Z484s82vu2w7PX
         JB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793568; x=1791398368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoMU6K7v8vhHo5wItw+motBZbxKiQ1CoXqNZvOfiOtY=;
        b=dY//9DzCqsOyjtP5sVZ5rLEH3g113IZeYak707KIOZlr1/dbMTPpLX8umbPBPCKVAB
         W4GxOo//+THvISEKOimqoFtAgQP62CLzQEowA9kms0lp/JjTRu4TY1No+SXuv05nZvm7
         sDfGKYIRvEaQKx/6kF8bGMZEw5Od0STwEIWMmliGNc4Ev+o4pemEYM/KLbhntJhEXlym
         HHutRpUEmqOe9Vw1bbFkL9OZ3mrtT56d54qFH0Bk9jSqJjSCNqCnY+bVaxocgCQ4W2I1
         oRH58rhwwrb+pkqxb9epoIga2RIOJSXJPEGOgtql/36zoETINhaw/t60jD2J7SMjG+5n
         UpLQ==
X-Gm-Message-State: AFq9FYLatfU3tmI6Euvnoo+mvgrCFVRq4z6CCX8FfjDaIViVpIcN+Ewy
	fbmZbfVVzzJ6keJJ2igJuLsa7P4n7Wy1Fdbd2SVzSw0YiTdz3y/RALriBsMuKvOi
X-Gm-Gg: AYBFou06L5Bcfi4ToNUSPbPC7XS8M9I8Obn0DtE5i0v9HMbc0gK7mwX4dpD1uWQTYQL
	gJIFVzCngAcsZzfX+DT765waqBbaBwhxITKCwg82Hbv6mCvzHak73zd/w0oiYa4d8CMsSDH2VoS
	ldn31lu+LPvT3bINfBToqzJRt2UJe5fWhic771baX3GnSyif2+9jEEpEikXe37vlfXmWUMk2OPv
	fX7pjHSG1aHdpb/xd6ukVf+yEl1eUApTP0BywpTvyB9T2SW6VCAjVGP6EyRQJHUmMP7jO+i1tCQ
	SojC4Ozz2uBaFjfqaTZ8g7gMFpwiuPLypPLiM71VKy/so6UrzSXbgrz9fiXVNTUF9XyaRap9D5p
	PNc4mQWMvy7zQpr76+1bz22hZCbnRu5wVKmnula4w1N2/tIw4NyD2eSBmkIq3I5FWT2kElF3Vrs
	E2mD0mK1iKBQ59Xegynf25UTQw0HxQCY5v4qAjYcCOtCvhUEXsUslA8CngBdzyu33aiuObn59AG
	lzE0NuMYfY/yWpW2koaXECKdxobxq1kCInQNa8c+cGW
X-Received: by 2002:a05:6512:3a92:b0:5b8:bc5e:d0fb with SMTP id 2adb3069b0e04-5ba405dde9emr914707e87.37.1790793568023;
        Wed, 30 Sep 2026 11:39:28 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:27 -0700 (PDT)
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
Subject: [PATCH net-next v5 04/14] ip_tunnel: add drop reasons to the generic RX path
Date: Wed, 30 Sep 2026 21:39:00 +0300
Message-ID: <20260930183910.3151873-5-littlesmilingcloud@gmail.com>
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

 - SKB_DROP_REASON_TUNNEL_OPT_MISMATCH is used when the packet lacks the
   checksum or the sequence number option the tunnel is configured for,
   or carries a checksum the tunnel is not configured for, as the
   checksum check compares both ways. This is a configuration mismatch
   between the two endpoints rather than a corrupted checksum: the
   checksum itself is validated earlier, in gre_parse_header().

 - SKB_DROP_REASON_TUNNEL_OLD_SEQ is used when the sequence number is
   older than the expected one. Unlike the previous one, this is a
   property of the received traffic: a remote endpoint that restarts and
   resets its sequence numbering can have all of its packets dropped
   until its sequence numbers catch up with i_seqno.

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
neither option and only hit SKB_DROP_REASON_TUNNEL_OPT_MISMATCH if their
i_flags are given those bits, for instance through IFLA_IPTUN_FLAGS;
such a device then drops every packet that reaches ip_tunnel_rcv(),
with or without this patch. The ECN reason applies to all three, while
the length ones can only be hit through ip_gre: tunnel4_rcv() has
already pulled the inner IPv4 header for ipip and sit, and
pskb_inet_may_pull_reason() has nothing to pull for an MPLS payload.

ip_tunnel_rcv() initializes the reason to SKB_DROP_REASON_NOT_SPECIFIED,
since its first statement does not set it, and its drop label falls back
to SKB_DROP_REASON_NOT_SPECIFIED, as in vxlan_rcv(), since
pskb_inet_may_pull_reason() stores its result in the reason. Together
they keep a drop without a reason of its own, including one that a
later change adds, from freeing the packet with SKB_NOT_DROPPED_YET. The
rest of the series follows the same rule wherever a function has a drop
label: an initializer unless the first statement sets the reason, and
the fallback wherever a helper stores its result in it.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h | 16 ++++++++++++++++
 net/ipv4/ip_tunnel.c          | 20 ++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 40a27d8887af..85aaa58c3ecb 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -129,6 +129,8 @@
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FN(RECURSION_LIMIT)		\
+	FN(TUNNEL_OPT_MISMATCH)		\
+	FN(TUNNEL_OLD_SEQ)		\
 	FNe(MAX)
 
 /**
@@ -615,6 +617,20 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_OUTPUT,
 	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
 	SKB_DROP_REASON_RECURSION_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_OPT_MISMATCH: the tunnel options carried by
+	 * the packet do not match the tunnel configuration, e.g. a GRE tunnel
+	 * configured with 'icsum' or 'iseq' received a packet with no checksum
+	 * or no sequence number, or a GRE tunnel without 'icsum' received a
+	 * packet with a checksum.
+	 */
+	SKB_DROP_REASON_TUNNEL_OPT_MISMATCH,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_OLD_SEQ: the sequence number carried by the
+	 * packet is older than the one expected by the tunnel, e.g. after the
+	 * remote endpoint restarted and reset its sequence numbering.
+	 */
+	SKB_DROP_REASON_TUNNEL_OLD_SEQ,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 0875474a578a..6d500751f837 100644
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
+		reason = SKB_DROP_REASON_TUNNEL_OPT_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno && (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
+		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags)) {
 			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TUNNEL_OPT_MISMATCH;
+			goto drop;
+		}
+		if (tunnel->i_seqno &&
+		    (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0) {
+			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TUNNEL_OLD_SEQ;
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
@@ -455,9 +466,10 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 	return 0;
 
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tun_dst)
 		dst_release((struct dst_entry *)tun_dst);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_rcv);
-- 
2.47.3

