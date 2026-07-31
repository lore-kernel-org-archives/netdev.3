Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C3259498
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532166; cv=none; b=nIw0dwiC+OorzHgn+VObS/1013ikFosZ2yrnubTgBIe79X4rkZmgpz8GscXzPUMFGZIbfHK1RIdraf0zJ7AV/uJjch9nHJ8oyM1Xf4xoiYrgE6jzoB5RhtLDOMQcVvDD9u9CXIrKLU19nqLwEiFO+t1YG3trxHKFY12jc9rG/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532166; c=relaxed/simple;
	bh=rpRN0sWdBb7NLJtAgQi0XzFCzTHoJkkhHm5vrvFhnvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OugwFUgJMsvrmuYc7xxxbV2EOyyRqUidk50CPmlEzQnBlMv32zjDbS9OUqtKRZz3VJtdsc1YMN1xsi45zcWhn4q0y4aEgPuqLNAtSZIIiUBnhrG9DjjOyDFyYYwXrkyNp8jxQN3DSeCqpbiRSn1LbavoxM0w+8kv2mnhk+iR9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=k8zFsuxP; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="k8zFsuxP"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cbb8ebaca74so634282a12.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785532163; x=1786136963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuxnKE0JlKjewJqyedBuJDvcWdFlyRmx5rAmTPPgFo8=;
        b=k8zFsuxP6zK3T7KSCQJL4bOkQ3qDo7xvXDL8eEuECD/L7ydCjRsAJrwUxyk2Ef3Z1W
         9dz6JXMf05qLvV352FhKuaFnUFwk/SNjUaiAkidvz9a2dEod06PHA007RVeAbH9KYRCC
         4xA05hmnNYlZFuWb2zUk3cuDcD5OKW7zdN3LR7GsxoFz2Wey56bdZzvaKgZJmRW1wuhb
         rfXAChU0d8LcU+mr5GymEj5TmjBj4eL9LZeRK3+lRgoVZ4y70SGGsQmjAi56IjBhbRp5
         BcIJP4ghJQS+Jlqb9KRmtftjFmH744Ya386hswc8tTkla46Cg0LYvqD9h9OxlFRvNCb9
         5M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532163; x=1786136963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuxnKE0JlKjewJqyedBuJDvcWdFlyRmx5rAmTPPgFo8=;
        b=tHo5+/gQ7pqqdHuoPRDnciJuBhEvh0SSLr2HHI3tCqPdLqyYhq/kYENe3NaD/z40zS
         Fp9pvel+HSyyR8f6O4ki1oDe/rF3B9oy9XZ2e4sMQ+d+gMF/RoLOesV9PJy2mhGCO5kk
         so8Jd2IDS/MioxtAhVzRwsidVYqHGtL7daQyZoR6+3x4r4yswcfNoW5a3nfqIH3Yb1Xn
         y0vCov/rGW9x1Tshz1kdXty9qqHyxxwKe5yi9xlIIYBiB+OUjhuyN9POi6OZk9BQwItv
         ljJxzJu6pqaH6f6ZPE8tY1hKGAdz5kPQFCOMvocjKQ5PgJj1ofJdaLAMw2zPOBMhW8ev
         wKQQ==
X-Gm-Message-State: AOJu0Yzj5kS+Cv+2Cm14mHtCIk2KiAfWY7rtJ9X4WYu00RKPQT7ay6fS
	cFS8Nbov6j8MxTkFTGIuLlqgTDtzmH7s9G7LGeSJDtA0YB07mt/icNWwjF6LdocFAFSd2ii4et4
	FW3sIEItVzC8=
