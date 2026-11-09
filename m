Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183021;
	b=TtwWZ5Y9bmZRhLxcgU7rcuYw0/+aBRCjrjty1nfWxEWcULamrGqPEFM0I4YDcFVfSx1s
	 m4tLBPzcLIDoqCyRpsI9C0OhRclP6p4wOhGh4jsYXpBTC8wgmukvb8V73O+qwZZbnAnCE
	 xSZlJ9POua+vqEIXUPfGgg10CMNRjQsOWpjcNmxCHcpbtlE30X9bqHHqg8YH61M9e6UZj
	 qLEId4FXXfloQIO8SVLIuJCNRMvcXSlRQCGG/Fml2/0p1kYhlf7AFE1OhL5uwst9QdSjz
	 9IMzzra0oYXI0zXwjXWCpUpDMo4lwlR5y4/oboB6CqkGS2tarlYn3U3vURRMHgccDTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=yFTPqd/iBvBr5Dd1zFhRBjxhT0+2tYQDrYubtNBroD4=;
	b=aBdP+/bxNQeDKwx9WOEP0+LgBL+XTlJwUkMfeNlew2faYozG+qNFOf6n2ISIKpKxzkUD
	 c9hoS99LqE4SnIa8qvElIeFxOSFUXJPJmzaWlmRAzgNAW95OeLSmWPovgy6SGxifeU8QN
	 UF6FWAQNKGawcF9BL5iqbkhs8NgsC+LEen1DwTG3/6rezw3CJMDDu1GNPPpsvW75mdtmw
	 jRkFM8n4EjbB1gMyQo8GET1E/Femi+mdS2jsA7tiw9K+B4dsXy8UdD6soYGS0rfT62KNx
	 8NqvC94/ZS9ZpJdjJfvdNirMvuBWnlyDPUZmhbWtsK5tTIvMjDzTTJ3ouGJSzf2bvzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlDDlaP2;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6D606D801
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 00:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EF6D606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tlDDlaP2
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36dbde64409so597619eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 16:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794183020; x=1794787820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFTPqd/iBvBr5Dd1zFhRBjxhT0+2tYQDrYubtNBroD4=;
        b=tlDDlaP2b8axvYSSSWSScnLGrcYjVXQFVkpd5vmVQiLi7qvhmlAg5SG+zXrya5xEYQ
         uoCX2PH0tT1DPHx+BVRvwdVbX6ScpiuLmAeLdqsuBg/mYfK332d0pt4lw1m7z1H96Pj9
         Eax4E0PZ1qe9xWH6A8jXNFJLX8u116+li7nAKxhHQYyWo2UXUUT5ERmjkVwSIPtM5BBU
         rIpFvXLcyND3rN+FIqo01BUhSS2IklIGXQM+blCYV1ZPk7dDLomqwWpBvjYsoLXUDWhB
         BOBq5YzA7vR/fwwG9Tuc2+eXMHCzBrag/1p87lrUbK4kIzewsmnzChsjRZNwY0tLUg3L
         C0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794183020; x=1794787820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yFTPqd/iBvBr5Dd1zFhRBjxhT0+2tYQDrYubtNBroD4=;
        b=kavmhGEZcOMRzaOiCDCr2MK+kZhZZ3h13v0f8CbyVw4DWYcKnK+FL6Dod0bsT4witr
         r2SBduNnua3vOnzC87zLadeM61vo87a/nUYqOYhBuSjdUEtuODccZD17exm+ZkV6xALk
         VmJlTwGY+bn6VgXpALmk9cCSpuzN5kT3HFlomZY0xv8O/PzrreE2SM1buRTKg3GCeYrg
         Rnypwl0oNZ3r63PhAhiRVnX2DKzjc/4PY786VI8Vj+i3qucaPPVOC+Rg2E6uXEqFzl+y
         8252xhiCT9L/yWrpprvdpArBb1g65ScDT9GqbWM0dM9gjWHFFNyfO2LK9fGNCCHWd7Ei
         n0iQ==
X-Gm-Message-State: APuU4Z8P63Zsctgy1RcCJyYA9zt7j8grmamq9ggyn4NUR58HH6BbufqV
	h9zOzJxIZ522lqRSTtcoF1ScdvwD5oE1PXtgMCW0jG8PWHQwU1/ba8OR
