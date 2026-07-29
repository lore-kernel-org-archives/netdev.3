Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AD451998
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350473; cv=none; b=newjXw67hwz6qc474pugV+u/Whi/TR5p87RJyavRvcdECFSMTJzWaJFUEBjIog9GuYXKVduOkhGYos75jeSQukwL+N0WxpZ0Gw1UWrxRoXHMYzpWuDY7AFACiFc9dasrY21XtdY8s7/SioUUhyVC31TrnWFV1drnM4O/I1nEaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350473; c=relaxed/simple;
	bh=6qBO1XKLdh04lJLTXWrMFcqy1gbc6ln0v29EpF7AqAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS2RWPlpVZ99cZpSiWzKY8+PxrWJZevTme5QrZurCiIu9CJk2pHNYSqrTtEgrsqJ4nvd6rc+orjk2HK2AwGo/cpLAXVU1uHIKEq6CJS1YnxohitoDbHZAqKCcsLPOA46NHWAf+uTtcBwC33qpIIEZh8o1Ab8DeGWvgep9kYmG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=L+SIJHMz; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="L+SIJHMz"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so10228985ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785350471; x=1785955271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J9aRH2EppQAz5p/FledynA3hPHVdEBeaMs4M5phcLF8=;
        b=L+SIJHMzTbAXkv5Hm7nZWMnmKWwBkDrJqO4c91gPH4QFBB4Kg9pUZqs1JZ/DUBFVMU
         mCiK7yFcUlNPDQU2rSoY0Wl1NfGrF4aqxQBsa/DsJ87Lgygr874aAB2MXkcDFs/258nx
         ed1uDFb5HZvG6iijuTXdcF5+7QNmBdx4YYf8qPYyYIA0UxVTutoD5TsQdSLUBOqBCkCm
         6nnWcGYrBxILcp/D4+k1xzU6J1lr209LDpJ70Ge0FXA/yJ/6I8fVVC94gh/qCRl6S39A
         4iccEWyilsAWrcTES5fCkUajruOo74zsD8STcMRXoCfM0jmhLl7a0ScObRswRVMZmizx
         IDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350471; x=1785955271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J9aRH2EppQAz5p/FledynA3hPHVdEBeaMs4M5phcLF8=;
        b=Jgzh5iscT2Tw7wTs6dXi/3A/aOB1UKZHnHccfJ3kNnZj71XelNMKlHHsK8yxvWUWy4
         /gqf58XR1EKvEUqrof8GAfat/ZnenLx8c9oNKqVL12sJ88YqBYabYHun5YO2rQRpAZnd
         hFKqR0pTLen6QSB6JBS7sbu280JCIwfmnN10hYMee2fZ1EkLbWe96I6gOjSYLeBht67T
         xsJvbC+E1Zo9gMSGm/s/wVRT/9howZ0pwiFBHTOCjrY7zgh0CtX+LS7AjlyVLb+rViUA
         se+8eYYRQJmiuSJXzAp0fdiYzK1Hg+G+wBz69cWulQkyPcjw2A5BdxjVehgAlWzci556
         Lr6g==
X-Gm-Message-State: AOJu0Yww2a7qjZc2Q9aY+juoknpjk4nYbvtpGpbsdixe5PsEHpT0oUJX
	9xM7+Kddj013w4tc2lngOdVdjh+L5UFoqnzTvmMiu2hElk2QKKO7A/eJmvhrhu8CbI1BCWQzInW
	VXpLtNE/eAgk=
X-Gm-Gg: AR+sD11KP2d6XbCf2Ue+GSfxtrhFqKn/RSmr+jiWEGVKbK1u5XhVHUluHo9pJldWATZ
	omftXDSBRLB52+Nr21AIRn0+VyzCo/PYBbB8pAlPjZ2KFKJSCFBNAFQqFZ5Ep6Q5s9xTTjKr1CM
	XxkhXH5ywFiQ3Zw+b2rQ9RcT88t+q5cKgMZaL11VsO2+5uWzXGGnkn4YElCgS8b1hnbcgEgI0CM
	k6eVfzgtzCVJF+TKGUssP6FmBecdT4ZcTdf5DCPs1I7zF4XHA3DII2zgCDuOAgaS64DnLxXaEye
	tdYbn+1u0uKxeS1DhgFbQ31LMv2A4KrvWKUxSkHEHfd26Wd7t8qLGuQ/z87nyNJwmKsI2OCzCZ9
	LJ9aAyiARaaNVdXOMpPgS2DsQimXnY94PKXl/HNm74H/hDR9Q0e6yEznyOaGjfFZ/bIs9qvrY1z
	GcD2E6PTpSyrg70m3IoaLUU0rvJPxSWSSKZfGxmjYsHURFEQgebStQm7BEwiVNylETg6RHH73ES
	1Y4jPfzWA==
