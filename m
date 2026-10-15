Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF43A9639
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075177; cv=none; b=SLYaCh1Qx2hD3wRIzXzbPGhVH4rFO/V5zRHeWb3QQqXJusvaIjkbpOcWPozBPshYQLgj3FTzuPftNnq8+GYg0xQl5CoKBHTaQglex4pskZW8EnIZDMgGKPwNNMN+5XMGLiHNFgtaBCjmOZCi/YTR+r9Zke3e1X5eesbyqH9aBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075177; c=relaxed/simple;
	bh=hx7uNu0SUH+5t/qSITXY6QrEBrA3jRbqsbGUSfGxVw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WA5VAcnOsjtPLbBNR/2EvVLGjmXdUeAW6aEYQp3M6qnbBX4k4OVTNbdcBU9d5MmKiAFuV2LKx0klTAkuhRkmxhlEXuzJUTgrors3Zyc+07aT7CfTfob9ab1OGPTAPSLd1zAk6UZvOIaTDm2WY/PwE0yubgVQg8DEzsSnIopN8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM/qKg0J; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM/qKg0J"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so3094906a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075174; x=1792679974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=36MKAMMTovOY0fK0KjZHqZO9o0sMQ+Q/sWNJ0tayxqQ=;
        b=KM/qKg0J0oF84V7eNg7BW/03bhrgaAq86Layu30enLOw2BxTuCmjf5rwpQAwKsvJl2
         1ehiRC/JKdtIgJQr5sctqmy2LfUKbH5JwHXljdfeyShpI+n+MK6nTXq/Qsi9g8kQX03H
         c5XqtewJq7K88ecDduVPNTO9DX0Aqt0iIiAF8p8+d27oKYHoveYNMjj2/sfEbqJvBEnR
         RO+epZ8YJEiyXzGX+9GVdprQAvKcHHs4inaRwTcslAXCyfMkXo0WrvZf5KpU5X+G5SS+
         AhVbvzNGh7jNtSr44X+b/FWgErWpfiFfwnVGV/n1no70m8PNloXrjXHszckIoVf+ndgC
         cObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075174; x=1792679974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36MKAMMTovOY0fK0KjZHqZO9o0sMQ+Q/sWNJ0tayxqQ=;
        b=zpKY5iaXcObfQQ4kImPcgDkGsaqciRmfrb0uUNGcpa7wdDWT1fW94QD4ZXSwA60sXK
         HlDbRw/x4HR3yBSv4ea7Um7eo1ubq0iwgNhGAT47SQyZxjLRTbvGfME7O4JEdB9ELY2w
         q+QzxBJucyroqL1k39mi1tnIMZ5wFP9OuWwajjIVfm5OhN71Y93FZJwGO712lHpHAmJk
         0btCpyLpQgGxt+GdhcivXEz6WmfqO4j0bpMgYrvGYsk0CA9nbh/q7Vj0YhRgMONr2q9A
         BuyBVoIEL7DGNdEwBOmhDh98DJSfCa9IbMevajfcHVOsC32Q7wM76rC73B8A2nJpIbBL
         UaMw==
X-Gm-Message-State: AFq9FYKl9dmr2Mz/pJN7hm50byE7JfCXpVrPKTljZI1tcDv4uPKnW1KY
	SQ0w9lPPjLTkjakFLfkIgvMsUqPbbFPkdw2G8ZfdL5brWnNV3nyTs7np
X-Gm-Gg: AYBFou2FOrZn2fvvE2BEomoFlUCnMj7LAry53iJCpv6V/pay4KgK9MB10+eTNf2Q8eW
	HDli9cZ1hK3o+cDpira+GdiSe85hqdSjpLhyZlKj4oIbQ7+jWLGJk26qyVPrgCGbVaxzr2zY3oT
	/l3vq2VDIdwbvg4/R8n8I6V3Dtbwf6sx66GiEVU/aRRdC55c+C8bZYefXYOCY+rNCKWZWOHHXk6
	cuYZt2FNX/K+6RQUzMgy09laZDU55I5chXS1iHpYZuwawTk0lv/aBLvc6laKuXob7tzbblIYdRk
	SQnvL0DjFn+PontEp9HPmNC3wBTj8gM03sqR4rDNd5m6P1mdEZpZYjbuZb+TaOBk4teHR8VSOIu
	NWpWAJrvcrtL8CAtgui2rHRaRvjwV9Sk/xzMffOVy5ud8d8CGjHvwLFhbydr4KF+YOJibYTClKW
	jaAtbalCaQk+ZHfuuHCy4zN4+5hsPPxow3k/zNG+KxXdmtmZ1WJYV6ocQxlyk+Z5ljRTFO8DM=
