Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687162DF13F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162654; cv=none; b=HTV6z/m/16jzGTaU7Iu3CvwMwLBE7tKzDLSDaL3SDurdNfDCTxTTPSLt1Rm9e7UHgpjOP+AqRulO+KjKnVTc5ztgVeU0c8X7V7Lm0r2UGQ+Helr7ASqUPzNHjDRUmX+fB+/DrTvPBVmUJ2q1+96oWHNRP17ZvEP2xauH7G4IyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162654; c=relaxed/simple;
	bh=0HZwnPZ2rcelUtMycwk6J0KLMzgtNL/IZgjQYn+uei0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFtM/Q8vm4IQQO0LxXpFDBmwmK9WySn8DgKbr8AqPjK4uQkqmhgt9SoWfwEyXdhtyePc7WvfLveho88k/fqgLmEgNDVPYUsF3/e5M9qgPtbrktRkZQDGonqyhDalZRsH4h98Vso/9KJQW220Hb2S3uOs6l7BHw5sBSy5niyPYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euVybSqt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euVybSqt"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso4304373a12.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162652; x=1784767452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=usi9ZiTk3Ofj4fjNFF5pMwohzAn15bDlv9dy6F3lFnY=;
        b=euVybSqtMyV8MPfOdSc06Nep0ZpP8aiDDVtVH4iAUG+4Zsu4S7F3E955x2Z67AnwcF
         VJ03DL3AbIDbvA+KpvEPgyCy4dRWFmhVQ4DtRId9x6GIgbxYGFMAeOz5BzKe4Fw9Hwis
         w1K0fYWX/PeUiwe0vPbThF4vyDLzm9VGb6bx74H7R8koHntDIatCWsq0S7ISqezMk5q8
         d+DfzrvU3pxuJrtGfrb0cuoYHPtW4bVMVMeZMFU8n4jYiff8ql0szQIkGu0oiYd2f273
         2nA+ZgFNH0amrbIcnJ5sB1ju0lnm8ktL1WkiiOrGLiUuoOYqP9cikV9fBIOGxHlyfW72
         a4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162652; x=1784767452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=usi9ZiTk3Ofj4fjNFF5pMwohzAn15bDlv9dy6F3lFnY=;
        b=gKaIMsicuCOrBYSA0FEKtQ8k3S7EmplerkjV7VYqv7QLw/OE3Ok5+Q8UrRQo9+zGy6
         cR8inYH1hSKFh29nfv5b2avo71XGnbjRan6QTdGuIfuaTDS78LCgKE7IslX7YuRidkuO
         ye95LHWhMG8+ALg/UBOyIfdP+OiIskeoecx0a8jmg9bN6Y+Z3bsNiP8Cc8H4jebe2S9A
         Czk7Fev+ByHf4EjugS2Op3iaao4N2HPlgZWx/AUH+a7LVTJZodLXDKbceZsqMO8JkwFI
         TnkcictXahJg4en46e3iXZwkVSuCdbwahCryWS8F3PnZg3Ww+o3wQh9u4FDhAkmCkOmg
         zkBg==
X-Gm-Message-State: AOJu0YwTLT2PhStH6VmkLI9+1H6dVoue17oJ9vH7FU3178NeBSlvkpxV
	PdM4nqWRQC7UzyIcq7zvup8pK5DvFr8hFAu07d3yGiQnWPn72IgbpJiAaImsBw==
X-Gm-Gg: AfdE7cmLWTqixNxTIPLs/BSuWM0cVCfcRSc0dq2gvqlgEC3D01qK5kwMEPokyUrFMvR
	XfGrw88kD0y/lnC8IHCTTKQ3iBT+lgOhCwNADBcbm5EhIqmhku3ivGJjIpNjc/c7zdU43Egagyi
	c8y8hr8yTCXPEobclTc8JS//LL7I5lI3iDmcqkkAbmyrUqDOwMSjmYWjENyrGXyRyk5qZ5Xt4dd
	EV/pCHgQy8lnXx24T2Xzeo75dvv3GbYXXhFAH4nE/uEiEXYQvSgkPKrMjOvWjb/6zG91SXr/aEP
	+1jRTaOkQ7EAlnKAv9CrI51KBxLYvalleyQxVhGh03HO8Ct6Mk1jiUFEAIkIUUyfmxykl+YyZXT
	Tr8wpQgXcbqu7/7fKylJMU8t6SBm9KwXI8CpP+NPczH64T5NRviDo8JyKPrFWhq2Qs9cE6IMOq6
	bRfVs3KBL17HSYUuth3LjRx9pmn9eyAagWs2KmbZYbXuE4Mn7jhlwUZY1V66F5sscbaPDhyQv0I
	xsCjWmeVw==