X-Received: by 2002:a17:903:350c:b0:2cf:b066:7de2 with SMTP id d9443c01a7336-2d033e6992bmr206045ad.22.1785350470420;
        Wed, 29 Jul 2026 11:41:10 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a18abasm15637545ad.5.2026.07.29.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:41:09 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kerneljasonxing@gmail.com,
	kuniyu@google.com,
	bjorn@kernel.org,
	bigeasy@linutronix.de,
	jiayuan.chen@linux.dev,
	willemb@google.com,
	jlayton@kernel.org,
	gustavoars@kernel.org,
	michael.bommarito@gmail.com,
	runyu.xiao@seu.edu.cn,
	kees@kernel.org,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 1/1] net: skbuff: reject skb header offset updates that truncate
Date: Wed, 29 Jul 2026 18:40:33 +0000
Message-ID: <06ac032651d91cfe4b2e246f6fc36e3d4b2f87d1.1785346409.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785346409.git.zihanx@nebusec.ai>
References: <cover.1785346409.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

raw_send_hdrinc() and rawv6_send_hdrinc() reserve LL headroom before
storing skb header offsets in 16-bit fields. If the reserved headroom
grows past the representable range, skb_reset_network_header() truncates
the stored offset and the hdrincl path later copies the user header to
the wrong location.

On IPv4 this can also happen after the user header is copied, because the
transport header is advanced by iphlen. The value U16_MAX itself is not a
valid transport header offset either, because it is used as the unset
sentinel.

The initial raw route is not the only place that matters. LOCAL_OUT can
reroute the skb, XFRM can add dst->header_len, and LWT or other output
paths can grow the skb head later. More generally, positive calls into
skb_headers_offset_update() can wrap these 16-bit offsets, while later
paths that recompute transport_header from network_header can still
overflow it or turn it into the U16_MAX sentinel.

Reject hdrincl sends when the initial reserved LL headroom cannot fit in
the skb header offset fields, and reject later positive skb header offset
updates or transport-header recomputations before they would overflow the
stored 16-bit values.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/linux/skbuff.h  | 28 ++++++++++++
 net/core/skbuff.c       | 94 ++++++++++++++++++++++++++++++++++++++---
 net/ipv4/esp4_offload.c | 15 ++++---
 net/ipv4/raw.c          |  4 ++
 net/ipv6/esp6_offload.c | 15 ++++---
 net/ipv6/raw.c          |  4 ++
 net/xfrm/xfrm_device.c  | 38 ++++++++++++-----
 net/xfrm/xfrm_iptfs.c   |  6 ++-
 net/xfrm/xfrm_output.c  | 21 ++++++---
 9 files changed, 189 insertions(+), 36 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54..51cd63566 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,34 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+static inline bool __must_check
+skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
+{
+	if (unlikely(offset < 0 || offset >= U16_MAX))
+		return false;
+	if (unlikely(skb->network_header >= U16_MAX - offset))
+		return false;
+
+	skb->transport_header = skb->network_header + offset;
+	return true;
+}
+
+static inline bool __must_check
+skb_transport_header_add_careful(struct sk_buff *skb, const int offset)
+{
+	if (unlikely(offset > 0)) {
+		if (unlikely(!skb_transport_header_was_set(skb)))
+			return false;
+		if (unlikely(offset >= U16_MAX))
+			return false;
+		if (unlikely(skb->transport_header >= U16_MAX - offset))
+			return false;
+	}
+
+	skb->transport_header += offset;
+	return true;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80..1752f6abe 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -387,6 +387,8 @@ u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
 }
 EXPORT_SYMBOL_GPL(napi_skb_cache_get_bulk);
 