X-Gm-Gg: AR+sD115kA2Y0AfoYI93DKXrJEWlbQl7V0YwyfRKKiMPb3zZWmtiL4FH96etwmf1nrD
	3T/eTZopaRH8fxdDVrcSgmviAQ2C7W1WlfFKd52h+fv0YpOPvY06VogVRlwvKmrwOudfiobf9LI
	RUU4VapK0mEzXBeH2CrWBnRT9CQL2IpWkT2oLsnYcfmP514+AHML7Rfuu4PdWSWZ9fuK3ycSuy1
	BHv29VqDewujyaiOyDYj3vds5zQitUWOZc4TkSvb/F4Cd0WtEbFZaRQWI9t7nasqIroCBxRMOI8
	M36LKf43eYxp8blb/qaIV/2Rvv3O6ydO3jUxCTFcVRy2FPwcj+Tal8K5IW98c+F1u7Gt57rSuRq
	iOvmKDR46loi1DzSvH50idn9u0fsnOjw+H8oUpKCIKLoHDCDwoWvYknbDvYL28G0MXnTLOKXIgm
	PlwoGduEgkMq90iz7orDaGrnXRrzzqtJqtHwQvXIqDXqWiyYZiG3jgRplqAuCBKYNa3rnzFoZ+T
	C0t7yJraw==
X-Received: by 2002:a05:6a00:a212:b0:848:2f73:8ff6 with SMTP id d2e1a72fcca58-84ee48f9e76mr954544b3a.63.1785532163108;
        Fri, 31 Jul 2026 14:09:23 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29c73bsm923375b3a.29.2026.07.31.14.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:09:21 -0700 (PDT)
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
	gustavoars@kernel.org,
	jlayton@kernel.org,
	runyu.xiao@seu.edu.cn,
	kees@kernel.org,
	willemb@google.com,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] net: skbuff: reject skb header offset updates that truncate
Date: Fri, 31 Jul 2026 21:08:45 +0000
Message-ID: <98097df6369ec684ede15b3658bfe7acd0cd5daf.1785529351.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785529351.git.zihanx@nebusec.ai>
References: <cover.1785529351.git.zihanx@nebusec.ai>
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
changes in v2:
  - Keep skb_segment() default error code after successful checked header
    offset updates to avoid returning ERR_PTR(0), as reported by the kernel
    test robot.
  - Extend the checked update coverage to XFRM, ESP offload, and IPTFS
    transport-header recomputation paths instead of relying on raw hdrincl
    entry guards alone.
  - v1 Link: https://lore.kernel.org/all/cover.1785346409.git.zihanx@nebusec.ai/