X-Received: by 2002:a17:90b:164c:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3ac9599aaa3mr2306907a91.34.1792075174128;
        Thu, 15 Oct 2026 07:39:34 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9377fe6esm2583465a91.3.2026.10.15.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:39:33 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Thu, 15 Oct 2026 23:39:27 +0900
Subject: [PATCH net-next v3 1/2] seg6: skip the route refcount in seg6local
 IPv6 lookups
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-seg6-lookup-noref-v3-1-6d51a60a67d3@gmail.com>
References: <20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com>
In-Reply-To: <20261015-seg6-lookup-noref-v3-0-6d51a60a67d3@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7301;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=hx7uNu0SUH+5t/qSITXY6QrEBrA3jRbqsbGUSfGxVw0=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq0OWfytdRTqhPUHh9Kzi8vLKMVdHP0irAdQDBI
 +/5o9YIvNCJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCatDlnwAKCRAq19F1Kl0b
 TZjCEACxO+PrBbAPQRv6JkT5w0KTH4kZwCejjZAIVOF+EQwSKzUgsdh/NF5qudoz+PzNMpxk1Qa
 g4BZoB+7UPxRQndQXztwyVDRFi1w+oWy+c1LfO+TqZn3Mo45mOD4xFzHrl6c+Of7CMcu4meZlMZ
 SuwIkyeHFBbKjD0FLouEpIeUrnqNKxIUB5B+n8jQqL4UNsJ8a9ahrWqe+4IRgqx2DBcAXwDauvp
 TMthDckeshSyGjwfVLGIbh2160ca5GJt6UEewKxkktlMlEuVCMVHD45zf4LUfw49vAc8LTthaeh
 4kASsiJajBuN/UdAsom9Z8TySG2S3wGdpgromW19L67OnOKAvQgFhzKzB3Ew0b/cjqyhJlTwzyN
 2JPrtoFsu4zuvZGXscOAFyEPlao+JaFv0ocCVFLKBYYiC6yoGpbkvd/sB7C2wSVqMicVQr4t2rw
 AWODbF1bZiU7UBjedverrrYCjQAtnuqDerIzCgQMl/nD8ky4bMO7yPUy4uAEh+t4DHkrXbebgmF
 5QCgd8nyW4UWe17pXERHEakdRfHjUOJQzGVA9AW+MrF8hg/9dEt4EdLGHv66g0D3oBD5Uk3oR/O
 0ezWB5Sjzfqm2c3QFwCdHbNK33YRwjhtq2r3Q3EZyCV+fSkIiJxxqokHjeqeo+63/1LNQC8kXyZ
 pnRo/hVUqwRNozA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

ip6_route_input() attaches the input route to the skb without taking a
reference, relying on the RCU read-side section the lookup runs in.
The seg6local input actions also look the route up and hand the skb to
dst_input() within one RCU read-side section: the one of the receive
path, or that of the nfnetlink verdict handler for a packet reinjected
from NFQUEUE.  Yet seg6_lookup_any_nexthop() takes and drops a route
reference for every packet.

Give seg6_lookup_any_nexthop() a noref argument, and set it for the
input and table lookups of those actions, as ip6_route_input() does.
A packet that races with the release of its route can then be dropped
without an ICMPv6 error, where ip6_hold_safe() used to send it on to
the next rule or to ip6_null_entry; ip6_route_input() has the same
window.  seg6_lookup_nexthop(), which the BPF LWT helpers also call,
keeps the refcounted lookup: BPF_PROG_TEST_RUN runs them repeatedly on
the same skb and may leave the RCU read-side section between runs.

Throughput at 0.5% packet loss of 94-byte End packets (two-segment
SRH, no payload), spread by RSS on an ixgbe 82599ES across two 2.30 GHz
Xeon E5-2650 v3 with 10 cores each, offered by TRex and binary-searched
over 10 runs of 10 s, in Mpps:

  queues  cores                   before   after
  1       1                        0.740   0.756  (+2.2%)
  10      10 on the NIC's socket   6.404   6.950  (+8.5%)
  16      10 + 6 on two sockets    6.550  10.124  (+54.6%)

With the default rules, fib6_rule_lookup() tries the local table
first, and the miss takes and drops a reference on ip6_null_entry,
one route shared by every CPU.  At 16 queues that cache line bounces
between the sockets, and ip6_hold_safe() and dst_release() together
take about a third of the cycles.

Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_local.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 0c3d1be7f129..965263ff65d3 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -319,7 +319,7 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
 
 static int
 seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
