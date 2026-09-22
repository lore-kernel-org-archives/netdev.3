Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EE1515986
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115343; cv=none; b=a+NR71IuTmmJhDOYiyqiT258jyYw2hzItwvzPenS0vwKA2hBMZFECmfFl+o+Hkdux1iUpjsutssa86cWpUzpYEzyQEF4Wr/yN7aUuVlxZF7a6AJuDpkFAPugijfGtjd76hEWGQSOKKmCSsnMr4NguFbJCH/1d63ERvN8GGGn0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115343; c=relaxed/simple;
	bh=akINBqH8bKfMHpiHPFyy54jfDwjI28R2M536K1lp2iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf969jdKVsSGo7QKLaGXFOb7AIMV/2ssj2/vdgwLlIkkzukrpa/LLi0KoK+DYXryidsBq5MQHJ/FPSBmz+NDqQEF+Y3OagK+y9r4wZKa6V1eSlbnFrZ8VrMoVabz01qNzZPpqk5qRrUASLhlxNAUURlGEWD8IMPDL47D3yuk5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZTOsYQD; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZTOsYQD"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74dbc7359so265521e87.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115329; x=1790720129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKznpZ+XHs6sEOlMTkDpywIxPliYUfO/kSnJjfO+euc=;
        b=JZTOsYQDxxuN+jAso/LmR778lp/npsMkPJjY+fkUqpFzcTFu6v1Yzop0hLrJPY4VU1
         u083EhY6gKMVFNNS59RDvfwbF7gkx+oR1QadZRF4r7QdQR0CNWR9V48IPf9XpvbHNI3I
         6Rqp5Pdgg6dmhEDEa84SdtPKGnHTL7llNGGzcN0RA3u52Lb5U296Elz+9KX1fAIICL04
         Bj4iigj0GORO++tPsm00HyiOfZVUWwzV3eNsb7a9RDxGCjKrBmqk0xLMzOisYuNFiw1E
         Udn5rgiLQyViTh6bsL81KB1LhrM6+NYnV96P8N/fWX/IRxYQkPWp8oZUqI1MzqJIxAbb
         N8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115329; x=1790720129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKznpZ+XHs6sEOlMTkDpywIxPliYUfO/kSnJjfO+euc=;
        b=PufO/b1iLeWQap4YJSJSfrzsJftcMUSteqlMUI9t5DC/3wnzXGBvUzPHXE63ivzr3T
         Vdmb62laKu3WdikQmnV4BYqfC7deEOhKXBE2Q19fHn3tDnTk9EX/sXkJhrxgW1v3hjPf
         nCKAKnqQpBSK/Y5UZXd7DzFYNaEnHKMgxz4k3RSO4Ue/2lxF/iSjyK5rqygqYCk/ZXet
         APDhxdSXuX+q07BELawEBiCAeKvrh6ILCvvK8aHvqA7r9gEQrdTfsUhzr2tZjgXT2wT/
         SLM4y2E4Ib1WU/3Q/kjBD6p1AR60hgRCYqvyi/1SEu3rmKWstOof7XsKFFqxHcPqXor+
         AxtQ==
X-Gm-Message-State: AFuF++liOGdCYzAeena3CdiJymR1xWsPrLH8pkIYp4qnhTzhatYgry2/
	cNFsF/cVLRvLRd8bDq+4VRzSFnrV2OyRmLIjK+VYB+o4dOtby5loiK0LEnCJFSzpNAo=
X-Gm-Gg: AYBFou1F5FuMxQ411OllKUOyzvo1vq9rNDSiZ4zuNBAEmj86m1boIkpNOrq/iEzLDXZ
	JqwOr/00yVKEoap9jgyDcOm0WplJnJtsREuPpxzyG2PrWN5LmPkfl4dD09845DxJzKg1j01SZLP
	si7qOXMpur3p3Fk+HCuXVD9dM9FtpKflYhSLJw4SzZ01kvgsCryycCAYbihDH2MqIYHl42bIimL
	ZwDVtqrtNxC8YAiVSWzdHgPfHhbX5rGDYVv8R16Fp7lNQFWzJWDcVPkmJzl6GehCbahvSATk/8C
	9bcDgA8TU/dtPfmm7jo5VUrFhfil2PqOzuNzIUnor02sjkH/3GYqLmfFYHXOQITFyP1LlP8NgMv
	/aHCrD0PJUyck6JEbbd+YmiZ7Vb8YebSs7afxt0wzK3+d1RdK7FDsmPUqjV1FepBAJfBIqCZFO1
	WnBL5HFszmHXvqXjLS3HcmGubXyD7z55gM3qrPt9m/3DldDlTxexrbOV1wX0MZipDI2MbJHKZp6
	IDlC5s9I//F64vS7njqb/1xphaRbC/Zs9lOXlDM8Yj8SzO9595ipeOG/fS0FboIo5jwnTQs
X-Received: by 2002:ac2:5696:0:b0:5b6:1a7c:59db with SMTP id 2adb3069b0e04-5b8d89c2a3dmr212402e87.53.1790115328718;
        Tue, 22 Sep 2026 15:15:28 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:28 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/10] ip6_gre: add drop reasons to the RX path
Date: Wed, 23 Sep 2026 01:15:03 +0300
Message-ID: <20260922221507.3268127-7-littlesmilingcloud@gmail.com>
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