X-Received: by 2002:a05:6a20:d706:b0:3c3:4ab3:608f with SMTP id adf61e73a8af0-3c36c1eadbcmr5590169637.29.1784162651619;
        Wed, 15 Jul 2026 17:44:11 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:11 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dave Seddon <dave.seddon.ca@gmail.com>
Subject: [PATCH net-next v1 09/11] net: flow_dissector: bound fast-path tunnel recursion
Date: Wed, 15 Jul 2026 17:43:55 -0700
Message-ID: <20260716004357.3652679-10-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
References: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The opt-in fast path descends into IP-in-IP and GRE tunnels by
recursion: flow_dissect_fast_ipv4()/ipv6() call
flow_dissect_fast_ipip_inner()/gre_inner(), which parse the inner IP
header and call back into flow_dissect_fast_ipv4()/ipv6(). Unlike the
slow path, which caps total header descents at MAX_FLOW_DISSECT_HDRS
via skb_flow_dissect_allowed(), the fast helpers had no such bound.

A crafted frame with a deeply nested tunnel chain
(IP-in-IP-in-IP-in-..., or GRE) therefore drives one C stack frame per
~20 bytes of linear header. hlen is skb_headlen(), so a large,
GRO-coalesced or locally crafted skb yields hundreds to thousands of
levels and can exhaust the kernel stack. The inner helpers also do
work after the recursive call (they stamp FLOW_DIS_ENCAPSULATION), so
the frames are not tail-call eliminable. It is additionally an output
divergence: past 15 headers the slow path stops and reports the
15th-level keys, while the fast path would recurse to the innermost,
breaking the byte-identical contract.

Thread a num_hdrs counter through the tunnel-reachable helpers and,
at each tunnel descent, mirror skb_flow_dissect_allowed(): once the
count exceeds MAX_FLOW_DISSECT_HDRS the helper returns false and the
dissect falls back to the slow path (which caps at the same limit).
For chains within the limit both paths descend fully and agree; beyond
it the fast path defers to the slow path's result, so the output stays
identical and the recursion is bounded.

The initial count at each fast-path entry is set at or above the
number of headers the slow path has already consumed (outer VLAN tags,
PPPoE, the outer IP), so the fast path never descends past the point
the slow path would have capped.

The added KUnit equivalence test's deep-nest case exercises IPIP and
GRE chains across the cap boundary; with the bound removed it fails at
16 levels, confirming it guards this fix.

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 net/core/flow_dissector.c | 61 ++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2a4b9b2af834..49b256ce5c1e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -91,28 +91,31 @@ static inline void flow_dissector_count_fast(enum flow_dissector_shape shape)
 /* IPv4 version/IHL byte of an option-less header: version 4, IHL 5. */
 #define FLOW_DIS_IPV4_VIHL_NOOPT	0x45
 
-/* Fast-path helper forward declarations. */
+/* @num_hdrs: protocol headers consumed so far (Ethernet = 1, each VLAN
+ * tag, each outer IP header). Tunnel descents increment it and defer
+ * past MAX_FLOW_DISSECT_HDRS, so both paths stop at the same depth.
+ */
 static bool flow_dissect_fast_ipv4(const struct sk_buff *skb,
 				   struct flow_dissector *flow_dissector,
 				   void *target_container,
 				   const void *data,
-				   int nhoff, int hlen);
+				   int nhoff, int hlen, int num_hdrs);
 static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 				   struct flow_dissector *flow_dissector,
 				   void *target_container,
 				   const void *data,
