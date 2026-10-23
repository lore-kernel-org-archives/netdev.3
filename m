Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763285;
	b=Ju2ZcHOjNSkqOHWLqF0eOjvwrH5/CfSrIUtLcDe1uAz722fs88Mr/08sFKw/4fZhhkXa
	 CcH/7XhtdhV4q0tWskgppG3bnKmUaiY1mw4y+gB4P1aqi/Ep94ccz09Lr5KmminjVRYyP
	 f+ag786iIyO65u3foKylEJc2RBh0BvIYMLilKi7E6VOZ4wFvILqJl8IpzQecJt8pmLzKj
	 MQ8bzqgEKpyRWiqhP6RLv4+8o9AIck45bGJNa7Yo/CrbaG9m8IdWw1kFz0Mok2FNuKGR/
	 /T6jmF9sPcyoPcLbu40WhZYWYBPrktw7tATBiCkVms2lI1V+fkz4cIVOX0sxpKKQHig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=yFTPqd/iBvBr5Dd1zFhRBjxhT0+2tYQDrYubtNBroD4=;
	b=1GkXcSa8gpB79hb6MF9dX02XVpBgUwU1ljK82Dx5k4gHXi041mbEIwfBLdsxRE5t7IND
	 X7RQg7k1EXRwRaBr3J1CRORK4sFK+dNpTPZWdRwOsziwWUCjZVHyoJm/IKaJiSKP21TBk
	 vFBrSQu4VnxKO5VAba9r+jP4HKpq4qV8R9nuQtBXuCUXTMXJ8AVvHOjeC9OTfFDJtjJx7
	 uVd3mNpBsGBgjx47KgHodQRB5esZcVj0Aqp1doaSUO0h8Zd/GEd9GJbEFkkweXWJPdyNJ
	 TZBWySNl5oQJvM20kFFzoG98S51YP4GdnwlES1yitLDoICcblNOaTmABKbhQ8LiF/sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qSTx99IP;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5327606A325
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5327606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qSTx99IP
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e977109392so4630465ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763284; x=1793368084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFTPqd/iBvBr5Dd1zFhRBjxhT0+2tYQDrYubtNBroD4=;
        b=qSTx99IPGHN/okREI1Oxbp0kniekncoVuUw7f0CRKSF9qwE7VkA52A/923tWg5hck8
         MhWL92cGMSAVRS2PU8PwTuDZ2YtJy6H+yi2saYe4+0pvoG0BRKOuPbgLYghAY2a1Goow
         eeKIXPtsYJJhzyoUMRFr4faL01WsOjy7MYNmI+s8trF3vPUPXXV/BFd79ci0ryF57PDo
         JrR18X2uodOn+fLXIWuAUv7Y08Ve/8FYKp1OiOmhwjhDI81JogcJ83IisGuKZuXm30r0
         TtPvX8xbhGNYzsYX/gE4QtNLL2YNlMCBke6CsUUJsJNq0cfrHVTuudYVjV4vuldrr9UI
         9BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763284; x=1793368084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yFTPqd/iBvBr5Dd1zFhRBjxhT0+2tYQDrYubtNBroD4=;
        b=BMql1CTmw3uPgsVKmQuTk9PmwO1L9KBhIxxFfenOF7tldTUwNEFmbkx4y1ts5IGISM
         G+n9KL+HqmDFXDIcroB1TyXc1rH/ZWUpWGuCFgzaTxRTqGUXIdwitRbr9Z31kxA421se
         OfseFnKPpSahqm6x7XOKcNwj/D661EiyWCTXN0C4has2ckk0sdLoZJ1e5uWfCHuC40nH
         kdrVWpHr1JgJfL2gawSywDRR5We1scsJGSy7sro+Z8MEk28/um8996xR41TnN7bga8GP
         mCL9sxC8T8JmivP8cHi7QDQNhChoEjDz+znghMWufSP6vnZKavpNzmKdi1R5gatoKqh2
         BedA==
X-Gm-Message-State: AFq9FYLHbwvB/FlWofnxQPe7HdiGKCM6EsMW7hBLWAeYi6CPmKSOsm3W
	NZ08TDvUcI6k7Veb6PynZWwujEQZ1SrC8eYASNSxyWcXC4s3D5gckjEq
