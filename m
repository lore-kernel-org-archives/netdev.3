Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716D38838B
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271405; cv=none; b=RrSgsX7CaPgxq4ZE+ZW1gQ6HsQkrqj/uKQEoMGisMOREgKcYU4qbfgMHqGeA0ohIdV2n5IMWVb9XGSmoy0JiJxk3vhWJpLF97YACTB8vzgUT6Wbdh+Ed8fpfHmWoEQdjyN68cBd2KprgIdtW7dOrdB1E8wPgpdI3nfbxFWP6jb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271405; c=relaxed/simple;
	bh=GO6Gw1A9juIU7UQK+OBcuOBnE+LaE9NRP/n52vmI6Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIGRFfnu4UUGj8XXdeR1hPwOu4DDK5/OjvEoV/WjXaYnWyLljrTptzjkuLwsK2oFeNR1fpNZDwlwnH1Oit3vNd3PYtsr71BvO+sXCqVVN8S+ZRlWsdr/n8yo8Mj38e9+CUoZgWCaekzUyTJfcTxXokEm959TFYwtMeBk3PEHvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSeG4toG; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSeG4toG"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a354118856so9761141fa.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271401; x=1789876201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWSE5/EbNePj/bzNdrsb4KiTqY/RgZxbZLpv4ycdu5I=;
        b=YSeG4toGFgM5X9pe+PWpwVc2XD/T5GDmBDgsM1KVUvbmFi+TqKYESk0SuB4Z/jrCJj
         Q+fDv4XkKKvvqs6UVyeX8ZJdiH34TQSW5jndVz4Zp5NqgFoEskcIh7+iIotuYK8pckyC
         TZO/ANqbXTJ7xplJKIWE1E9N6G+oup8/rhS77SdEDnzNdIYPAXGaPYk1KXggJNei50i8
         a8FA54RcKSIb/GunbJ1lcUEBwJC466jDvpgxk4qjG/cOi7+8FVw0UkQJQnECgyBDP/9+
         Ydd3JVQqKhTvlQIBkqtq0d8azA0owFq10Xncfxpn6rHy4luMjFgJUx0pt7EV1+hrutAS
         vZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271401; x=1789876201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bWSE5/EbNePj/bzNdrsb4KiTqY/RgZxbZLpv4ycdu5I=;
        b=rtTOluKgOqHAW7wL9LIcSIR6MOUT152ImKixMLLQOS0ZHO6YsuSWQervS0q4KNOyRB
         c3eQJrHhholTs519PH0JvAJCQeNOMjyQBiODAJ6L9k7mp+ViUBHPB2oN/i6dOXhP6Av6
         4111USybxxhf16z1nKEZGPiTQcZLkj53FzAnn3f1HnF9woi0S8UweooIscj9VaByUtNy
         pPTgjfHyFoVOX2CJLiQNjhf5dBtjem5r5cliHcs/G8OvYskAEJjuxpb+YGqGVob6syXk
         WiT/SgmLery2KsrgIFT9ndJ1o5B+3oJhhGU2xcXplbkZNByD/g7LD9d9Gz6UlJ22/3xB
         Yyag==
X-Gm-Message-State: AFuF++lGIVzy33DcYNujxVrRy5KuIQld3uWy8w8ngsY1TgUd66p9HTc3
	z57fHo3WOLSnk4JDb7QzuuOpjWW3AYFLIFGDfln1A/EHJtaO+9w+5qvM1KEZc2z6rmI=
X-Gm-Gg: AYBFou2WteQVjdjZXfaA5UAQSoxj7tNpnIPo6DZJoJ4wNfW1X0R8vsTBLJ0Fj9NFIHw
	ht1mb7ww81Tq/t7b9ISaz5vzU7D3vKmjJAAFiBvHg9OywLbn02uLtnWMnVqiqRELokE7Zi5HmLF
	Dr1kY1j3vZ6jYEG9+S7VS9pY7bsfJ+omDj/B6YVnuj9P5MIwBrGNWVdw9+/bIKQApOF91YV26PE
	jEGw4tnEh+VRVU8eLqreCbnzt4zhyIjYYvfdAKjknUr4gJMHbXYmSd6rGb79L4uzh/uMhRc6RWn
	UIjbshZk66BR48yVfkfRoVqsO0s0q+XqalFUdObvt/m9HmGo9pB4/2SYOPEDfcR442v+cFna8LY
	bzx56jKTpnqoj4eA7lfeNS6qxfZEUtlN2SenT7wcYd0IoFKolgfsYSoOX0+d5S1myVr7wdIxcOC
	hH+i5e0kDjO9eoOVlAKylwXvNUMGCIdAL4yBaCrZgI4BSOTaaSvNNW1EHOxOE12zM1sh6e9sMUF
	0LGFCsWfrFhAheaMua2pkLeYO9aw8BiVrn4VCha1je5ruXvSQzGQYM=