+static int skb_headers_offset_update_careful(struct sk_buff *skb, int off);
+
 static inline void __finalize_skb_around(struct sk_buff *skb, void *data,
 					 unsigned int size)
 {
@@ -976,7 +978,11 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 	skb_put(nskb, size);
 
 	head_off = skb_headroom(nskb) - skb_headroom(skb);
-	skb_headers_offset_update(nskb, head_off);
+	err = skb_headers_offset_update_careful(nskb, head_off);
+	if (err) {
+		consume_skb(nskb);
+		return err;
+	}
 
 	off = size;
 	len = skb->len - off;
@@ -2140,6 +2146,61 @@ void skb_headers_offset_update(struct sk_buff *skb, int off)
 }
 EXPORT_SYMBOL(skb_headers_offset_update);
 
+static bool skb_header_offset_overflow(unsigned int offset, int add)
+{
+	if (add <= 0)
+		return false;
+	if (add > U16_MAX)
+		return true;
+
+	return offset > U16_MAX - add;
+}
+
+static bool skb_transport_header_offset_overflow(unsigned int offset, int add)
+{
+	if (add <= 0)
+		return false;
+	if (add >= U16_MAX)
+		return true;
+
+	return offset >= U16_MAX - add;
+}
+
+static bool skb_headers_offset_overflow(const struct sk_buff *skb, int off)
+{
+	if (skb_header_offset_overflow(skb->network_header, off))
+		return true;
+	if (skb_transport_header_was_set(skb) &&
+	    skb_transport_header_offset_overflow(skb->transport_header, off))
+		return true;
+	if (skb_mac_header_was_set(skb) &&
+	    skb_header_offset_overflow(skb->mac_header, off))
+		return true;
+	if (skb_header_offset_overflow(skb->inner_transport_header, off))
+		return true;
+	if (skb_inner_network_header_was_set(skb)) {
+		if (skb_header_offset_overflow(skb->inner_network_header, off))
+			return true;
+		if (skb_header_offset_overflow(skb->inner_mac_header, off))
+			return true;
+	}
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    skb_header_offset_overflow(skb->csum_start, off))
+		return true;
+
+	return false;
+}
+
+static int skb_headers_offset_update_careful(struct sk_buff *skb, int off)
+{
+	if (skb_headers_offset_overflow(skb, off))
+		return -EOVERFLOW;
+
+	skb_headers_offset_update(skb, off);
+
+	return 0;
+}
+
 void skb_copy_header(struct sk_buff *new, const struct sk_buff *old)
 {
 	__copy_skb_header(new, old);
@@ -2304,6 +2365,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 
 	BUG_ON(skb_shared(skb));
 
+	if (skb_headers_offset_overflow(skb, nhead))
+		return -EOVERFLOW;
+
 	skb_zcopy_downgrade_managed(skb);
 
 	if (skb_pfmemalloc(skb))
@@ -2541,7 +2605,10 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 
 	skb_copy_header(n, skb);
 
-	skb_headers_offset_update(n, newheadroom - oldheadroom);
+	if (skb_headers_offset_update_careful(n, newheadroom - oldheadroom)) {
+		kfree_skb(n);
+		return NULL;
+	}
 
 	return n;
 }
@@ -4680,7 +4747,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 	unsigned int delta_len = 0;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *nskb, *tmp;
-	int len_diff, err;
+	int head_off, len_diff, err;
 
 	/* Only skb_gro_receive_list generated skbs arrive here */
 	DEBUG_NET_WARN_ON_ONCE(!(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST));
@@ -4732,8 +4799,17 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		len_diff = skb_network_header_len(nskb) - skb_network_header_len(skb);
 		__copy_skb_header(nskb, skb);
 
-		skb_headers_offset_update(nskb, skb_headroom(nskb) - skb_headroom(skb));
-		nskb->transport_header += len_diff;
+		head_off = skb_headroom(nskb) - skb_headroom(skb);
+		err = skb_headers_offset_update_careful(nskb, head_off);
+		if (unlikely(err)) {
+			nskb->next = list_skb;
+			goto err_list;
+		}
+		if (unlikely(!skb_transport_header_add_careful(nskb, len_diff))) {
+			err = -EOVERFLOW;
+			nskb->next = list_skb;
+			goto err_list;
+		}
 		skb_copy_from_linear_data_offset(skb, -tnl_hlen,
 						 nskb->data - tnl_hlen,
 						 offset + tnl_hlen);