-				   int nhoff, int hlen);
+				   int nhoff, int hlen, int num_hdrs);
 static bool flow_dissect_fast_ipip_inner(const struct sk_buff *skb,
 					 struct flow_dissector *flow_dissector,
 					 void *target_container,
 					 const void *data,
 					 __be16 inner_eth_proto,
-					 int inner_nhoff, int hlen);
+					 int inner_nhoff, int hlen, int num_hdrs);
 static bool flow_dissect_fast_gre_inner(const struct sk_buff *skb,
 					struct flow_dissector *flow_dissector,
 					void *target_container,
 					const void *data,
-					int nhoff, int hlen);
+					int nhoff, int hlen, int num_hdrs);
 
 /* One of the two dissectors the fast-path eligibility check admits;
  * defined here so flow_dissect_fast() below can reference it (its keys
@@ -1141,7 +1144,7 @@ static bool flow_dissect_fast_ipv4(const struct sk_buff *skb,
 				   struct flow_dissector *flow_dissector,
 				   void *target_container,
 				   const void *data,
-				   int nhoff, int hlen)
+				   int nhoff, int hlen, int num_hdrs)
 {
 	struct flow_dissector_key_control *key_control;
 	struct flow_dissector_key_addrs *key_addrs;
@@ -1172,18 +1175,18 @@ static bool flow_dissect_fast_ipv4(const struct sk_buff *skb,
 				return flow_dissect_fast_ipip_inner(skb,
 						flow_dissector, target_container,
 						data, htons(ETH_P_IP),
-						nhoff + (int)sizeof(*iph), hlen);
+						nhoff + (int)sizeof(*iph), hlen, num_hdrs);
 			if (iph->protocol == IPPROTO_IPV6)
 				return flow_dissect_fast_ipip_inner(skb,
 						flow_dissector, target_container,
 						data, htons(ETH_P_IPV6),
-						nhoff + (int)sizeof(*iph), hlen);
+						nhoff + (int)sizeof(*iph), hlen, num_hdrs);
 		}
 		if (static_branch_unlikely(&flow_dissector_gre_key) &&
 		    iph->protocol == IPPROTO_GRE)
 			return flow_dissect_fast_gre_inner(skb, flow_dissector,
 					target_container, data,
-					nhoff + (int)sizeof(*iph), hlen);
+					nhoff + (int)sizeof(*iph), hlen, num_hdrs);
 		return false;
 	}
 
@@ -1241,7 +1244,7 @@ static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 				   struct flow_dissector *flow_dissector,
 				   void *target_container,
 				   const void *data,
-				   int nhoff, int hlen)
+				   int nhoff, int hlen, int num_hdrs)
 {
 	struct flow_dissector_key_control *key_control;
 	struct flow_dissector_key_addrs *key_addrs;
@@ -1317,10 +1320,10 @@ static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 					data,
 					iph->nexthdr == IPPROTO_IPIP ?
 					htons(ETH_P_IP) : htons(ETH_P_IPV6),
-					nhoff + (int)sizeof(*iph), hlen);
+					nhoff + (int)sizeof(*iph), hlen, num_hdrs);
 		return flow_dissect_fast_gre_inner(skb, flow_dissector,
 				target_container, data,
-				nhoff + (int)sizeof(*iph), hlen);
+				nhoff + (int)sizeof(*iph), hlen, num_hdrs);
 	}
 
 	thoff = nhoff + (int)sizeof(*iph);
@@ -1439,12 +1442,12 @@ static bool flow_dissect_fast_vlan(const struct sk_buff *skb,
 	case htons(ETH_P_IP):
 		ok = flow_dissect_fast_ipv4(skb, flow_dissector,
 					    target_container, data,
-					    nhoff, hlen);
+					    nhoff, hlen, vlan_depth + 2);
 		break;
 	case htons(ETH_P_IPV6):
 		ok = flow_dissect_fast_ipv6(skb, flow_dissector,
 					    target_container, data,
-					    nhoff, hlen);
+					    nhoff, hlen, vlan_depth + 2);
 		break;
 	case htons(ETH_P_8021Q):
 	case htons(ETH_P_8021AD):
@@ -1524,11 +1527,11 @@ static bool flow_dissect_fast_pppoe(const struct sk_buff *skb,
 	if (inner_eth_proto == htons(ETH_P_IP))
 		ok = flow_dissect_fast_ipv4(skb, flow_dissector,
 					    target_container, data,
-					    nhoff, hlen);
+					    nhoff, hlen, 2);
 	else
 		ok = flow_dissect_fast_ipv6(skb, flow_dissector,
 					    target_container, data,
-					    nhoff, hlen);
+					    nhoff, hlen, 2);
 
 	if (ok)
 		flow_dissector_count_fast(FLOW_DISSECTOR_SHAPE_PPPOE);
@@ -1612,19 +1615,25 @@ static bool flow_dissect_fast_ipip_inner(const struct sk_buff *skb,
 					 void *target_container,
 					 const void *data,
 					 __be16 inner_eth_proto,
-					 int inner_nhoff, int hlen)
+					 int inner_nhoff, int hlen, int num_hdrs)
 {
 	struct flow_dissector_key_control *key_control;
 	bool ok;
 
+	/* Mirror the slow path's MAX_FLOW_DISSECT_HDRS budget; past the cap
+	 * defer, so both paths stop at the same depth.
+	 */
+	if (++num_hdrs > MAX_FLOW_DISSECT_HDRS)
+		return false;
+
 	if (inner_eth_proto == htons(ETH_P_IP))
 		ok = flow_dissect_fast_ipv4(skb, flow_dissector,
 					    target_container, data,
-					    inner_nhoff, hlen);
+					    inner_nhoff, hlen, num_hdrs);
 	else if (inner_eth_proto == htons(ETH_P_IPV6))
 		ok = flow_dissect_fast_ipv6(skb, flow_dissector,
 					    target_container, data,
-					    inner_nhoff, hlen);
+					    inner_nhoff, hlen, num_hdrs);
 	else
 		return false;
 