X-Gm-Gg: AYBFou0UnHGf/M7HzDnc+k68OX5bFgzZRpdLRkTjfqax1wUxuYa/37wQn5XvCHcfTwh
	1jAqEk6ODk29asGMG1tGounTjgzibcT9O/RCFDAhxwismT1raQtgDOjcWPTAaNlHbJQaBhXqK2B
	5U4g0kaxipu7HBwpRNBcFrr4oTH2aStXZ0go5H1fj3dK9IR1xm93Mp6LxF0L4rs4lj4P4Yj8bB2
	FVZj6JGFBm6aOkXiD8DwUX/A3TBgk85N3HGOyu9ypsZ7Czq/N43LDH4uNyqsin/s3FC2M3PExCx
	egA0gEDgYKpSlT3GYfrsy35LtHBM7AxmqkVoKZkh42y/2eX9DI+YWErIMeTe2P6nmSFuP/Atdir
	D9HMMkaQFxx50UASs7EAkhXHytv8icwS7UnHCXGyN8ONRqWNrKTtWA0M4gI1EsXN9oV8wPUChWV
	jfPLfdokNgXwVsNQkcueUjh4lwzqexvIgwgdPAtCJ4zuUHNmLg/JmW0KUUCChuZrLeXwm5qRliK
	Al2RlXbWlAoP7TdNsgZNgEo4FYeb5h5R1jtZ8nYr8llKniL+/CQ6SFiaSE/mipen/Zux18leR6S
	Nv6MlcYF63pYv1olkPDKIkClQGwgRg==
X-Received: by 2002:a05:7300:2a91:b0:369:f05d:6c67 with SMTP id 5a478bee46e88-372573d107dmr5311768eec.12.1794183020347;
        Sun, 08 Nov 2026 16:10:20 -0800 (PST)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265ff3415sm7790873eec.18.2026.11.08.16.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:10:19 -0800 (PST)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Mon, 09 Nov 2026 09:10:14 +0900
Subject: [PATCH net-next v5 1/2] seg6: skip the route refcount in seg6local
 IPv6 lookups
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-seg6-lookup-noref-v5-1-96dc6a652c7e@gmail.com>
References: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
In-Reply-To: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel Goller <g.goller@proxmox.com>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7267;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=Z0jFrXtM3BdpUHhSaTMX+ea4Tho3Ot9LI7vxEfjmtpk=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq8Q9n/AQBYQ7Xlslo7gzsE7Qg2Yro2JD/Hf6hC
 OT7uWo/tXqJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCavEPZwAKCRAq19F1Kl0b
 TeHWD/4m3OuYF1kwFPEC4BzSCe84/ExMum2p6oaJGdsWRSn/cperLaGpkao+4l448Uxx4wfxaPP
 6XcuDwrfu2U/YVhX8qfDZta7B8tpJ4021Lqf6S29FFLdfIjkgsvo3YTjsFpHXQ4OGz3MHDgPPO7
 R1FETjvjoLN0C7HjbV2f8XzGuxz8CYFckhDdiOrifA+p9saFp+d5G3lp7Sj2BBf/rI58QVKSECi
 tlmHLmCOjeJa60rkni7btsVbqmc7zRhe7GUWOIUAHJSZJsLrxVABHZfhGRq2s5XOtOt/+BRoKoc
 IFEPxMVR7rGhW25cxlFyrfCGF9V/rlPPTrhF3jdDst4lspc7OKZUnMGIoGbXi2WkT6mXazJqtOD
 lekiDuHEPBp1kG+WuY/an3GZ4RostLCXZF7+gekjeAtMKJdtKMxUcfaV2bzomkHLXYLvQqCwx4u
 G7K8nzbHifbfkNleXmnzBB/U5JiMceqiDJE6pmm/u3VgVpYJ3D0aytgrgOZMRbSR2PUqYODGev2
 hmh5SuthjM/iwH4LARhut5qoS47ThOpaXYktMx7a2WBi7KEg1bWmhgewRsQUdS5aZnokCyqMnB+
 pBa1FSvNoAmUmG37wP9ni0oOQa7OWeY8a1b9LjmX2xSsaDaMQT1T0uD2sfWKEoK92E9Zdd4ORpN
 cK9ZheQNVDTOQtA==
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

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 net/ipv6/seg6_local.c | 55 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 0c3d1be7f129..7fbcf590297d 100644
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
@@ -342,10 +342,14 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		fl6.flowi6_flags = FLOWI_FLAG_KNOWN_NH;
 
 	if (!tbl_id && !oif) {
+		if (noref)
+			flags |= RT6_LOOKUP_F_DST_NOREF;
 		dst = ip6_route_input_lookup(net, skb->dev, &fl6, skb, flags);
 	} else if (tbl_id) {
 		struct fib6_table *table;
 
+		if (noref)
+			flags |= RT6_LOOKUP_F_DST_NOREF;
 		table = fib6_get_table(net, tbl_id);
 		if (!table)
 			goto out;
@@ -363,26 +367,45 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		dev_flags |= IFF_LOOPBACK;
 
 	if (dst && (dst_dev(dst)->flags & dev_flags) && !dst->error) {
-		dst_release(dst);
+		ip6_rt_put_flags(dst_rt6_info(dst), flags);
 		dst = NULL;
 	}
 
 out:
 	if (!dst) {
-		rt = net->ipv6.ip6_blk_hole_entry;
-		dst = &rt->dst;
-		dst_hold(dst);
+		dst = &net->ipv6.ip6_blk_hole_entry->dst;
+		if (!(flags & RT6_LOOKUP_F_DST_NOREF))
+			dst_hold(dst);
 	}
 
 	skb_dst_drop(skb);
-	skb_dst_set(skb, dst);
+	if ((flags & RT6_LOOKUP_F_DST_NOREF) && !dst->rt_uncached_list)
+		skb_dst_set_noref(skb, dst);
+	else
+		skb_dst_set(skb, dst);
 	return dst->error;
 }
 