@@ -4759,9 +4835,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 	return skb;
 
 err_linearize:
+	err = -ENOMEM;
+err_list:
 	kfree_skb_list(skb->next);
 	skb->next = NULL;
-	return ERR_PTR(-ENOMEM);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(skb_segment_list);
 
@@ -4961,7 +5039,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		__copy_skb_header(nskb, head_skb);
 
-		skb_headers_offset_update(nskb, skb_headroom(nskb) - headroom);
+		err = skb_headers_offset_update_careful(nskb, skb_headroom(nskb) - headroom);
+		if (unlikely(err))
+			goto err;
 		skb_reset_mac_len(nskb);
 
 		skb_copy_from_linear_data_offset(head_skb, -tnl_hlen,
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f..075999b95 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -138,7 +138,8 @@ static struct sk_buff *xfrm4_transport_gso_segment(struct xfrm_state *x,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_transport_header_add_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 	ops = rcu_dereference(inet_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
 		segs = ops->callbacks.gso_segment(skb, features);
@@ -155,14 +156,17 @@ static struct sk_buff *xfrm4_beet_gso_segment(struct xfrm_state *x,
 	const struct net_offload *ops;
 	u8 proto = xo->proto;
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_transport_header_add_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 
 	if (x->sel.family != AF_INET6) {
 		if (proto == IPPROTO_BEETPH) {
 			struct ip_beet_phdr *ph =
 				(struct ip_beet_phdr *)skb->data;
 
-			skb->transport_header += ph->hdrlen * 8;
+			if (!skb_transport_header_add_careful(
+				    skb, ph->hdrlen * 8))
+				return ERR_PTR(-EOVERFLOW);
 			proto = ph->nexthdr;
 		} else {
 			skb->transport_header -= IPV4_BEET_PHMAXLEN;
@@ -170,8 +174,9 @@ static struct sk_buff *xfrm4_beet_gso_segment(struct xfrm_state *x,
 	} else {
 		__be16 frag;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (!skb_transport_header_add_careful(
+			    skb, ipv6_skip_exthdr(skb, 0, &proto, &frag)))
+			return ERR_PTR(-EOVERFLOW);
 		if (proto == IPPROTO_TCP)
 			skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
 	}
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 7f74d8b95..16354bf76 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -356,6 +356,8 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto out;
 
 	hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	if (hlen >= U16_MAX - sizeof(struct iphdr))
+		return -EINVAL;
 	tlen = rt->dst.dev->needed_tailroom;
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
@@ -399,6 +401,8 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	err = -EINVAL;
 	if (iphlen > length || iphlen < sizeof(*iph))
 		goto error_free;
+	if (hlen >= U16_MAX - iphlen)
+		goto error_free;
 
 	if (iphlen >= sizeof(*iph)) {
 		if (!iph->saddr)
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a..d074ad7da 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -174,7 +174,8 @@ static struct sk_buff *xfrm6_transport_gso_segment(struct xfrm_state *x,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_transport_header_add_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 	ops = rcu_dereference(inet6_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
 		segs = ops->callbacks.gso_segment(skb, features);
@@ -191,7 +192,8 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 	const struct net_offload *ops;
 	u8 proto = xo->proto;
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_transport_header_add_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 
 	if (x->sel.family != AF_INET6) {
 		skb->transport_header -=
@@ -201,7 +203,9 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 			struct ip_beet_phdr *ph =
 				(struct ip_beet_phdr *)skb->data;
 
-			skb->transport_header += ph->hdrlen * 8;
+			if (!skb_transport_header_add_careful(
+				    skb, ph->hdrlen * 8))
+				return ERR_PTR(-EOVERFLOW);
 			proto = ph->nexthdr;
 		} else {
 			skb->transport_header -= IPV4_BEET_PHMAXLEN;
@@ -212,8 +216,9 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 	} else {
 		__be16 frag;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (!skb_transport_header_add_careful(
+			    skb, ipv6_skip_exthdr(skb, 0, &proto, &frag)))
+			return ERR_PTR(-EOVERFLOW);
 	}
 
 	if (proto == IPPROTO_IPIP)
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b88d364e7..fa223ec02 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/slab.h>
@@ -613,6 +614,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	if (flags&MSG_PROBE)
 		goto out;
 
+	if (hlen >= U16_MAX)
+		return -EINVAL;
+
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
 				  flags & MSG_DONTWAIT, &err);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index f153bf695..f005f1e3b 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -20,7 +20,7 @@
 #include <linux/notifier.h>
 
 #ifdef CONFIG_XFRM_OFFLOAD
-static void __xfrm_transport_prep(struct xfrm_state *x, struct sk_buff *skb,
+static bool __xfrm_transport_prep(struct xfrm_state *x, struct sk_buff *skb,
 				  unsigned int hsize)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
@@ -30,30 +30,34 @@ static void __xfrm_transport_prep(struct xfrm_state *x, struct sk_buff *skb,
 		skb->transport_header -= x->props.header_len;
 
 	pskb_pull(skb, skb_transport_offset(skb) + x->props.header_len);
+	return true;
 }
 
-static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
+static bool __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
 				    unsigned int hsize)
 
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
-	if (xo->flags & XFRM_GSO_SEGMENT)
-		skb->transport_header = skb->network_header + hsize;
+	if (xo->flags & XFRM_GSO_SEGMENT &&
+	    !skb_set_transport_header_careful(skb, hsize))
+		return false;
 
 	skb_reset_mac_len(skb);
 	pskb_pull(skb,
 		  skb->mac_len + x->props.header_len - x->props.enc_hdr_len);
+	return true;
 }
 
-static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
+static bool __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
 				  unsigned int hsize)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	int phlen = 0;
 
-	if (xo->flags & XFRM_GSO_SEGMENT)
-		skb->transport_header = skb->network_header + hsize;
+	if (xo->flags & XFRM_GSO_SEGMENT &&
+	    !skb_set_transport_header_careful(skb, hsize))
+		return false;
 
 	skb_reset_mac_len(skb);
 	if (x->sel.family != AF_INET6) {
@@ -63,10 +67,11 @@ static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
 	}
 
 	pskb_pull(skb, skb->mac_len + hsize + (x->props.header_len - phlen));
+	return true;
 }
 
 /* Adjust pointers into the packet when IPsec is done at layer2 */
-static void xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
+static bool xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
 {
 	switch (x->outer_mode.encap) {
 	case XFRM_MODE_IPTFS:
@@ -98,6 +103,8 @@ static void xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
 	case XFRM_MODE_IN_TRIGGER:
 		break;
 	}
+
+	return true;
 }
 
 static inline bool xmit_xfrm_check_overflow(struct sk_buff *skb)
@@ -175,7 +182,12 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 
 	if (!skb->next) {
 		esp_features |= skb->dev->gso_partial_features;
-		xfrm_outer_mode_prep(x, skb);
+		if (!xfrm_outer_mode_prep(x, skb)) {
+			XFRM_INC_STATS(xs_net(x),
+				       LINUX_MIB_XFRMOUTSTATEPROTOERROR);
+			kfree_skb(skb);
+			return NULL;
+		}
 
 		xo->flags |= XFRM_DEV_RESUME;
 
@@ -201,7 +213,13 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		xo = xfrm_offload(skb2);
 		xo->flags |= XFRM_DEV_RESUME;
 
-		xfrm_outer_mode_prep(x, skb2);
+		if (!xfrm_outer_mode_prep(x, skb2)) {
+			XFRM_INC_STATS(xs_net(x),
+				       LINUX_MIB_XFRMOUTSTATEPROTOERROR);
+			skb2->next = nskb;
+			kfree_skb_list(skb2);
+			return NULL;
+		}
 
 		err = x->type_offload->xmit(x, skb2, esp_features);
 		if (!err) {
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 597aedeac..13b62bcd9 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2379,7 +2379,8 @@ static int iptfs_encap_add_ipv4(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_set_network_header(skb, -(x->props.header_len - x->props.enc_hdr_len));
 	skb->mac_header = skb->network_header + offsetof(struct iphdr, protocol);
-	skb->transport_header = skb->network_header + sizeof(*top_iph);
+	if (!skb_set_transport_header_careful(skb, sizeof(*top_iph)))
+		return -EOVERFLOW;
 
 	top_iph = ip_hdr(skb);
 	top_iph->ihl = 5;
@@ -2426,7 +2427,8 @@ static int iptfs_encap_add_ipv6(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_set_network_header(skb, -x->props.header_len + x->props.enc_hdr_len);
 	skb->mac_header = skb->network_header + offsetof(struct ipv6hdr, nexthdr);
-	skb->transport_header = skb->network_header + sizeof(*top_iph);
+	if (!skb_set_transport_header_careful(skb, sizeof(*top_iph)))
+		return -EOVERFLOW;
 
 	top_iph = ipv6_hdr(skb);
 	top_iph->version = 6;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index cc35c2fcb..0cebe752c 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -73,7 +73,8 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
 			  offsetof(struct iphdr, protocol);
-	skb->transport_header = skb->network_header + ihl;
+	if (!skb_set_transport_header_careful(skb, ihl))
+		return -EOVERFLOW;
 	__skb_pull(skb, ihl);
 	memmove(skb_network_header(skb), iph, ihl);
 	return 0;
@@ -179,7 +180,8 @@ static int xfrm6_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	skb_set_mac_header(skb,
 			   (prevhdr - x->props.header_len) - skb->data);
 	skb_set_network_header(skb, -x->props.header_len);
-	skb->transport_header = skb->network_header + hdr_len;
+	if (!skb_set_transport_header_careful(skb, hdr_len))
+		return -EOVERFLOW;
 	__skb_pull(skb, hdr_len);
 	memmove(ipv6_hdr(skb), iph, hdr_len);
 	return 0;
@@ -209,7 +211,8 @@ static int xfrm6_ro_output(struct xfrm_state *x, struct sk_buff *skb)
 	skb_set_mac_header(skb,
 			   (prevhdr - x->props.header_len) - skb->data);
 	skb_set_network_header(skb, -x->props.header_len);
-	skb->transport_header = skb->network_header + hdr_len;
+	if (!skb_set_transport_header_careful(skb, hdr_len))
+		return -EOVERFLOW;
 	__skb_pull(skb, hdr_len);
 	memmove(ipv6_hdr(skb), iph, hdr_len);
 
@@ -241,7 +244,8 @@ static int xfrm4_beet_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 		skb->network_header += IPV4_BEET_PHMAXLEN;
 	skb->mac_header = skb->network_header +
 			  offsetof(struct iphdr, protocol);
-	skb->transport_header = skb->network_header + sizeof(*top_iph);
+	if (!skb_set_transport_header_careful(skb, sizeof(*top_iph)))
+		return -EOVERFLOW;
 
 	xfrm4_beet_make_header(skb);
 
@@ -288,7 +292,8 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
 			  offsetof(struct iphdr, protocol);
-	skb->transport_header = skb->network_header + sizeof(*top_iph);
+	if (!skb_set_transport_header_careful(skb, sizeof(*top_iph)))
+		return -EOVERFLOW;
 	top_iph = ip_hdr(skb);
 
 	top_iph->ihl = 5;
@@ -335,7 +340,8 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
 			  offsetof(struct ipv6hdr, nexthdr);
-	skb->transport_header = skb->network_header + sizeof(*top_iph);
+	if (!skb_set_transport_header_careful(skb, sizeof(*top_iph)))
+		return -EOVERFLOW;
 	top_iph = ipv6_hdr(skb);
 
 	top_iph->version = 6;
@@ -374,7 +380,8 @@ static int xfrm6_beet_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 		skb->network_header += IPV4_BEET_PHMAXLEN;
 	skb->mac_header = skb->network_header +
 			  offsetof(struct ipv6hdr, nexthdr);
-	skb->transport_header = skb->network_header + sizeof(*top_iph);
+	if (!skb_set_transport_header_careful(skb, sizeof(*top_iph)))
+		return -EOVERFLOW;
 	ph = __skb_pull(skb, XFRM_MODE_SKB_CB(skb)->ihl - hdr_len);
 
 	xfrm6_beet_make_header(skb);
-- 
2.43.0

