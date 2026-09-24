Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAB37882A
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226960; cv=none; b=Ve880wHkF8yQvWmFHrh6pDCV9XvXHCC5K+CBzDWvPJDWsmOPjkkCo+6sOfoHBJKYUowLGpVzA9p8K+j9rGC5s0ThHCekK2vf857ryHq7CXBWIT/Wt68og2k36JEf2959syH+AgLm5ZY8iy+OZxZzHPU7jhbGTGWqyBAYUVo/w0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226960; c=relaxed/simple;
	bh=DiUwjLtGyhmYy8gtskynKak9GaVOE3Oh/D8/CfNFu4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUvdWXxN/sMjePYFQc4vOAEd9pg90j7ek9Jl8knA5qc0XqCwOKr7L8ZZfVnzoVQXCw5kamDphby22ySjE8glTbIIU3vJXK2VXKEetlPE/ke7oK+K1lDsLzDcTry/IEOotZGfonXCJFkforfJfJlqfm+m5r9j3jRGu6Og8GqYXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=KHiCaQWY; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="KHiCaQWY"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so8695335ad.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790226958; x=1790831758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJ5r4oLP0+o/ugLJvH/PI7dd/lO3F0+vOnqYVeSMnjU=;
        b=KHiCaQWYY3PtP4O/mc1Xx3dvhwkleDRhzDMdqFDn+WspGR8kUOjUSU5zDo9bH2eaJf
         tOdOvmuW9Abwb7nXpuw/21uBPabyBcHEVrWfnLjTtwr+5iDG+K3yRbiqcDzRe4d1K9GN
         pLRHlkCm3F7rDUKMUxM4gxcdvm9Se5ppAJS4MbK4CJccxB5g+BGTF6T6cUg3rS3TH0px
         pLlVtG7i7Bx9vBv3DNqKpu2PoQeypqKSF2OaegRXi+EnlkwYOEjERfPk7kwG9ScHyDgz
         z3MBYGb9IJehNQJIGmLtmcVNDq6Cn+v7vktWPXGyc5SK0XlLqCqphvZrvcnThgdyHOAZ
         Z+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790226958; x=1790831758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJ5r4oLP0+o/ugLJvH/PI7dd/lO3F0+vOnqYVeSMnjU=;
        b=IsjYcgET4KzXxLIKQS2GYydLnX6u6WXxRwzmRSVd9hgzBCD3LRa22nrZ+ZmddjHFJm
         A07DG1A4Tbp51sHhls5ffgzyWietghXVnb1bt+0dknMk2IGE5u4uEaQlD4ODX3pbhUal
         XXp1xwkU6q/Rc0Fr9KYeAzCoddRKBMZFF9ixUI6bXhuq8qCu9If5Vma4ijc8AmMo/vKP
         GNLpDq7fT7/A/t3LPOcX+bmUONbZTabL4XpBDuQ7+ebG3ZnH0fpcG6MvCSPsobFu64lu
         DkmHNhqPXAlWynODRCoz0gM31okZyhpVRUFz/nmywQ6sY7AaJsyVPf9ORQpOWeyhRYOr
         kJSg==
X-Gm-Message-State: AFuF++mr+9XSS4FU9dHP6Ksog3QAMXWcY2CEIsYI7Yy1GZkHva64OkPP
	TWUb3DosvLD+CdGNDsAyltW6NP0tByLpB272WbMsDmuE8OYGM8+rIS0W2zR59m5NIIP9O3hh1y3
	Uq9E8ovn+
X-Gm-Gg: AYBFou1mXUWd1WvIyjo+M7KrZ8ph2G2uEcCNpUFZ0FfUES9pfw4YYJoSy0cWnJQeAgt
	rc3MsfHiOvSDSVQcVrsATNpvuH9VRPGwVM2ez4OxOxwlQ415VPhac26lijlvyCkwZJJSbuwSSlu
	TDV0CEnxEVYc5bNDUt4XPzrFQtzM1FZ2owFrPqhAR6m1hA9vRFG3Pb3bN9dWbb1uQ5JnH+wzPKb
	nsQ/Fn+kCHnoUQMJYuqG2FOrjZAKEdOfL9+DBQ2SWMxsxD9HxmqftzuD8mJv0Inw5UBjIBKPfzS
	6PrAHSJyrIPIjGlLrPrmtpyR8sYx1jyYg9I2KMrKuzJxUmeFNHnvE5h/fUNI+62MHtqWOwJLmO0
	DayMxb5ISretjHXzCVeYeGi+l/Ogd+No9Lha+poDU0g392IyO4GXWFb6wZfPd5cOcyJhc1dFZ+h
	HMSdtcSy8vs5q2WEwpP2lb+t0EzinpbnG0W0e3HytTDjuwymMOwB5S3eFfq6TuuPtC7o403gHrQ
	aHU45cMG44560jzsub72LAvn5A28A==
