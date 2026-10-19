Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445774ED1B3
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411429; cv=none; b=KOqF9G/EkgALQPDzjWA5rdLWlQVdVx4Hi3iAhDobL5WkAJjrvQ4/6shxVO0DEI40pPFG2e8lI3iKK9J5pNlVqPcPhc1l6U9DHLkNqK2T3juNHlsa9E8xyeneeG1S3J+6cVHMfrgUjAjvn8H/2iV/MzPlNu2zLaEIP4JU6X2XEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411429; c=relaxed/simple;
	bh=4xBJ6J3iuSF36G6RpbWT4lVJdCclbuvdUzPPgykXxfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7p9e4FyC8qCuqJQ93mybbGds+1Q/jUrPESuhoQOZdEi0z5a69weMghbmnm0b3P4RRgQo6cUeHEaFUNRLGY8mmCpSMmZwkTMp3poSUx+u2gHqO01PoM9P3PJvLO+BfmfzDArn0cJDnHsMUX5mBTK4xe9N5LGFnw+fMBt9o8n9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6ZMZtJ4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qGXWl9xw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6ZMZtJ4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qGXWl9xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCjp2dQNMUJar27ptT1bxSKOhQtdKOeP9BpU3pm389M=;
	b=Q6ZMZtJ4Qd/pgLUGHtpUCLJY5C/9lG5ZJu4rTh1IhAFJbpm4SjZgBowCniNDcBCZNoxRXN
	oefxzEea1mjNkUrUahLIctQrRHSHnh6+d/iwdAUCgizQ/1P3LHC2uw1fqTBfY2u58PnDdf
	vkr2BNwT2+lrS34EK5s7ITHOl+CSdr0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7P1KzlYXM3KCFbPf56qHJA-1; Mon, 19 Oct 2026 12:03:44 +0000
X-MC-Unique: 7P1KzlYXM3KCFbPf56qHJA-1
X-Mimecast-MFC-AGG-ID: 7P1KzlYXM3KCFbPf56qHJA_1792411423
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1e295b702so13126505e9.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792411423; x=1793016223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCjp2dQNMUJar27ptT1bxSKOhQtdKOeP9BpU3pm389M=;
        b=qGXWl9xwH1lDXahifLlTEFrzryXOe4ezVLursNMNMlzrLnwSR7Ez06rQvdqTml3lTZ
         hfwnkRwhGdiL/1+5gi50cPx7dZeO4QRPicdfY/Z1FXLpCnCu1hT/+WuG2G70wyx//87S
         50w2UB9Ap0M8GY9Hz//f09M6XM4059LxuSSpnGmCgtVFsjcDj0eHiXdTrztD44CL6IwF
         Hx+Epz90UHgX7BrxLCWV7udRlsFS8CVJsjkqOsgeVhA3VvcZWohE0yA69YmO4mbkBAxh
         Z150i9bfB88Rp/eC6DA90fxfRjSqtDkQpXOcbfw0eXjLhkMTdm9CmhkNQKvflczO4b7m
         bQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411423; x=1793016223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gCjp2dQNMUJar27ptT1bxSKOhQtdKOeP9BpU3pm389M=;
        b=T6/kBYyPymw9aKTC6/ePfDP+4+/ZZh38BbF+JmGTT0latxI0oNKnboDnOO/xwusCwy
         cdCeyWjhCQdE/g52DUgVQTBZkTKz8Y/HwbWMzhxYR7c60IPO5fHg6yXSoQcQSptX3CDD
         UUwRkCRAl6WbXSX+ViA/nRqmj3jkPyQP2ZGhGDBHe2fERI/0F6oLGTOuM+4c8XzBMJwb
         0bL+8XLWHNgXCNQZwfGF+RgupsdXpZo2kYKRCUTivPj1n3ynVmdS5Q6ywKYgDDnPjk5D
         PlikomSI1EoQHg8f3zskKip0LbVsYhrpgaBo7foDMHKKuVTz1VjUjN8mdkRxGdxu/dL7
         Yylg==
X-Forwarded-Encrypted: i=1; AKwUvBwImlEi2cg8O+8xOwmVFSqv3Htr9f6rxetCF1VM2QQBMq9dx7yLkZzJyn+h2RC9EJlzslASaqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ445zRkufnoYFGK2xvUn9XW3buqiZ9D3Ual6WyXWMbRGxmKGNE
	wVP+RYRgKB4eXVen+ZlsUxibRRe6ptu/8PtaXPP2osH3oaMaHoHVjz9zEElpBFPrHGgQObRD99Y
	K3D8KNlxI6oo3WNXPy0CqR+snUfzWvBf9HyLSqzFFhXRGVtwMiE3YCGC/VA==
X-Gm-Gg: AYBFou34fuuMGYrjYWQn+VdKYCGnDnYFLOhUn51/0IEsw4aIK/fyZGdugBUq7vnSsG6
	u9x8V82Qry8QRFLojvqjqhgdLKsTlqAdOc9WbR2+ieRCql6rNGBFKE5JdTaJoNNu4NAFhNPecrq
	q3XcRQYJnLlF2P7STgAMingca5Aq5657+Uy48vYtPcoo+vWf9PHfcjdA5NeiF3fMq2K1Jw4ezNS
	OXozF09/p7HpMGf1ndJ4RA8hNPL4sXA+QQs3NJg7ERv5leVRFwY0ZegJ/2UM+/cF8dgmxUW9Mw2
	e8euFaWAuiXSEgQ/BManUTWwDsNF8udx7aO5wVcgfxF3ZZxQebPtvqIh1Lzh4V1l3toc8A==