-			u32 tbl_id, bool local_delivery, int oif)
+			u32 tbl_id, bool local_delivery, int oif, bool noref)
 {
 	struct net *net = dev_net(skb->dev);
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -342,6 +342,8 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		fl6.flowi6_flags = FLOWI_FLAG_KNOWN_NH;
 
 	if (!tbl_id && !oif) {
+		if (noref)
+			flags |= RT6_LOOKUP_F_DST_NOREF;
 		dst = ip6_route_input_lookup(net, skb->dev, &fl6, skb, flags);
 	} else if (tbl_id) {
 		struct fib6_table *table;
@@ -350,6 +352,8 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		if (!table)
 			goto out;
 
+		if (noref)
+			flags |= RT6_LOOKUP_F_DST_NOREF;
 		rt = ip6_pol_route(net, table, oif, &fl6, skb, flags);
 		dst = &rt->dst;
 	} else {
@@ -363,7 +367,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		dev_flags |= IFF_LOOPBACK;
 
 	if (dst && (dst_dev(dst)->flags & dev_flags) && !dst->error) {
-		dst_release(dst);
+		ip6_rt_put_flags(dst_rt6_info(dst), flags);
 		dst = NULL;
 	}
 
@@ -372,17 +376,35 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		rt = net->ipv6.ip6_blk_hole_entry;
 		dst = &rt->dst;
 		dst_hold(dst);
+		flags &= ~RT6_LOOKUP_F_DST_NOREF;
 	}
 
 	skb_dst_drop(skb);
-	skb_dst_set(skb, dst);
+	if ((flags & RT6_LOOKUP_F_DST_NOREF) && !dst->rt_uncached_list)
+		skb_dst_set_noref(skb, dst);
+	else
+		skb_dst_set(skb, dst);
 	return dst->error;
 }
 
+static int
+seg6_lookup_any_nexthop_noref(struct sk_buff *skb, struct in6_addr *nhaddr,
+			      u32 tbl_id, bool local_delivery, int oif)
+{
+	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, local_delivery, oif,
+				       true);
+}
+
+static int seg6_lookup_nexthop_noref(struct sk_buff *skb,
+				     struct in6_addr *nhaddr, u32 tbl_id)
+{
+	return seg6_lookup_any_nexthop_noref(skb, nhaddr, tbl_id, false, 0);
+}
+
 int seg6_lookup_nexthop(struct sk_buff *skb,
 			struct in6_addr *nhaddr, u32 tbl_id)
 {
-	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false, 0);
+	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false, 0, false);
 }
 
 static __u8 seg6_flv_lcblock_octects(const struct seg6_flavors_info *finfo)
@@ -446,7 +468,7 @@ seg6_next_csid_advance_arg(struct sk_buff *skb,
 static int input_action_end_finish(struct sk_buff *skb,
 				   struct seg6_local_lwt *slwt)
 {
-	seg6_lookup_nexthop(skb, NULL, 0);
+	seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 }
@@ -497,7 +519,7 @@ static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 static int input_action_end_x_finish(struct sk_buff *skb,
 				     struct seg6_local_lwt *slwt)
 {
-	seg6_lookup_any_nexthop(skb, &slwt->nh6, 0, false, slwt->oif);
+	seg6_lookup_any_nexthop_noref(skb, &slwt->nh6, 0, false, slwt->oif);
 
 	return dst_input(skb);
 }
@@ -939,7 +961,7 @@ static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 		goto drop;
 	}
 
-	seg6_lookup_nexthop(skb, NULL, slwt->table);
+	seg6_lookup_nexthop_noref(skb, NULL, slwt->table);
 
 	return dst_input(skb);
 
@@ -1023,7 +1045,7 @@ static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 	if (!ipv6_addr_any(&slwt->nh6))
 		nhaddr = &slwt->nh6;
 
-	seg6_lookup_nexthop(skb, nhaddr, 0);
+	seg6_lookup_nexthop_noref(skb, nhaddr, 0);
 
 	return dst_input(skb);
 }
@@ -1383,7 +1405,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
 	/* note: this time we do not need to specify the table because the VRF
 	 * takes care of selecting the correct table.
 	 */
-	seg6_lookup_any_nexthop(skb, NULL, 0, true, 0);
+	seg6_lookup_any_nexthop_noref(skb, NULL, 0, true, 0);
 
 	return dst_input(skb);
 
@@ -1391,7 +1413,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
 #endif
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true, 0);
+	seg6_lookup_any_nexthop_noref(skb, NULL, slwt->table, true, 0);
 
 	return dst_input(skb);
 
@@ -1446,7 +1468,7 @@ static int input_action_end_b6(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_nexthop(skb, NULL, 0);
+	seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 
@@ -1482,7 +1504,7 @@ static int input_action_end_b6_encap(struct sk_buff *skb,
 
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_nexthop(skb, NULL, 0);
+	seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 
@@ -1571,7 +1593,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 
 	if (ret != BPF_REDIRECT)
-		seg6_lookup_nexthop(skb, NULL, 0);
+		seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 

-- 
2.50.1