X-Received: by 2002:a05:651c:222c:b0:3a5:9bb4:cc2b with SMTP id 38308e7fff4ca-3a5a523f81bmr12563451fa.14.1789271401146;
        Sat, 12 Sep 2026 20:50:01 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a332737dsm17277051fa.22.2026.09.12.20.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:50:00 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/8] gre: make gre_parse_header() report a drop reason
Date: Sun, 13 Sep 2026 06:49:32 +0300
Message-ID: <20260913034937.875068-4-littlesmilingcloud@gmail.com>
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

gre_parse_header() returns -EINVAL for six different reasons and its
callers turn that into a plain kfree_skb().  The only detail they could
get so far was the csum_err flag, which none of them actually reads:
both ip_gre and ip6_gre declare it, pass it in and then ignore it.

Replace that dead output parameter with an enum skb_drop_reason one and
let the two receive paths report what happened.  Two reasons are added:

 - SKB_DROP_REASON_GRE_INVALID_HDR, for a header carrying an unsupported
   version or the routing bit,

 - SKB_DROP_REASON_GRE_CSUM, for a checksum error, next to the existing
   TCP_CSUM, UDP_CSUM, ICMP_CSUM and IP_CSUM.

The header pull failures reuse SKB_DROP_REASON_HDR_TRUNC, which
documents exactly this case, and gre_rcv() in the demux reuses
pskb_may_pull_reason() and SKB_DROP_REASON_UNHANDLED_PROTO.

A NULL reason keeps the meaning a NULL csum_err had: the caller is not
interested in it and the checksum must not be verified.  This matters
for the ICMP error handlers, which only get a part of the original
packet and must not drop it when the checksum does not validate.

Tunnel lookup failures still report SKB_DROP_REASON_NOT_SPECIFIED here;
they are addressed in the following patches.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  9 +++++++
 include/net/gre.h             |  2 +-
 net/ipv4/gre_demux.c          | 51 ++++++++++++++++++++++++++---------
 net/ipv4/ip_gre.c             |  6 ++---
 net/ipv6/ip6_gre.c            |  6 ++---
 5 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e1fdd11c939f..6ae7a604722d 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -131,6 +131,8 @@
 	FN(RECURSION_LIMIT)		\
 	FN(TNL_OPT_MISMATCH)		\
 	FN(TNL_OLD_SEQ)			\
+	FN(GRE_INVALID_HDR)		\
+	FN(GRE_CSUM)			\
 	FNe(MAX)
 
 /**
@@ -628,6 +630,13 @@ enum skb_drop_reason {
 	 * numbering.
 	 */
 	SKB_DROP_REASON_TNL_OLD_SEQ,
+	/**
+	 * @SKB_DROP_REASON_GRE_INVALID_HDR: the GRE header is invalid, e.g.
+	 * an unsupported version or the routing bit is set.
+	 */
+	SKB_DROP_REASON_GRE_INVALID_HDR,
+	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
+	SKB_DROP_REASON_GRE_CSUM,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/gre.h b/include/net/gre.h
index b55f67ecd2fc..a63f26c3f78e 100644
--- a/include/net/gre.h
+++ b/include/net/gre.h
@@ -33,7 +33,7 @@ int gre_add_protocol(const struct gre_protocol *proto, u8 version);
 int gre_del_protocol(const struct gre_protocol *proto, u8 version);
 
 int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
