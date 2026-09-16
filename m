Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE15335B1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569454; cv=none; b=YAgwfxls8cIh/7NoPdWd9Bm7WFM+ion0uwEq7167x6McrAjYd5nNpZyQP4adSN11PKH7lC29wM61US6iguce8SRpUIjv8ElMlyYcJ5iSrNysZ3hpuFhIcxSBccXnb6E06xagw8/u7jH21K7qIZxjtGorfo3hQVxAzXJ7uiX3QzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569454; c=relaxed/simple;
	bh=TL5RDsgR3q3rNoxaBtuxVQUD5JBfU63nw915qZTE9T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6jGjXeCRDsdiDY0+R2Q257yAZ3KrYfgwj5FF22Z3fyb7wmPZElq0XWayFP6IwTdBT5KiTBxdLQK7YGs7CGGrNb7JY+AHHzofROKH5veKdQQB3hsNIQ3HInot8HTFaSIQA6lAr2POof9y2pypmV/LyOG9vk5oHm8osQbnKelh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlrjGE2k; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlrjGE2k"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15b79so986877e87.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789569450; x=1790174250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49hTZf7QlRMaCxSNEmZ3eVg+9HKmB4MI7noIxZyhpu0=;
        b=LlrjGE2k9yVazxoxmkkl8uLeF3f/3ZB0pseTJTNSwsWbUSozM9yEIWXW7SeJIaFHkw
         y63a4gcMgzlFWLZP9eN5dMujdMFz9ePLvHEH8IVXF/3GzZ70qqIuMJoh9XMYmppugMKI
         1o+QHmaN57xhZbJ8fYbtJtdJLQ9b4cTuDf3iqBwKe7cCmluHokiUT0ne0gFB3kMrEIjk
         DEBKk8aIJPnO2xd7/VUNfAn2Wyf5/xsJl4PNKBYQCTS8PPyHfGAR7X1/qwCW0AIG2iKC
         ANcCPbFiTvonCmeVwCNHwg0qdaAmz+3qloT/wZf+M0em/iIDoDcIOpplROW085NycWPg
         20SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569450; x=1790174250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=49hTZf7QlRMaCxSNEmZ3eVg+9HKmB4MI7noIxZyhpu0=;
        b=ZrthTaq4rSefNy8L47eXIdIIsfooEIvlbHGDBMPl0n+d6LlUHje9QxJJVfZpMx6/uy
         UBRMskZgTGAuyXleaT6ZpjJkNccpAftA9B98PwtM+GFxneM2NcsVwAZaoL6+8ndniAVK
         /GpWA7OqkpOKa7mWoGrPytnIMAMnpZxWyT2ihAT5zmXOoppX+mCUVnVCOf3KUIVtM22x
         hrpYnP+XsPEB67jDjaojRjYVImcfcYuR8cTR0U44G2PYZIt0mla9R1Cp3eWuKT26oww2
         1o8rrUOOKKKUFolILqqYvHNC6EfyVHZsq2zw5uYXqg3lDiBUPIGPdZS12FFucKj3QysG
         DKgA==
X-Gm-Message-State: AFuF++mpVdWvgigehlSr3gXQzgzF4ooaXxwI9A6PYl3SGXnXg8o4LcmU
	1fpozSRuqnBQeKFTHONZWoOwq3YaBbKMIQ5K38Ec25MVD+PikogQVDwGQ36bK+M9bvw=
X-Gm-Gg: AYBFou0juY7qttOZ1sv+Mj4tDPVWhEcpr8VBtCqZxZl+nTYAocA+kRTTnWM4jbbwYIU
	o/YGpMYhWuqboiw6PgPrqAdFPdwGg+fE/Xz6o29lnVj6ZlrV8toQreewoPLNXV5bdYleIU/nzWy
	Hjn5ZWeiTS3MBT9MNyijk18HBrP6Tpjcg9fb33TkL+fhA7XSfyCSE0GbI4DuBnjRNw+KZ9oIh8t
	9IIaXPqyd20FR9HSxB+qwRJo+wRoQG+poAmqGEud4nGLLU5YkCk6JGK0w5L22J03eFfNGlc7U8V
	AMzQ++57mRkgeHTPjDGXcHMb2kyU2ZUeoCbPxsnK7T3zHCdtSCUyO+S7LeAFCZaOojjOzo8iBmP
	fnn3K7J2JrwrdyfDDq8lw5cgDtYAPt5Gu3bUoIeOg3tI21ws5TNTXbhqU/bV58BKQX1bXn1+CPF
	c5IPTfKlZsHi9139SwWUccgp1FPbJuMPhL+Lin2HtM8pyvBvgKWTb/9cd7YWol958CltpPbuUMK
	NYEIbqIyR0tBVgHRuUCjqfNGLPyPzejs+XFV9ylg4HcPD7oeTGDap3cxkiE4CHtZr1FaBFSwyg=
X-Received: by 2002:a05:6512:12cb:b0:5b5:e265:5215 with SMTP id 2adb3069b0e04-5b8b66547c1mr1634916e87.22.1789569449626;
        Wed, 16 Sep 2026 07:37:29 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57eb908sm955658e87.79.2026.09.16.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:37:29 -0700 (PDT)
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
Subject: [PATCH net-next v3 4/9] ip_gre: add drop reasons to the RX path
Date: Wed, 16 Sep 2026 17:37:12 +0300
Message-ID: <20260916143717.1875082-5-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
References: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A packet that reaches gre_rcv() and does not belong to any tunnel is
dropped, after an ICMP port unreachable is sent back, with a plain
kfree_skb().  This is the GRE counterpart of a UDP packet hitting no
socket, and by far the most common way a GRE packet is dropped on
receive, yet nothing tells it apart from a malformed one.

