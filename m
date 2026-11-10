Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342032;
	b=UXld9Ho7KP2YEWoRHYyGel18Eyxdz+ZKncWy6NWlLMP/3kpI6e1oSDDomBwm9/JcW+YH
	 g0BefGbv0OQ8Qg6PVM/uWAtEjWGNGNX+TbGNJldjub2boIAZ5jIQIaHGl83kBMj1xeLhW
	 +sQiDQ6yWYoG6S3vAfJpH3THsXNDlMk0Zu7zRugFAYliIlKMx6hLQinHzCskFatu2Z0fF
	 i3apBVuT+3k1DhQvPfImFKjYrfuEl5YiOcJvvMzAfDQg3WHB1fxfdlwjGLfNJhhN5pHuW
	 9eM33He8vQzD6YNzVrRj5PWdPOFxRBwDqW2SnSO6mI/82HWFiHPss6iqFjZecuu+ygA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JcHBYyvbnLwecf3t6favemzy61yDGd2wlJNpZtu8UuA=;
	b=JWr+pj7IsMJRh+spJGsHsYbWV00ysXFQ1z4H8z9D9JjACO5ABacWZt8W+tm2deZIdgLT
	 TZzsU4zHnPemVEL++gJN2HdSoKU93vlOZzRIcs8HXrkGpCV7IW4c7N38NVk3r9r1zcZQA
	 lRFSj1LsXR8/sQq76dotGxv81/ZKSHH2MXlnjjfa3Vduz4JxttLe/WbAaJIN+Y5IEVHhv
	 bzC86wCxMzqSLyDIVyodfIrf6JPbj1eMEdOP8fAcvKGoFnB7F2ivapaxoWieOwaWoiPRV
	 hEbM9PNZ8t1Ef5LpoPLWNfqeyA0TVcufmPjztmjhDfO8jJZftnUOqcxoO/zAVUW56Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhvc17sz;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C225606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C225606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhvc17sz
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso19176211fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342031; x=1794946831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcHBYyvbnLwecf3t6favemzy61yDGd2wlJNpZtu8UuA=;
        b=yhvc17szHlf+vvxZlklcKPccuhdOfMS4DyXSr2J1E3UKgrp74o3rwIws4zwOIx5+Xe
         6eXMYtaPblvuIcjBrVoh+imJQHNxo7ibE9mobD8shH2G6qbqiajpbLE+AKdaWpXPQs29
         JNpNW1aHcmKzTCjDJwX19w3gKfknEciKKPoD+dpeSASgyNAPrSpY8EWiqFAciAe/Vnr6
         ifyyBrRb3SyiRUkUx94khh0JkLJrMQfMPAzF4cbizAo93mXUi4Pi032KOHYrY9qfX3Hh
         1nlCTQI4HhY45ZpwhTW0720wjWQvUsarv5gt9SWOGehMIjFgqckO2hI6KDM1N2083jOu
         eyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342031; x=1794946831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcHBYyvbnLwecf3t6favemzy61yDGd2wlJNpZtu8UuA=;
        b=InHDfAifWFSOhdjIvdxbx/WsiSieIMi6JRi+TayMiIYhvYFDDUymK1UFMqy35pq1tZ
         NqqPN0943UkwNZzOhQf6yR9oVr4alhcyue/JDBdxBCQj0NbhGhiqGrRgGBBsuPjtfF3Q
         bLjXoXH85zCCDwWZxielwBAqYF8c71suEvaj1ymBWEj/dXqeu5G2XFgclY1V6pJp6mhd
         THG9ZjfM9y7JEGcTSfUPUnowz+fuN1unAhMNZFj0myrOXlIJhM8k0NME8sYTBoyokpCV
         /Ma2gh3EiV7/7dx384LI7l3+GVNiyXa3ZDw853ixaW8Y8FQ/ea5+tbz0R9IGDvoduAYl
         2UkA==