-		     bool *csum_err, __be16 proto, int nhs);
+		     enum skb_drop_reason *reason, __be16 proto, int nhs);
 
 static inline bool netif_is_gretap(const struct net_device *dev)
 {
diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
index 96fd7dc6d82d..efd5f60a9c59 100644
--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -58,26 +58,43 @@ EXPORT_SYMBOL_GPL(gre_del_protocol);
 
 /* Fills in tpi and returns header length to be pulled.
  * Note that caller must use pskb_may_pull() before pulling GRE header.
+ *
+ * @reason is only written when the header is rejected, so the caller has
+ * to initialise it before the call.
+ *
+ * A NULL @reason means that the caller is not interested in the drop
+ * reason, and also that the checksum must not be verified.  This is what
+ * the ICMP error handlers need, as they only get a part of the original
+ * packet.
  */
 int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
-		     bool *csum_err, __be16 proto, int nhs)
+		     enum skb_drop_reason *reason, __be16 proto, int nhs)
 {
 	const struct gre_base_hdr *greh;
 	__be32 *options;
 	int hdr_len;
 
-	if (unlikely(!pskb_may_pull(skb, nhs + sizeof(struct gre_base_hdr))))
+	if (unlikely(!pskb_may_pull(skb, nhs + sizeof(struct gre_base_hdr)))) {
+		if (reason)
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 		return -EINVAL;
+	}
 
 	greh = (struct gre_base_hdr *)(skb->data + nhs);
-	if (unlikely(greh->flags & (GRE_VERSION | GRE_ROUTING)))
+	if (unlikely(greh->flags & (GRE_VERSION | GRE_ROUTING))) {
+		if (reason)
+			*reason = SKB_DROP_REASON_GRE_INVALID_HDR;
 		return -EINVAL;
+	}
 
 	gre_flags_to_tnl_flags(tpi->flags, greh->flags);
 	hdr_len = gre_calc_hlen(tpi->flags);
 
-	if (!pskb_may_pull(skb, nhs + hdr_len))
+	if (!pskb_may_pull(skb, nhs + hdr_len)) {
+		if (reason)
+			*reason = SKB_DROP_REASON_HDR_TRUNC;
 		return -EINVAL;
+	}
 
 	greh = (struct gre_base_hdr *)(skb->data + nhs);
 	tpi->proto = greh->protocol;
@@ -87,8 +104,8 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		if (!skb_checksum_simple_validate(skb)) {
 			skb_checksum_try_convert(skb, IPPROTO_GRE,
 						 null_compute_pseudo);
-		} else if (csum_err) {
-			*csum_err = true;
+		} else if (reason) {
+			*reason = SKB_DROP_REASON_GRE_CSUM;
 			return -EINVAL;
 		}
 
@@ -116,8 +133,11 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 
 		val = skb_header_pointer(skb, nhs + hdr_len,
 					 sizeof(_val), &_val);
-		if (!val)
+		if (!val) {
+			if (reason)
+				*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return -EINVAL;
+		}
 		tpi->proto = proto;
 		if ((*val & 0xF0) != 0x40)
 			hdr_len += 4;
@@ -132,8 +152,11 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 	    greh->protocol == htons(ETH_P_ERSPAN2)) {
 		struct erspan_base_hdr *ershdr;
 
-		if (!pskb_may_pull(skb, nhs + hdr_len + sizeof(*ershdr)))
+		if (!pskb_may_pull(skb, nhs + hdr_len + sizeof(*ershdr))) {
+			if (reason)
+				*reason = SKB_DROP_REASON_HDR_TRUNC;
 			return -EINVAL;
+		}
 
 		ershdr = (struct erspan_base_hdr *)(skb->data + nhs + hdr_len);
 		tpi->key = cpu_to_be32(get_session_id(ershdr));
@@ -145,16 +168,20 @@ EXPORT_SYMBOL(gre_parse_header);
 
 static int gre_rcv(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct gre_protocol *proto;
 	u8 ver;
 	int ret;
 
-	if (!pskb_may_pull(skb, 12))
+	reason = pskb_may_pull_reason(skb, 12);
+	if (reason)
 		goto drop;
 
 	ver = skb->data[1]&0x7f;
-	if (ver >= GREPROTO_MAX)
+	if (ver >= GREPROTO_MAX) {
+		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 		goto drop;
+	}
 
 	rcu_read_lock();
 	proto = rcu_dereference(gre_proto[ver]);
@@ -167,11 +194,11 @@ static int gre_rcv(struct sk_buff *skb)
 drop_nohandler:
 	rcu_read_unlock();
 	dev_core_stats_rx_nohandler_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
 	return NET_RX_DROP;
 drop:
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NET_RX_DROP;
 }
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e..1894c5746a73 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -439,8 +439,8 @@ static int ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
 
 static int gre_rcv(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct tnl_ptk_info tpi;
-	bool csum_err = false;
 	int hdr_len;
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
@@ -451,7 +451,7 @@ static int gre_rcv(struct sk_buff *skb)
 	}
 #endif
 
-	hdr_len = gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IP), 0);
+	hdr_len = gre_parse_header(skb, &tpi, &reason, htons(ETH_P_IP), 0);
 	if (hdr_len < 0)
 		goto drop;
 
@@ -469,7 +469,7 @@ static int gre_rcv(struct sk_buff *skb)
 	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PORT_UNREACH, 0);
 drop:
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 8ebda0b6a78b..78854cc2dac9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -569,11 +569,11 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 
 static int gre_rcv(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct tnl_ptk_info tpi;
-	bool csum_err = false;
 	int hdr_len;
 
-	hdr_len = gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IPV6), 0);
+	hdr_len = gre_parse_header(skb, &tpi, &reason, htons(ETH_P_IPV6), 0);
 	if (hdr_len < 0)
 		goto drop;
 
@@ -594,7 +594,7 @@ static int gre_rcv(struct sk_buff *skb)
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 drop:
 	dev_core_stats_rx_dropped_inc(skb->dev);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
-- 
2.47.3

