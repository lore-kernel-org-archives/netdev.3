Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91409345EAC;
	Fri, 25 Sep 2026 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343553; cv=none; b=FgzasScImNA1aEEgFUWg0r0ZOfp5ZOpGyYG3U3bIC3s/sMjH/+DvM+Kq1UwPAl+vlmbZGCs3/keNRMcxEzLJXgQFsZxS9kWYNZntOQvxBzGWJzwBGJd/onRn5eWbVADy3s4UujGlyEwRjq7zdZ49Fr8LNK//svw60MZoPbXPlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343553; c=relaxed/simple;
	bh=13t4uQ+2tJf8ohOF1mnl+sfExWk6M9yf7echlq7Lfbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k/hd1T3bRur8LM24+VH640Kv5C5nLQmT9isZsydUZv3ouXfHH3aXiwgn7A36wr49bIJYJjfG7xfwLt9iZycKzUpuv/sY4k8pKpZ11mZ4tz3uD8AfN6jaCyAWbZbjc5t8QKj0S2h91pIf8UH831eRlM2uNd6PEzLpWKDfltZtSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=LOuV3rBv; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=KuERjEDf; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="LOuV3rBv";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="KuERjEDf"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68PDcRg1022286;
	Fri, 25 Sep 2026 15:38:33 +0200
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id B4FC6120537;
	Fri, 25 Sep 2026 15:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790343503; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=uMzBZqUfy4ha6uqOX3Bn5eWkfaTy1gWx4xywfrRzoR4=;
	b=LOuV3rBvkfzA2SiIyxlRL2Vss2FK45p87175jLNoDeqZlzzIwiW6CnmBiTxNqgq3l+emOM
	MKjE4i/eve7XIVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790343503; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=uMzBZqUfy4ha6uqOX3Bn5eWkfaTy1gWx4xywfrRzoR4=;
	b=KuERjEDf8E0AAfuksStzUDQj1md272B6UCbXKX7dIa3VreRrcUt4Hvf4NGmXSYr3oCf9t1
	jPsN7BqwifcL5I52GY27EbfLnlSGo2y6UmRofaR8FvJgonsxUyhKc/IDqyjEvvM3+7avO9
	WZI/HenMYP9Unqa/jtCAGViMXBbQl70YrivNa2LbD7a5a97Z+uuVUmfX8If5qX6Cc7Mlsd
	bfUGHIGrOOIIBEo1tj7g2Iti6YIrp3yj1H3eY1stpI4uZ8KDRSIONrSmlw3HGLj4ZpCMuc
	HObJ1u8QMaLzTJgypkqMPLBcvIi28Vux5v5tX9PstKVsGQlBf92vpIVfWgC1jw==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Lebrun <david.lebrun@uclouvain.be>,
        Hangbin Liu <hangbin.liu@linux.dev>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net] seg6: ensure packet data is writable before modifying SRH and IPv6 DA
Date: Fri, 25 Sep 2026 15:38:07 +0200
Message-Id: <20260925133807.32-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

advance_nextseg() modifies the SRH Segments Left field and the IPv6
destination address without ensuring the packet data is writable.
seg6_next_csid_advance_arg() has the same problem when it advances the
NEXT-C-SID argument in the destination address.

The skb may be cloned, for example by an AF_PACKET socket receiving on
the ingress device. advance_nextseg() and seg6_next_csid_advance_arg()
then write into the packet data shared with the clone. A read from that
socket can return the modified packet instead of the received one. The
simplified path below shows this for advance_nextseg():

__netif_receive_skb_one_core
  __netif_receive_skb_core
    deliver_skb               [orig: users=2, cloned=0]
      packet_rcv
        skb_clone             clone queued to the AF_PACKET socket
        consume_skb(orig)     [orig: users=1, cloned=1]
  ipv6_rcv
    ip6_rcv_core              skb_share_check: no-op [orig: users=1]
    [...]
      input_action_end_core
        advance_nextseg       writes into the data shared with the clone

Call skb_ensure_writable() in advance_nextseg() and in
seg6_next_csid_advance_arg() before they modify the packet data.
skb_ensure_writable() may reallocate skb->head, which invalidates the
pointers into the packet data taken before the call.
advance_nextseg() now returns a valid SRH pointer, or NULL if
skb_ensure_writable() fails.
seg6_next_csid_advance_arg() takes the pointer to the destination
address from the skb after skb_ensure_writable().
On failure, the callers drop the packet with SKB_DROP_REASON_NOMEM.

Fixes: 140f04c33bbc ("ipv6: sr: implement several seg6local actions")
Fixes: 848f3c0d4769 ("seg6: add NEXT-C-SID support for SRv6 End behavior")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 140 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 117 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index d1070aec7b72..53f7b2452575 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -278,13 +278,43 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 	return true;
 }
 