Mirror the previous patch on the IPv6 side. So far gre_rcv() reported
the drops below as SKB_DROP_REASON_NOT_SPECIFIED, all from the same
kfree_skb_reason() call. Now it reports:

 - SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND when no tunnel matches,
 - SKB_DROP_REASON_HDR_TRUNC when a header is too short,
 - what __iptunnel_pull_header_reason() returns when the pull fails,
 - SKB_DROP_REASON_NOMEM when the metadata dst cannot be allocated.

Unlike ip_gre, gre_rcv() calls the helper before the tunnel lookup, so a
packet whose ETH_P_TEB inner Ethernet header or WCCPv2 extra word is cut
short is reported as SKB_DROP_REASON_PKT_TOO_SMALL whether a tunnel
matches or not.

Like their IPv4 counterparts, ip6gre_rcv() and ip6erspan_rcv() now
return SKB_NOT_DROPPED_YET where they returned PACKET_RCVD and a drop
reason where they returned PACKET_REJECT. That leaves PACKET_RCVD,
PACKET_REJECT and PACKET_NEXT without users, so remove them.
PACKET_REJECT has the value of SKB_CONSUMED, and a stray one in a
function that now returns a drop reason would build silently and be
traced as a consumed packet.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/ip_tunnels.h |  4 ----
 net/ipv6/ip6_gre.c       | 46 +++++++++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index c68031d01c39..27a9e097996b 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -207,10 +207,6 @@ struct tnl_ptk_info {
 	int hdr_len;
 };
 
-#define PACKET_RCVD	0
-#define PACKET_REJECT	1
-#define PACKET_NEXT	2
-
 #define IP_TNL_HASH_BITS   7
 #define IP_TNL_HASH_SIZE   (1 << IP_TNL_HASH_BITS)
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d36949cbe9fa..ada48e23ca9d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -451,7 +451,8 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
-static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
+static enum skb_drop_reason ip6gre_rcv(struct sk_buff *skb,
+				       const struct tnl_ptk_info *tpi)
 {
 	const struct ipv6hdr *ipv6h;
 	struct ip6_tnl *tunnel;
@@ -471,22 +472,22 @@ static int ip6gre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id, 0);
 			if (!tun_dst)
-				return PACKET_REJECT;
+				return SKB_DROP_REASON_NOMEM;
 
 			ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
 		} else {
 			ip6_tnl_rcv(tunnel, skb, tpi, NULL, log_ecn_error);
 		}
 
-		return PACKET_RCVD;
+		return SKB_NOT_DROPPED_YET;
 	}
 
-	return PACKET_REJECT;
+	return SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 }
 
-static int ip6erspan_rcv(struct sk_buff *skb,
-			 struct tnl_ptk_info *tpi,
-			 int gre_hdr_len)
+static enum skb_drop_reason ip6erspan_rcv(struct sk_buff *skb,
+					  struct tnl_ptk_info *tpi,
+					  int gre_hdr_len)
 {
 	struct erspan_base_hdr *ershdr;
 	const struct ipv6hdr *ipv6h;
@@ -495,7 +496,7 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	u8 ver;
 
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
-		return PACKET_REJECT;
+		return SKB_DROP_REASON_HDR_TRUNC;
 
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
@@ -506,14 +507,16 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 				      tpi->proto);
 	if (tunnel) {
 		int len = erspan_hdr_len(ver);
+		enum skb_drop_reason reason;
 
 		if (unlikely(!pskb_may_pull(skb, len)))
-			return PACKET_REJECT;
+			return SKB_DROP_REASON_HDR_TRUNC;
 
-		if (__iptunnel_pull_header(skb, len,
-					   htons(ETH_P_TEB),
-					   false, false) < 0)
-			return PACKET_REJECT;
+		reason = __iptunnel_pull_header_reason(skb, len,
+						       htons(ETH_P_TEB),
+						       false, false);
+		if (reason)
+			return reason;
 
 		if (tunnel->parms.collect_md) {
 			struct erspan_metadata *pkt_md, *md;
@@ -530,7 +533,7 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			tun_dst = ipv6_tun_rx_dst(skb, flags, tun_id,
 						  sizeof(*md));
 			if (!tun_dst)
-				return PACKET_REJECT;
+				return SKB_DROP_REASON_NOMEM;
 
 			/* MUST set options_len before referencing options */
 			info = &tun_dst->u.tun_info;
@@ -558,10 +561,10 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 			ip6_tnl_rcv(tunnel, skb, tpi, NULL, log_ecn_error);
 		}
 
-		return PACKET_RCVD;
+		return SKB_NOT_DROPPED_YET;
 	}
 
-	return PACKET_REJECT;
+	return SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
 }
 
 static int gre_rcv(struct sk_buff *skb)
@@ -572,19 +575,22 @@ static int gre_rcv(struct sk_buff *skb)
 	reason = gre_parse_header(skb, &tpi, false, htons(ETH_P_IPV6), 0);
 	if (reason)
 		goto drop;
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
-	if (iptunnel_pull_header(skb, tpi.hdr_len, tpi.proto, false))
+	reason = __iptunnel_pull_header_reason(skb, tpi.hdr_len, tpi.proto,
+					       false, false);
+	if (reason)
 		goto drop;
 
 	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
 		     tpi.proto == htons(ETH_P_ERSPAN2))) {
-		if (ip6erspan_rcv(skb, &tpi, tpi.hdr_len) == PACKET_RCVD)
+		reason = ip6erspan_rcv(skb, &tpi, tpi.hdr_len);
+		if (!reason)
 			return 0;
 		goto out;
 	}
 
-	if (ip6gre_rcv(skb, &tpi) == PACKET_RCVD)
+	reason = ip6gre_rcv(skb, &tpi);
+	if (!reason)
 		return 0;
 
 out:
-- 
2.47.3