Add SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND for it, in the spirit of the
existing SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND, and report it from
erspan_rcv() and __ipgre_rcv() through a new output parameter, so that a
failed lookup is not reported the same way as a header that could not be
pulled or as a metadata allocation failure.

The length checks reuse SKB_DROP_REASON_HDR_TRUNC.  The
__iptunnel_pull_header() failures reuse SKB_DROP_REASON_NOMEM instead:
the helper returns -ENOMEM for every failure mode, and besides a short
header it also fails when skb_unclone() cannot allocate, so a
truncation reason would be wrong there.  vxlan_rcv() labels the same
helper the same way.  The metadata allocation failures reuse
SKB_DROP_REASON_NOMEM as well.

SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND is documented without naming an
address family.  The IPv6 side is converted by the next patch, which
ends its lookup failures with the same reason.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  6 ++++++
 net/ipv4/ip_gre.c             | 37 +++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6ae7a604722d..fa8bd552122f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -133,6 +133,7 @@
 	FN(TNL_OLD_SEQ)			\
 	FN(GRE_INVALID_HDR)		\
 	FN(GRE_CSUM)			\
+	FN(GRE_TUNNEL_NOT_FOUND)	\
 	FNe(MAX)
 
 /**
@@ -637,6 +638,11 @@ enum skb_drop_reason {
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
index 1894c5746a73..dc203937eb9f 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -265,7 +265,7 @@ static bool is_erspan_type1(int gre_hdr_len)
 }
 
 static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
-		      int gre_hdr_len)
+		      int gre_hdr_len, enum skb_drop_reason *reason)
 {
 	struct net *net = dev_net(skb->dev);
 	struct metadata_dst *tun_dst = NULL;
@@ -289,8 +289,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 					  iph->saddr, iph->daddr, 0);
 	} else {
 		if (unlikely(!pskb_may_pull(skb,
-					    gre_hdr_len + sizeof(*ershdr))))
+					    gre_hdr_len + sizeof(*ershdr)))) {
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return PACKET_REJECT;
+		}
 
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
@@ -306,8 +308,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		else
 			len = gre_hdr_len + erspan_hdr_len(ver);
 
-		if (unlikely(!pskb_may_pull(skb, len)))
+		if (unlikely(!pskb_may_pull(skb, len))) {
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return PACKET_REJECT;
+		}
 
 		if (__iptunnel_pull_header(skb,
 					   len,
@@ -327,8 +331,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 			tun_dst = ip_tun_rx_dst(skb, flags,
 						tun_id, sizeof(*md));
-			if (!tun_dst)
+			if (!tun_dst) {
+				*reason = SKB_DROP_REASON_NOMEM;
 				return PACKET_REJECT;
+			}
 
 			/* MUST set options_len before referencing options */
 			info = &tun_dst->u.tun_info;
@@ -356,15 +362,17 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 		return PACKET_RCVD;
 	}
+	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 	return PACKET_REJECT;
 
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
 	return PACKET_RCVD;
 }
 
 static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
-		       struct ip_tunnel_net *itn, int hdr_len, bool raw_proto)
+		       struct ip_tunnel_net *itn, int hdr_len, bool raw_proto,
+		       enum skb_drop_reason *reason)
 {
 	struct metadata_dst *tun_dst = NULL;
 	const struct iphdr *iph;
@@ -400,22 +408,25 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 
 			tun_id = key32_to_tunnel_id(tpi->key);
 			tun_dst = ip_tun_rx_dst(skb, flags, tun_id, 0);
-			if (!tun_dst)
+			if (!tun_dst) {
+				*reason = SKB_DROP_REASON_NOMEM;
 				return PACKET_REJECT;
+			}
 		}
 
 		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 		return PACKET_RCVD;
 	}
+	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 	return PACKET_NEXT;
 
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
 	return PACKET_RCVD;
 }
 
 static int ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
-		     int hdr_len)
+		     int hdr_len, enum skb_drop_reason *reason)
 {
 	struct net *net = dev_net(skb->dev);
 	struct ip_tunnel_net *itn;
@@ -426,13 +437,13 @@ static int ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 	else
 		itn = net_generic(net, ipgre_net_id);
 
-	res = __ipgre_rcv(skb, tpi, itn, hdr_len, false);
+	res = __ipgre_rcv(skb, tpi, itn, hdr_len, false, reason);
 	if (res == PACKET_NEXT && tpi->proto == htons(ETH_P_TEB)) {
 		/* ipgre tunnels in collect metadata mode should receive
 		 * also ETH_P_TEB traffic.
 		 */
 		itn = net_generic(net, ipgre_net_id);
-		res = __ipgre_rcv(skb, tpi, itn, hdr_len, true);
+		res = __ipgre_rcv(skb, tpi, itn, hdr_len, true, reason);
 	}
 	return res;
 }
@@ -457,12 +468,12 @@ static int gre_rcv(struct sk_buff *skb)
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+		if (erspan_rcv(skb, &tpi, hdr_len, &reason) == PACKET_RCVD)
 			return 0;
 		goto out;
 	}
 
-	if (ipgre_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
+	if (ipgre_rcv(skb, &tpi, hdr_len, &reason) == PACKET_RCVD)
 		return 0;
 
 out:
-- 
2.47.3