+/* rcu must be held from the lookup until dst_input() */
+static int
+seg6_lookup_any_nexthop_noref(struct sk_buff *skb, struct in6_addr *nhaddr,
+			      u32 tbl_id, bool local_delivery, int oif)
+{
+	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, local_delivery, oif,
+				       true);
+}
+
+/* rcu must be held from the lookup until dst_input() */
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
@@ -446,7 +469,7 @@ seg6_next_csid_advance_arg(struct sk_buff *skb,
 static int input_action_end_finish(struct sk_buff *skb,
 				   struct seg6_local_lwt *slwt)
 {
-	seg6_lookup_nexthop(skb, NULL, 0);
+	seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 }
@@ -497,7 +520,7 @@ static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 static int input_action_end_x_finish(struct sk_buff *skb,
 				     struct seg6_local_lwt *slwt)
 {
-	seg6_lookup_any_nexthop(skb, &slwt->nh6, 0, false, slwt->oif);
+	seg6_lookup_any_nexthop_noref(skb, &slwt->nh6, 0, false, slwt->oif);
 
 	return dst_input(skb);
 }
@@ -939,7 +962,7 @@ static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 		goto drop;
 	}
 
-	seg6_lookup_nexthop(skb, NULL, slwt->table);
+	seg6_lookup_nexthop_noref(skb, NULL, slwt->table);
 
 	return dst_input(skb);
 
@@ -1023,7 +1046,7 @@ static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 	if (!ipv6_addr_any(&slwt->nh6))
 		nhaddr = &slwt->nh6;
 
-	seg6_lookup_nexthop(skb, nhaddr, 0);
+	seg6_lookup_nexthop_noref(skb, nhaddr, 0);
 
 	return dst_input(skb);
 }
@@ -1383,7 +1406,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
 	/* note: this time we do not need to specify the table because the VRF
 	 * takes care of selecting the correct table.
 	 */
-	seg6_lookup_any_nexthop(skb, NULL, 0, true, 0);
+	seg6_lookup_any_nexthop_noref(skb, NULL, 0, true, 0);
 
 	return dst_input(skb);
 
@@ -1391,7 +1414,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
 #endif
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true, 0);
+	seg6_lookup_any_nexthop_noref(skb, NULL, slwt->table, true, 0);
 
 	return dst_input(skb);
 
@@ -1446,7 +1469,7 @@ static int input_action_end_b6(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_nexthop(skb, NULL, 0);
+	seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 
@@ -1482,7 +1505,7 @@ static int input_action_end_b6_encap(struct sk_buff *skb,
 
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_nexthop(skb, NULL, 0);
+	seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 
@@ -1571,7 +1594,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 
 	if (ret != BPF_REDIRECT)
-		seg6_lookup_nexthop(skb, NULL, 0);
+		seg6_lookup_nexthop_noref(skb, NULL, 0);
 
 	return dst_input(skb);
 

-- 
2.50.1

