Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB538B7D4
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271407; cv=none; b=lM7b0KvXv1ICT/TQoMjGVztmmh915tNGPF6HIUBEwpaRG13fXe3Hl1NBMjBLLZyzo6BS1p7KbStL3qLGyCPWoLGUsWfw/yvH0lWQoPP9WT9gSyENr0J0xTiTeFPyMQxY7jltGvNcAjmKpqkjcOBre84UVWF8TDtfcJA1Ok9RP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271407; c=relaxed/simple;
	bh=ICJykrUcFsTqZGtDXT59rk7AoFn2/RNxlEqe44411RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czbAWclMHuh/MDgircPJ/c9Yxg2wq07a5vQuRiwu0pdazSHJzrazn65yW/yDL9EBXrEntxG9SOsPTGz5tiIl1kyq+VuTM0KlUeansbwWgNYCOH3b5MoyzXWk89Cg3HjxfEMYny7CzoDleR8qkSEZVuSrgCiI3WGSrfSNRf2WfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9oOAW/Z; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9oOAW/Z"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so22362791fa.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271404; x=1789876204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=txCUeYmpqirgtdt/tYCNBsfM5AynCHOCui/THIn7RvE=;
        b=b9oOAW/ZCxWvvWGIi9KJFmhsVlL5/SIBdYOnnU16Z634ajs/edEG+LIpYXDsszYgti
         ofiucIM90bLI3XtysUkKGHRaMR/2K2vFymCV8VXJU5+KRZYO+Gt4UISHGTiz7oZb6VAw
         qvXS4jU86OPbjA3HUY/k4yiozzQY9sM4DFwaUvlvpBsTYtKmV31MxW4n13JD71DUpz5V
         6VMtKHauozzVNlV0btrX7uh8Ym/zeS9b3i0TFCWgj8u0mQB9k5Xd1aa1lQzMrfGc8aKl
         kHwdD318tL8rJo/fuRJO9zLQJQyQF83kPOxs4cHyf1G31j00M+7IV5VGW+zHrrc5eebo
         uWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271404; x=1789876204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=txCUeYmpqirgtdt/tYCNBsfM5AynCHOCui/THIn7RvE=;
        b=d9GwmQiWkw18m74sQ1zIKZziD8bTLA5RbMKDq08DvB0iIc7A5b/4cu6+t/w97ApjDX
         CaQV28ZkoxNmiFkJ7THLBAoxRWSf+nRKABiUeS3eGhwDyrb4md4sHwhl4fUhgVqUG05g
         MvyctGB249a7g1z6nNfLtPnTKOT6Fps0baP4qz++IVbuiCC90c3+8a+muIc0rz5vzLLN
         KkjvDbkGbDxZu3JiT9WgxOF0BfTc37mXwdvxc/WkHHWj64JeNfb94fPJVWst3+T2xyIm
         6zq10HZ3Uk17aZPGsUnv0eKx/ZMEGYrW6nWffT31GNvZhIKylgIn+K4etEK9XJi+lCE4
         UUfg==
X-Gm-Message-State: AFuF++nSJb9nQuHZSZAjHJ87Ozz0X6dxFQ47sJvLEJ6EkdqnrCIuSlu2
	PVafl5LjnXmiYD/PizjQ/pGfnfXvL4z1hPSo2a7I3NYC4uJJaF1DgHa8+QhKh5OGVCE=
X-Gm-Gg: AYBFou20zA7X/TwEpPcYyX+yjA0hD+NXAZq51xaOnFWSVP9Iw16ZKW7iqln6eFDrcTa
	cls6B3iwDjaTXifA37s6aWaOdRh5R5WPOcUvxQw+nqkt5RchzVT4FX9Jk+B3GnBrc9LWZaEpkYi
	lEKDsAxnf/i+NQNdMbZiibtlyNSPp07aziuog7/riffDJQwdDwVg0N7Yvz4WPkUYwWCeNJKqN7f
	QfsOR5DFEDGsSjza5mDolymYNHUPqfR4ydbqZ0V5oLkf9TfHo0nITwmpy65wW4RNFno9qlE/x2T
	sgTABrUiyqK75STpu6USOlOnpeqekmO1eke+mNbrr7tMnaqV/FBUCadsf5nLBboc8b7ilrMUwyL
	GjzLTCOlcR8nZVEuQb5Z0fbvpIDsQgXwry7d5fLB+oy2bb1bzH2ZVMf9+G4HnhP5Ms0/mnxivPa
	vEUz2NC+nq87rmsvbLiuItjdbzL81KaQnWsqfjvN3bIw88HhCIUxwn2Up3fmT56JCSub0tbQt0P
	xHbBKkj6EZapadv4fDWHHYgaZjePXweg3A2JVLa8tUp
X-Received: by 2002:a05:651c:31c6:b0:3a3:4c63:771c with SMTP id 38308e7fff4ca-3a5a5208f2dmr11451881fa.12.1789271403456;
        Sat, 12 Sep 2026 20:50:03 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a332737dsm17277051fa.22.2026.09.12.20.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:50:02 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/8] ip_gre: add drop reasons to the RX path
Date: Sun, 13 Sep 2026 06:49:33 +0300
Message-ID: <20260913034937.875068-5-littlesmilingcloud@gmail.com>
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

The header pull failures reuse SKB_DROP_REASON_HDR_TRUNC and the
metadata allocation failures reuse SKB_DROP_REASON_NOMEM.

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
index 1894c5746a73..4d9bb6d186ae 100644
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
+	kfree_skb_reason(skb, SKB_DROP_REASON_HDR_TRUNC);
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
+	kfree_skb_reason(skb, SKB_DROP_REASON_HDR_TRUNC);
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