-static void advance_nextseg(struct ipv6_sr_hdr *srh, struct in6_addr *daddr)
+/* advance the SRH to the next segment and set the IPv6 DA accordingly.
+ * skb pointers may change: after this call, the caller must evaluate again
+ * any pointer into the packet data.
+ *
+ * This function returns:
+ *  - the SRH on success;
+ *  - NULL when the skb cannot be made writable. In this case, the function
+ *    sets the drop reason to SKB_DROP_REASON_NOMEM.
+ */
+static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
+					   struct ipv6_sr_hdr *srh,
+					   enum skb_drop_reason *reason)
 {
 	struct in6_addr *addr;
+	int srhoff;
+	int wlen;
+
+	srhoff = (unsigned char *)srh - skb->data;
+	/* we write only the Segment Left field and the IPv6 DA. The segment
+	 * list is only read, and seg6_get_srh() already pulled it into the
+	 * linear area.
+	 */
+	wlen = srhoff + sizeof(*srh);
+
+	if (unlikely(skb_ensure_writable(skb, wlen))) {
+		*reason = SKB_DROP_REASON_NOMEM;
+		return NULL;
+	}
+
+	/* skb_ensure_writable() may change skb pointers; evaluate srh again */
+	srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
 
 	srh->segments_left--;
 	addr = srh->segments + srh->segments_left;
-	*daddr = *addr;
+	ipv6_hdr(skb)->daddr = *addr;
+
+	return srh;
 }
 
 static int
@@ -382,12 +412,26 @@ static bool seg6_next_csid_is_arg_zero(const struct in6_addr *addr,
 	return true;
 }
 