X-Received: by 2002:a17:903:b86:b0:2d9:68b7:c324 with SMTP id d9443c01a7336-2df7da426d3mr11430005ad.3.1790226958528;
        Wed, 23 Sep 2026 22:15:58 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b48sm20062485ad.23.2026.09.23.22.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:15:57 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	willemb@google.com,
	kees@kernel.org,
	richardbgobert@gmail.com,
	zihanx@nebusec.ai,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v6 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Thu, 24 Sep 2026 05:15:21 +0000
Message-ID: <20260924051521.32568-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924051521.32568-1-zihanx@nebusec.ai>
References: <20260924051521.32568-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP-in-IP GSO can re-enter inet_gso_segment() or ipv6_gso_segment()
for each nested IP header. encap_level tracks header bytes, not callback
depth, so a deep chain can exhaust the kernel stack. Making
inet_gso_segment() stackable introduced unbounded IPv4 nesting; IPIP
GSO/TSO later made the path reachable. The IPv6 stackable path was
introduced separately and uses the same guard.

Count IPv4 and IPv6 GSO handler entries in skb_gso_cb, initialized once
per top-level GSO operation and preserved across GRE/UDP context changes.
Use the existing IP_TUNNEL_RECURSION_LIMIT for both handlers. The first
five entries pass, and the sixth returns -EINVAL before dispatching
another GSO callback.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v6:
  - Use IP_TUNNEL_RECURSION_LIMIT directly for both IP GSO handler
    checks instead of defining a duplicate GSO_RECURSION_LIMIT.
  - Add Closes for the v5 cover letter.
  - v5 Link: https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/
changes in v5:
  - Replace the cumulative header-offset check with a shared IP GSO
    recursion counter. Allow five handler entries and reject the sixth.
  - Initialize the counter for each top-level GSO operation and keep it
    across GRE/UDP context changes.
  - v4 Link: https://lore.kernel.org/all/cover.1790041241.git.zihanx@nebusec.ai/
changes in v4:
  - Keep the budget check only at the two IP GSO handler entries; remove
    the common callback wrapper and other GSO call-site checks.
  - Reuse skb_gso_cb->mac_offset and current skb headroom as the
    cumulative header-offset budget.
  - v3 Link: https://lore.kernel.org/all/cover.1789802623.git.zihanx@nebusec.ai/
changes in v3:
  - Treat an exhausted 256-byte budget as a callback-entry failure,
    including the zero-length check used by the common callback wrapper.
  - v2 Link: https://lore.kernel.org/all/cover.1789618203.git.zihanx@nebusec.ai/
changes in v2:
  - Replace the callback counter with a cumulative 256-byte header budget
    carried in skb_gso_cb.
  - Apply the budget at common callback entry and across IP, GRE, UDP,
    MPLS, NSH, ESP, and IPv6 extension dispatch, including context resets.
  - Rebase the UDP hunk and rerun both IPv4 PoCs; use decoded crash
    evidence from unpatched 88c17de85ddb.
  - v1 Link: https://lore.kernel.org/all/cover.1789302084.git.zihanx@nebusec.ai/
 include/net/gso.h      | 8 ++++++++
 net/core/gso.c         | 1 +
 net/ipv4/af_inet.c     | 3 +++
 net/ipv6/ip6_offload.c | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad51..0749230d414ec 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,18 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
+	u8	recursion_counter;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+static inline bool gso_recursion_inc_test(struct sk_buff *skb,
+					  unsigned int limit)
+{
+	return ++SKB_GSO_CB(skb)->recursion_counter > limit;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4df..e96ef63500648 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -117,6 +117,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8eed..4ce38c99fef9e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1375,6 +1375,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 78f50c93c536c..700f1861d8eb7 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -17,6 +17,7 @@
 #include <net/udp.h>
 #include <net/gro.h>
 #include <net/gso.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 #include "tcpv6_offload.c"
@@ -104,6 +105,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.43.0