X-Received: by 2002:a05:600c:64c9:b0:4a1:f0ca:2de6 with SMTP id 5b1f17b1804b1-4a1f0ca3812mr1628025e9.14.1792411422866;
        Mon, 19 Oct 2026 05:03:42 -0700 (PDT)
X-Received: by 2002:a05:600c:64c9:b0:4a1:f0ca:2de6 with SMTP id 5b1f17b1804b1-4a1f0ca3812mr1626725e9.14.1792411422109;
        Mon, 19 Oct 2026 05:03:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9c001dsm356079805e9.12.2026.10.19.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:41 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: [PATCH net v3 7/8] net: add ip4_parse()
Message-ID: <8a90cdf35017ad3e2baf04c209718dd4e8d93b0b.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

Multiple places in the net stack open-code the same minimal IPv4 header
validation: pull the fixed header, check version 4 and IHL >= 5 (where 5
is the fixed header size in 32-bit units) - and locate the transport
header at IHL * 4 past the network header.

Add a helper for doing that: it returns the validated header and
the transport header offset, or NULL if truncated or malformed.

As noted by Phil Sutter, there are more places that could use this
helper, e.g. ip_mc_check_iphdr(). They will be converted in a follow-up
patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Phil Sutter <phil@nwl.cc>
---
 include/linux/ip.h                  | 27 +++++++++++++++++++++++++++
 include/linux/virtio_net.h          | 28 +---------------------------
 net/bridge/br_netfilter_hooks.c     | 15 +++++----------
 net/ipv4/ip_input.c                 | 13 +++++--------
 net/ipv4/netfilter/nf_reject_ipv4.c | 13 +++++--------
 5 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index d11c25f5030a..7dc666e55a72 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -56,4 +56,31 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
 {
 	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
 }
+
+/**
+ * ip4_parse - pull and minimally validate an IPv4 header
+ * @skb: buffer to parse
+ * @nhoff: offset of the IPv4 header within the linear data
+ * @thoff: returns the transport header offset
+ *
+ * Only the fixed header is guaranteed linear on return: callers
+ * that need the options or the transport header must pull
+ * further.
+ */
+static inline struct iphdr *ip4_parse(struct sk_buff *skb,
+				      unsigned int nhoff,
+				      unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	return iph;
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 25aa95c11e31..beaecd9cd28d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -53,32 +53,6 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
-/* TODO: nothing virtio specific here, move to ip.h */
-
-/*
- * Pull and minimally validate the IPv4 header at @nhoff.
- * Returns the header and stores the transport header offset in
- * @thoff, or NULL if truncated or malformed.  Only the fixed header
- * is guaranteed linear; callers that need the options or the
- * transport header must pull further.
- */
-static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
-						  unsigned int nhoff,
-						  unsigned int *thoff)
-{
-	struct iphdr *iph;
-
-	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
-		return NULL;
-
-	iph = (struct iphdr *)(skb->data + nhoff);
-	if (iph->version != 4 ||
-	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
-		return NULL;
-
-	*thoff = nhoff + iph->ihl * sizeof(u32);
-	return iph;
-}
 /* Defined in net/core/dev.c, enabled while any network namespace
  * has net.core.virtio_net_hdr_csum_check set to 0.
  */
@@ -153,7 +127,7 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
 		    unsigned int *thoff, int *ip_proto)
 {
 	if (proto == htons(ETH_P_IP)) {
-		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
+		const struct iphdr *iph = ip4_parse(skb, nhoff, thoff);
 
 		if (!iph || ip_is_fragment(iph))
 			return false;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f4391..e89da0e41542 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -206,18 +206,13 @@ static inline void nf_bridge_pull_encap_header_rcsum(struct sk_buff *skb)
 static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 {
 	const struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
-	iph = ip_hdr(skb);
-
-	/* Basic sanity checks */
-	if (iph->ihl < 5 || iph->version != 4)
-		goto inhdr_error;
-
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -228,7 +223,7 @@ static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 	if (skb->len < len) {
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	if (pskb_trim_rcsum(skb, len)) {
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..5adf01763e85 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -500,7 +500,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 {
 	const struct iphdr *iph;
 	int drop_reason;
-	u32 len;
+	u32 len, thoff;
 
 	/* When the interface is in promisc. mode, drop all the crap
 	 * that it receives, do not try to analyse it.
@@ -520,10 +520,6 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	}
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto inhdr_error;
-
-	iph = ip_hdr(skb);
 
 	/*
 	 *	RFC1122: 3.2.1.2 MUST silently discard any IP frame that fails the checksum.
@@ -536,7 +532,8 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	 *	4.	Doesn't have a bogus length
 	 */
 
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
 	BUILD_BUG_ON(IPSTATS_MIB_ECT1PKTS != IPSTATS_MIB_NOECTPKTS + INET_ECN_ECT_1);
@@ -546,7 +543,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		       IPSTATS_MIB_NOECTPKTS + (iph->tos & INET_ECN_MASK),
 		       max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -559,7 +556,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	/* Our transport medium may have padded the buffer out. Now we know it
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 59ec465a9df9..42d639854ddf 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -25,22 +25,19 @@ nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
 static int nf_reject_iphdr_validate(struct sk_buff *skb)
 {
 	struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		return 0;
-
-	iph = ip_hdr(skb);
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		return 0;
 
 	len = ntohs(iph->tot_len);
 	if (skb->len < len)
 		return 0;
-	else if (len < (iph->ihl*4))
+	else if (len < thoff)
 		return 0;
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		return 0;
 
 	return 1;
-- 
MST