@@ -1651,7 +1660,7 @@ static bool flow_dissect_fast_gre_inner(const struct sk_buff *skb,
 					struct flow_dissector *flow_dissector,
 					void *target_container,
 					const void *data,
-					int nhoff, int hlen)
+					int nhoff, int hlen, int num_hdrs)
 {
 	struct flow_dissector_key_control *key_control;
 	const struct gre_base_hdr *hdr;
@@ -1659,6 +1668,10 @@ static bool flow_dissect_fast_gre_inner(const struct sk_buff *skb,
 	int inner_nhoff;
 	bool ok;
 
+	/* Same MAX_FLOW_DISSECT_HDRS budget as flow_dissect_fast_ipip_inner(). */
+	if (++num_hdrs > MAX_FLOW_DISSECT_HDRS)
+		return false;
+
 	if (unlikely(hlen - nhoff < (int)sizeof(*hdr)))
 		return false;
 	hdr = (const struct gre_base_hdr *)((const u8 *)data + nhoff);
@@ -1686,11 +1699,11 @@ static bool flow_dissect_fast_gre_inner(const struct sk_buff *skb,
 	if (inner_proto == htons(ETH_P_IP))
 		ok = flow_dissect_fast_ipv4(skb, flow_dissector,
 					    target_container, data,
-					    inner_nhoff, hlen);
+					    inner_nhoff, hlen, num_hdrs);
 	else
 		ok = flow_dissect_fast_ipv6(skb, flow_dissector,
 					    target_container, data,
-					    inner_nhoff, hlen);
+					    inner_nhoff, hlen, num_hdrs);
 
 	if (!ok)
 		return false;
@@ -1764,7 +1777,7 @@ static bool flow_dissect_fast(const struct sk_buff *skb,
 			return false;
 		if (!flow_dissect_fast_ipv4(skb, flow_dissector,
 					    target_container, data,
-					    nhoff, hlen))
+					    nhoff, hlen, 1))
 			return false;
 		/* Plain top-level eth+IP only; descents count under their own shape. */
 		if (!flow_dissect_fast_is_encap(flow_dissector, target_container))
@@ -1775,7 +1788,7 @@ static bool flow_dissect_fast(const struct sk_buff *skb,
 			return false;
 		if (!flow_dissect_fast_ipv6(skb, flow_dissector,
 					    target_container, data,
-					    nhoff, hlen))
+					    nhoff, hlen, 1))
 			return false;
 		if (!flow_dissect_fast_is_encap(flow_dissector, target_container))
 			flow_dissector_count_fast(FLOW_DISSECTOR_SHAPE_ETH_IP);
-- 
2.54.0