-/* assume that DA.Argument length > 0 */
-static void seg6_next_csid_advance_arg(struct in6_addr *addr,
-				       const struct seg6_flavors_info *finfo)
+/* assume that DA.Argument length > 0.
+ * skb pointers may change: after this call, the caller must evaluate again
+ * any pointer into the packet data.
+ *
+ * This function returns:
+ *  - SKB_NOT_DROPPED_YET on success;
+ *  - SKB_DROP_REASON_NOMEM when the skb cannot be made writable.
+ */
+static enum skb_drop_reason
+seg6_next_csid_advance_arg(struct sk_buff *skb,
+			   const struct seg6_flavors_info *finfo)
 {
 	__u8 fnc_octects = seg6_flv_lcnode_func_octects(finfo);
 	__u8 blk_octects = seg6_flv_lcblock_octects(finfo);
+	struct in6_addr *addr;
+
+	if (unlikely(skb_ensure_writable(skb, sizeof(struct ipv6hdr))))
+		return SKB_DROP_REASON_NOMEM;
+
+	addr = &ipv6_hdr(skb)->daddr;
 
 	/* advance DA.Argument */
 	memmove(&addr->s6_addr[blk_octects],
@@ -395,6 +439,8 @@ static void seg6_next_csid_advance_arg(struct in6_addr *addr,
 		16 - blk_octects - fnc_octects);
 
 	memset(&addr->s6_addr[16 - fnc_octects], 0x00, fnc_octects);
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 static int input_action_end_finish(struct sk_buff *skb,
@@ -408,31 +454,42 @@ static int input_action_end_finish(struct sk_buff *skb,
 static int input_action_end_core(struct sk_buff *skb,
 				 struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ipv6_sr_hdr *srh;
+	int err = -EINVAL;
 
 	srh = get_and_validate_srh(skb);
 	if (!srh)
 		goto drop;
 
-	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+	srh = advance_nextseg(skb, srh, &reason);
+	if (!srh) {
+		err = -ENOMEM;
+		goto drop;
+	}
 
 	return input_action_end_finish(skb, slwt);
 
 drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	kfree_skb_reason(skb, reason);
+	return err;
 }
 
 static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 {
 	const struct seg6_flavors_info *finfo = &slwt->flv_info;
 	struct in6_addr *daddr = &ipv6_hdr(skb)->daddr;
+	enum skb_drop_reason reason;
 
 	if (seg6_next_csid_is_arg_zero(daddr, finfo))
 		return input_action_end_core(skb, slwt);
 
 	/* update DA */
-	seg6_next_csid_advance_arg(daddr, finfo);
+	reason = seg6_next_csid_advance_arg(skb, finfo);
+	if (reason) {
+		kfree_skb_reason(skb, reason);
+		return -ENOMEM;
+	}
 
 	return input_action_end_finish(skb, slwt);
 }
@@ -448,19 +505,25 @@ static int input_action_end_x_finish(struct sk_buff *skb,
 static int input_action_end_x_core(struct sk_buff *skb,
 				   struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ipv6_sr_hdr *srh;
+	int err = -EINVAL;
 
 	srh = get_and_validate_srh(skb);
 	if (!srh)
 		goto drop;
 
-	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+	srh = advance_nextseg(skb, srh, &reason);
+	if (!srh) {
+		err = -ENOMEM;
+		goto drop;
+	}
 
 	return input_action_end_x_finish(skb, slwt);
 
 drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	kfree_skb_reason(skb, reason);
+	return err;
 }
 
 static int end_x_next_csid_core(struct sk_buff *skb,
@@ -468,12 +531,17 @@ static int end_x_next_csid_core(struct sk_buff *skb,
 {
 	const struct seg6_flavors_info *finfo = &slwt->flv_info;
 	struct in6_addr *daddr = &ipv6_hdr(skb)->daddr;
+	enum skb_drop_reason reason;
 
 	if (seg6_next_csid_is_arg_zero(daddr, finfo))
 		return input_action_end_x_core(skb, slwt);
 
 	/* update DA */
-	seg6_next_csid_advance_arg(daddr, finfo);
+	reason = seg6_next_csid_advance_arg(skb, finfo);
+	if (reason) {
+		kfree_skb_reason(skb, reason);
+		return -ENOMEM;
+	}
 
 	return input_action_end_x_finish(skb, slwt);
 }
@@ -760,10 +828,12 @@ static bool seg6_pop_srh(struct sk_buff *skb, int srhoff)
  */
 static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct seg6_flavors_info *finfo = &slwt->flv_info;
 	enum seg6_local_flv_action action;
 	enum seg6_local_pktinfo pinfo;
 	struct ipv6_sr_hdr *srh;
+	int err = -EINVAL;
 	__u32 flvmask;
 	int srhoff;
 
@@ -787,10 +857,18 @@ static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 	switch (action) {
 	case SEG6_LOCAL_FLV_ACT_END:
 		/* process the packet as the "standard" End behavior */
-		advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+		srh = advance_nextseg(skb, srh, &reason);
+		if (!srh) {
+			err = -ENOMEM;
+			goto drop;
+		}
 		break;
 	case SEG6_LOCAL_FLV_ACT_PSP:
-		advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+		srh = advance_nextseg(skb, srh, &reason);
+		if (!srh) {
+			err = -ENOMEM;
+			goto drop;
+		}
 
 		if (unlikely(!seg6_pop_srh(skb, srhoff)))
 			goto drop;
@@ -807,8 +885,8 @@ static int end_flv8986_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 	return input_action_end_finish(skb, slwt);
 
 drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	kfree_skb_reason(skb, reason);
+	return err;
 }
 
 /* regular endpoint function */
@@ -847,21 +925,27 @@ static int input_action_end_x(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 
 static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ipv6_sr_hdr *srh;
+	int err = -EINVAL;
 
 	srh = get_and_validate_srh(skb);
 	if (!srh)
 		goto drop;
 
-	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+	srh = advance_nextseg(skb, srh, &reason);
+	if (!srh) {
+		err = -ENOMEM;
+		goto drop;
+	}
 
 	seg6_lookup_nexthop(skb, NULL, slwt->table);
 
 	return dst_input(skb);
 
 drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	kfree_skb_reason(skb, reason);
+	return err;
 }
 
 /* decapsulate and forward inner L2 frame on specified interface */
@@ -1375,6 +1459,7 @@ static int input_action_end_b6(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 static int input_action_end_b6_encap(struct sk_buff *skb,
 				     struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ipv6_sr_hdr *srh;
 	int err = -EINVAL;
 
@@ -1382,7 +1467,11 @@ static int input_action_end_b6_encap(struct sk_buff *skb,
 	if (!srh)
 		goto drop;
 
-	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+	srh = advance_nextseg(skb, srh, &reason);
+	if (!srh) {
+		err = -ENOMEM;
+		goto drop;
+	}
 
 	skb_reset_inner_headers(skb);
 	skb->encapsulation = 1;
@@ -1398,7 +1487,7 @@ static int input_action_end_b6_encap(struct sk_buff *skb,
 	return dst_input(skb);
 
 drop:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return err;
 }
 
@@ -1434,6 +1523,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
 	struct seg6_bpf_srh_state *srh_state;
+	enum skb_drop_reason reason;
 	struct ipv6_sr_hdr *srh;
 	int ret;
 
@@ -1442,7 +1532,11 @@ static int input_action_end_bpf(struct sk_buff *skb,
 		kfree_skb(skb);
 		return -EINVAL;
 	}
-	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
+	srh = advance_nextseg(skb, srh, &reason);
+	if (!srh) {
+		kfree_skb_reason(skb, reason);
+		return -ENOMEM;
+	}
 
 	/* The access to the per-CPU buffer srh_state is protected by running
 	 * always in softirq context (with disabled BH). On PREEMPT_RT the

base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
-- 
2.43.0