---
 include/linux/skbuff.h  |  28 +++++++++
 net/core/skbuff.c       | 124 +++++++++++++++++++++++++++++++++++++---
 net/ipv4/esp4_offload.c |  15 +++--
 net/ipv4/raw.c          |   4 ++
 net/ipv6/esp6_offload.c |  15 +++--
 net/ipv6/raw.c          |   4 ++
 net/xfrm/xfrm_device.c  |  45 ++++++++++-----
 net/xfrm/xfrm_iptfs.c   |   6 +-
 net/xfrm/xfrm_output.c  |  21 ++++---
 9 files changed, 221 insertions(+), 41 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54..c8e2fb217 100644
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
+skb_add_transport_header_careful(struct sk_buff *skb, const int offset)
+{
+	if (offset > 0) {
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
index ba3dbac80..d8177e677 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -387,6 +387,9 @@ u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
 }
 EXPORT_SYMBOL_GPL(napi_skb_cache_get_bulk);
 
+static int skb_headers_offset_update_careful(struct sk_buff *skb, int off);
+static int skb_transport_header_add_careful(struct sk_buff *skb, int off);
+
 static inline void __finalize_skb_around(struct sk_buff *skb, void *data,
 					 unsigned int size)
 {
@@ -976,7 +979,11 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
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
@@ -2140,6 +2147,86 @@ void skb_headers_offset_update(struct sk_buff *skb, int off)
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
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		skb->csum_start += off;
+	if (skb_transport_header_was_set(skb))
+		skb->transport_header += off;
+	skb->network_header += off;
+	if (skb_mac_header_was_set(skb))
+		skb->mac_header += off;
+	if (skb->inner_transport_header != (typeof(skb->inner_transport_header))~0U)
+		skb->inner_transport_header += off;
+	if (skb_inner_network_header_was_set(skb)) {
+		skb->inner_network_header += off;
+		skb->inner_mac_header += off;
+	}
+
+	return 0;
+}
+
+static int skb_transport_header_add_careful(struct sk_buff *skb, int off)
+{
+	if (off > 0 && !skb_transport_header_was_set(skb))
+		return -EOVERFLOW;
+	if (skb_transport_header_was_set(skb) &&
+	    skb_transport_header_offset_overflow(skb->transport_header, off))
+		return -EOVERFLOW;
+
+	skb->transport_header += off;
+
+	return 0;
+}
+
 void skb_copy_header(struct sk_buff *new, const struct sk_buff *old)
 {
 	__copy_skb_header(new, old);
@@ -2304,6 +2391,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 
 	BUG_ON(skb_shared(skb));
 
+	if (skb_headers_offset_overflow(skb, nhead))
+		return -EOVERFLOW;
+
 	skb_zcopy_downgrade_managed(skb);
 
 	if (skb_pfmemalloc(skb))
@@ -2354,7 +2444,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	off           = nhead;
 #endif
 	skb->tail	      += off;
-	skb_headers_offset_update(skb, nhead);
+	skb_headers_offset_update_careful(skb, nhead);
 	skb->cloned   = 0;
 	skb->hdr_len  = 0;
 	skb->nohdr    = 0;
@@ -2541,7 +2631,10 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 
 	skb_copy_header(n, skb);
 
-	skb_headers_offset_update(n, newheadroom - oldheadroom);
+	if (skb_headers_offset_update_careful(n, newheadroom - oldheadroom)) {
+		kfree_skb(n);
+		return NULL;
+	}
 
 	return n;
 }
@@ -4680,7 +4773,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 	unsigned int delta_len = 0;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *nskb, *tmp;
-	int len_diff, err;
+	int head_off, len_diff, err;
 
 	/* Only skb_gro_receive_list generated skbs arrive here */
 	DEBUG_NET_WARN_ON_ONCE(!(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST));
@@ -4732,8 +4825,17 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
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
+		err = skb_transport_header_add_careful(nskb, len_diff);
+		if (unlikely(err)) {
+			nskb->next = list_skb;
+			goto err_list;
+		}
 		skb_copy_from_linear_data_offset(skb, -tnl_hlen,
 						 nskb->data - tnl_hlen,
 						 offset + tnl_hlen);
@@ -4759,9 +4861,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
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
 
@@ -4961,7 +5065,11 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		__copy_skb_header(nskb, head_skb);
 
-		skb_headers_offset_update(nskb, skb_headroom(nskb) - headroom);
+		err = skb_headers_offset_update_careful(nskb,
+							skb_headroom(nskb) - headroom);
+		if (unlikely(err))
+			goto err;
+		err = -ENOMEM;
 		skb_reset_mac_len(nskb);
 
 		skb_copy_from_linear_data_offset(head_skb, -tnl_hlen,
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f..a22ef044e 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -138,7 +138,8 @@ static struct sk_buff *xfrm4_transport_gso_segment(struct xfrm_state *x,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_add_transport_header_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 	ops = rcu_dereference(inet_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
 		segs = ops->callbacks.gso_segment(skb, features);
@@ -155,23 +156,27 @@ static struct sk_buff *xfrm4_beet_gso_segment(struct xfrm_state *x,
 	const struct net_offload *ops;
 	u8 proto = xo->proto;
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_add_transport_header_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 
 	if (x->sel.family != AF_INET6) {
 		if (proto == IPPROTO_BEETPH) {
 			struct ip_beet_phdr *ph =
 				(struct ip_beet_phdr *)skb->data;
 
-			skb->transport_header += ph->hdrlen * 8;
+			if (!skb_add_transport_header_careful(skb, ph->hdrlen * 8))
+				return ERR_PTR(-EOVERFLOW);
 			proto = ph->nexthdr;
 		} else {
 			skb->transport_header -= IPV4_BEET_PHMAXLEN;
 		}
 	} else {
+		int offset;
 		__be16 frag;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		offset = ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (!skb_add_transport_header_careful(skb, offset))
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
index 22895521a..e123f0a97 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -174,7 +174,8 @@ static struct sk_buff *xfrm6_transport_gso_segment(struct xfrm_state *x,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_add_transport_header_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 	ops = rcu_dereference(inet6_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
 		segs = ops->callbacks.gso_segment(skb, features);
@@ -191,7 +192,8 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 	const struct net_offload *ops;
 	u8 proto = xo->proto;
 
-	skb->transport_header += x->props.header_len;
+	if (!skb_add_transport_header_careful(skb, x->props.header_len))
+		return ERR_PTR(-EOVERFLOW);
 
 	if (x->sel.family != AF_INET6) {
 		skb->transport_header -=
@@ -201,7 +203,8 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 			struct ip_beet_phdr *ph =
 				(struct ip_beet_phdr *)skb->data;
 
-			skb->transport_header += ph->hdrlen * 8;
+			if (!skb_add_transport_header_careful(skb, ph->hdrlen * 8))
+				return ERR_PTR(-EOVERFLOW);
 			proto = ph->nexthdr;
 		} else {
 			skb->transport_header -= IPV4_BEET_PHMAXLEN;
@@ -210,10 +213,12 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 		if (proto == IPPROTO_TCP)
 			skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV6;
 	} else {
+		int offset;
 		__be16 frag;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		offset = ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (!skb_add_transport_header_careful(skb, offset))
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
index f153bf695..2a09bd2ee 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -20,8 +20,8 @@
 #include <linux/notifier.h>
 
 #ifdef CONFIG_XFRM_OFFLOAD
-static void __xfrm_transport_prep(struct xfrm_state *x, struct sk_buff *skb,
-				  unsigned int hsize)
+static int __xfrm_transport_prep(struct xfrm_state *x, struct sk_buff *skb,
+				 unsigned int hsize)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
@@ -30,30 +30,33 @@ static void __xfrm_transport_prep(struct xfrm_state *x, struct sk_buff *skb,
 		skb->transport_header -= x->props.header_len;
 
 	pskb_pull(skb, skb_transport_offset(skb) + x->props.header_len);
+	return 0;
 }
 
-static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
-				    unsigned int hsize)
-
+static int __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
+				   unsigned int hsize)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 
-	if (xo->flags & XFRM_GSO_SEGMENT)
-		skb->transport_header = skb->network_header + hsize;
+	if (xo->flags & XFRM_GSO_SEGMENT &&
+	    !skb_set_transport_header_careful(skb, hsize))
+		return -EOVERFLOW;
 
 	skb_reset_mac_len(skb);
 	pskb_pull(skb,
 		  skb->mac_len + x->props.header_len - x->props.enc_hdr_len);
+	return 0;
 }
 
-static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
-				  unsigned int hsize)
+static int __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
+				 unsigned int hsize)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	int phlen = 0;
 
-	if (xo->flags & XFRM_GSO_SEGMENT)
-		skb->transport_header = skb->network_header + hsize;
+	if (xo->flags & XFRM_GSO_SEGMENT &&
+	    !skb_set_transport_header_careful(skb, hsize))
+		return -EOVERFLOW;
 
 	skb_reset_mac_len(skb);
 	if (x->sel.family != AF_INET6) {
@@ -63,10 +66,11 @@ static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
 	}
 
 	pskb_pull(skb, skb->mac_len + hsize + (x->props.header_len - phlen));
+	return 0;
 }
 
 /* Adjust pointers into the packet when IPsec is done at layer2 */
-static void xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
+static int xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
 {
 	switch (x->outer_mode.encap) {
 	case XFRM_MODE_IPTFS:
@@ -98,6 +102,8 @@ static void xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
 	case XFRM_MODE_IN_TRIGGER:
 		break;
 	}
+
+	return 0;
 }
 
 static inline bool xmit_xfrm_check_overflow(struct sk_buff *skb)
@@ -175,7 +181,12 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 
 	if (!skb->next) {
 		esp_features |= skb->dev->gso_partial_features;
-		xfrm_outer_mode_prep(x, skb);
+		err = xfrm_outer_mode_prep(x, skb);
+		if (err) {
+			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
+			kfree_skb(skb);
+			return NULL;
+		}
 
 		xo->flags |= XFRM_DEV_RESUME;
 
@@ -201,7 +212,13 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		xo = xfrm_offload(skb2);
 		xo->flags |= XFRM_DEV_RESUME;
 
-		xfrm_outer_mode_prep(x, skb2);
+		err = xfrm_outer_mode_prep(x, skb2);
+		if (err) {
+			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
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