X-Gm-Gg: AYBFou1IYRUmK/Noojo7nEF7GU8TMI5vXKbZu0d9mcXlQx8zBwu2pvlBoOfID//BMA0
	1tsVR4G7PxlAoB3Na1Zu1Uvh893Yd5kHhXZwj9AYUi19WTDNCBMuxQMV6cr+VUn9t2Sp4Y8xLmJ
	u1e1+x3vMxJqEi8k3nKRJFXoBYUSILTuN5kexiBROchTKCln9m9QvSJwmMklHMTWVF8Lr8uLKYQ
	sYdGE27/4W1/qyAu+ItU4jUHbbLOO97MGz+gtvDgsAnPjcMtq1Xx2MZUdnwy50FWax0LvEB5n0D
	HG2EZWDCDh7UACG2hB2601Qd1zdwOuEGegh0TVUH9BdPwtgiMw9O8vGXJ/lafSjil1KJU7SgZp9
	Yu6XweA2aGOvnHBtbT5T9yTfV1BPNI5R75aM0O63uj3tlqonJU/0N0YWD//A9rlCQjfN63w/zB+
	5uPEQD5tebyJl/KMWc8e6H7IwNyYRj77bhQMxHWFRqWf9RlSxVetMrTMabMoRFfMIEBnQacWMgd
	jNbFJX1i3E518/opwvBsbI0fFmVbHXrkfx8da7DkiH/ARQ1SAPf//cikA==
X-Received: by 2002:a17:903:18a:b0:2df:a64a:756d with SMTP id d9443c01a7336-2ea7ced88bamr23649455ad.33.1792763283822;
        Fri, 23 Oct 2026 06:48:03 -0700 (PDT)
Received: from dev.local ([163.43.243.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea946778ccsm521295ad.9.2026.10.23.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:48:03 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 23 Oct 2026 22:47:56 +0900
Subject: [PATCH net-next v4 1/2] seg6: skip the route refcount in seg6local
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
Message-Id: <20261023-seg6-lookup-noref-v4-1-0ad0a83960ef@gmail.com>
References: <20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com>
In-Reply-To: <20261023-seg6-lookup-noref-v4-0-0ad0a83960ef@gmail.com>
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
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBq22WMRkt0MP6INEApQnxXOrD7+CIjJEkGApSdU
 FbT9xGmC8GJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCattljAAKCRAq19F1Kl0b
 TRjhD/9WN//kpALPGBL8Ebh/7Uutgs/K7sSZ9frfn0ht0l0WXzRfjxp3viTZ/6jabTm09CF53tQ
 ZyftBMbrpkhVBB3Cdp1lqqn8yQgubtcomOTJcqiFjjehBGoUiIUyUJeH64oZqkrpnZreIiz59m9
 WfdqxLR9HKY0bW9pp9wHGfOdFvHmPUXQoemDerLuyzjOl0/t3C9ELAr0vGumR81PXbjE1/c0Av4
 kuAjzMvsYvyB7AZyEKWSKm7ABEn7FA+U5altm0eVojR0lRFKBV0X7CixFCSIsKCZZr3mBP3zEa3
 OjClbwrj6qseP6Jwd109hvYRxgFB32PE9rFcSa2gikZxY+FK+R3iYs/fFeKT5owkLvfqAAUVoHF
 tAQamLSxV+JLpGwodTf86sRqZ74FRaRVaiWOBDaMdmR+cxXeSz804SFNNLojEjmeHJK0jeY275e
 HMpNEyZEwoTRFnDyOL1W9hY3REQblILOFBMBUFhTNFCF9ZdS7VO9/ROpyl3oxRVAb/qCeFmQgYB
 fHnzxCzPlHkgJt4XXsRzzz6W72X+MWDJpDOCSVJbE+OXc8psMSQTps7KIGuass4V/dcJQtXanqa
 pHlcAIj+db0szUOLPc2mm2LKy5TciN+5NxpqS+wFZkXzjMLZFsOkzqgYT3FoL7e2qKWWYMMlkge
 E5mNhzXGqoAi3qw==
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