X-Gm-Message-State: APuU4Z87s4wu320fL1GTkyDjvRlDgz++quXTTpSLxdP7BRTD7nSsQA3D
	q+wsj1eCTOGPhkHcmX7V0w63yTmsH9wkxjUl4axafTTR36+wlNmjR6RO8N1MIx6YVV7jzQ==
X-Gm-Gg: AYBFou2hvPpX6V1pj4tYq4bAg3G83ExWS4rOKNVO4IK4/X/kTBNlqJq+Cb1A7FfnzEz
	sXfZT507JAJeU3UP8V+neUEkkm1xI2bFQ4wYYoln6vYVgBD3XdXAR+P8eDaCuDT8WD1wEWWMcuU
	Z11ERB/7XCku22iTVKA8tSdxInQlZ/0XPBHqmHOsjZvmWZx6J3mATEkbzP7HOpK1dNB8lSU5SnE
	jjl9zsfk5gbjRPEk68dCsPo5YnAidQcdsz7HwO5C6CIvtRN5D+0PKIoTGXSWuxtHDeFYmguaxnq
	+9RC+98bjnSrGD2HsL01HkmL+BWbSB59lsD4ZGa9j74GHYWdfkJieGjjmHB8NXR+qih6hnnijq1
	yX1D8L0gGxKMXqyTgr0iw7d7hPLmCIZFUicmi5dz16iRJcjtDV8hSYq4gVB2DMJbSkdtbAIZRz9
	2tpS7TY/L6M3jP1jQeCAe7ZmOmypta1jVo6R96aGxIqypeVIHQy9h6NJU73sETNZtA+ZJXz52rJ
	tT4iLS3Ixpa07Q6xej++9/ReFU/HjPYR57EeIBO+izGPxFZ3BGCJ3NhahQAVnrRebyu0sPS8A4+
	ux5W3obY1kF6E/d01MTM34k99Tdo8MQ5XjVLQ5jK3ow9+bVt48sOx0IkG4SU/wpzWrhAaplwdXh
	s1HfgjSe3Vqiva0FmgA==
X-Received: by 2002:a05:651c:f08:b0:3a9:c840:10fb with SMTP id 38308e7fff4ca-3ae0955cd24mr8362091fa.2.1794342030396;
        Tue, 10 Nov 2026 12:20:30 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:29 -0800 (PST)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 4/8] ip_gre: add drop reasons to the RX path
Date: Tue, 10 Nov 2026 23:20:17 +0300
Message-ID: <20261110202021.821224-5-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
References: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
commit 6c0509aa8900 ("ip_tunnel: make __iptunnel_pull_header() return a
drop reason"). Both report a packet too short to pull
as SKB_DROP_REASON_PKT_TOO_SMALL and an allocation failure as
SKB_DROP_REASON_NOMEM. The metadata allocation failures reuse
SKB_DROP_REASON_NOMEM as well.

erspan_rcv() and __ipgre_rcv() follow the same rule for the reason as
gre_rcv(): it is initialized to SKB_DROP_REASON_NOT_SPECIFIED. As the
handlers now return a reason, gre_rcv() no longer sets
SKB_DROP_REASON_NOT_SPECIFIED once the header is parsed.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  3 +-
 net/ipv4/ip_gre.c             | 81 +++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index de2796184e06..2df44745cf3b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -543,7 +543,8 @@ enum skb_drop_reason {
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
index 10f1a5a2fd91..c93c395c997a 100644
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
@@ -354,18 +357,21 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
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
@@ -377,8 +383,9 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 	if (tunnel) {
 		const struct iphdr *tnl_params;
 
-		if (__iptunnel_pull_header(skb, hdr_len, tpi->proto,
-					   raw_proto, false))
+		reason = __iptunnel_pull_header(skb, hdr_len, tpi->proto,
+						raw_proto, false);
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
+	return SKB_DROP_REASON_TUNNEL_NOT_FOUND;
 
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
@@ -456,16 +465,16 @@ static int gre_rcv(struct sk_buff *skb)
 	if (reason)
 		goto drop;
 
-	reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
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

