Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766326;
	b=dyQ8/ShW2ffEnaqALTZ8upJQJlW85ziHS2DuGQcijwKDZ7pk0+A75Yb3BiXoShoqO5Tv
	 G/tAHtBTiXIXsRdb+2VUnGr7lbncJeTNFHa/KD7XXybAA81lOiRB0fIRKulpIGRyrLe04
	 dRXoODPB9T9IDbC18IfoGPkGqevlfbXFtuY7evTFxF/XrM/L86OLvUGp7KDNmrp2KrtdH
	 NBdDbtY2cc4n/1zbgPEP1Zp6/EyMEfv2K+icGoPDIwHZCEOCIfGVM0bpriW8e20QufCSK
	 PYQcdSjRev6+9K2s+rJh48KAevmora/AYcXummmKQdXsY1QTlYFsMFjlY09aG9RNhZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OOccbmYuW01iw5LZR3nZ2JAoDMbHPDoZLUUV7Z74Xkc=;
	b=AA2Zks/gv/YLfPgc3wLIDpcRe+L72m2Q4nmIL7+y1HxD2NpTqfm4izeTr6+rahjor8N9
	 MnRaXQLAJkhv3TdtSK2F05Al/Z3VJJ1Oz+b5phkHnH22T1HkZhEzCy5PPput/bjZDeBcS
	 ZUIzhgzrBv2IAc7OhX2WIIeLyUCqS1W0N5xjFJS7VdF4x7JJGN1FrGtbSz7S3ntRv2uxk
	 alPhyuEorRCN5+0ow+9NUNlRq4ShJjGB15e2tHIWqoSWxIU53bw3gtUpKT7yex+JHZYc8
	 aUrLWKBL+DIRtyAZRRG+iFXgIOXFtUiyROefB/oE0Lfbl9wFsJiPMvD6HHbO2QAzUFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBLQ4RC2;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC957606D809
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 04:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC957606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBLQ4RC2
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36cec75d8caso204693eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 20:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766325; x=1794371125; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOccbmYuW01iw5LZR3nZ2JAoDMbHPDoZLUUV7Z74Xkc=;
        b=NBLQ4RC2gAK08psfbp7mKQ3d+szfapgRvLw9xjSUgGik4T+SDQj9YQ/20rxlIE37PV
         qo52Uu1uoOLlnlw4u1i56SafcnWO4IBVrcBXfbyElhrAd7w87ozFS9fgcWwWx+QlaGQq
         M/7x0ALCVXcfB05gSQG5KdJbVGvN2Xnc8ob2hwgxB60D1WiTwNKqXiBWZDSSqsf0VT/h
         pK0z7BYn+WlvgCgZC3QzhkbimVr2vEGnQBm0XSg//aBnVThMqG7WqH9jRao8pY/kY8aV
         /6YdC6gJTFMcbrx0tFGuFaefnKNwLPcya1bMeYRdUpmklucG9pyl9fIfmmZ4kRQyWP21
         /MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766325; x=1794371125;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OOccbmYuW01iw5LZR3nZ2JAoDMbHPDoZLUUV7Z74Xkc=;
        b=LAFdOepTLMuor7pZH3Bs9bN9DXiavykbebuzw9I4rEwR0sCFzjwiiY0T5WSrS2g8LG
         oKhmxUB8XLDLsBXAprpgPORcj1NElJ22tUuv7vpWa3eSKUADA4AXDjQNRtoQOxQhSY0Z
         Zaq6Psv2TyANMO3akbHmDlUTFS4clKY+IfsfMgr28XnIwMaXRmvpooQsJryoAeLSATYc
         9X7SepQCE4azkr53elt67H8D8CCGCCxW7VAgjOsWwGbpB2Wqp0EJr3GHC0aIxvF6cMi+
         QAY9eZ/T2R3TOIZdrNee5H3PrWqKE7VAPot/CJH+YU3vRAhj7bzfI5KPSrpt6bQMs4yb
         zIVA==
X-Forwarded-Encrypted: i=1; AKwUvBwTirtqC0vvmwgZFaY+lf/d9etuhTuJeBbaq+6gdpafXy+JhOWDSwnZyqE0PxqeqSnbRzU8W4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sL1D829qs0LqaAVZyxB/HVeYRvDs9424EdRw8cygifNuI6mNl
	xokK7/Ns4zP7lOK31WDAfE8D8pzXeas291kClXKctNDZQSvGPNh+bXjpHK+p28Fqx0Us5V7e01x
	LQryvsquj5mDJQwqtW7OOeliAAA==
X-Received: from dycmb18-n2.prod.google.com ([2002:a05:693c:20d2:20b0:359:198a:8046])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:152d:b0:36a:79cd:12df with SMTP id 5a478bee46e88-36a79cd1c3bmr6735345eec.9.1793766324235;
 Tue, 03 Nov 2026 20:25:24 -0800 (PST)
Date: Wed,  4 Nov 2026 04:25:21 +0000
In-Reply-To: <20261104042521.3979880-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104042521.3979880-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104042521.3979880-3-almasrymina@google.com>
Subject: [PATCH net-next v3 2/2] net: prevent mixing frags from different
 memory providers or bindings
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Enforce that all fragments in a nonlinear skb come from compatible
memory providers (and for devmem, the exact same binding):

- Add skb_has_net_iovs(skb), assuming skb->unreadable and net_iov-backed
  frags are equivalent for now (with a comment noting the two can be
  decoupled in the future if readable net_iovs are introduced).
- Add skb_net_iov_provider(), skb_mem_provider_compat(), and
  skb_frags_can_coalesce() so multi-skb coalescing, shifting, and GRO
  paths can share a single check across pp_recycle, skb_zcopy(), and
  fragment memory providers:
  - empty skbs (!len && !nr_frags && !skb_has_net_iovs()) are compatible
    without mixing readable payload
  - page vs net_iov is rejected via skb_has_net_iovs() (0 pointer chases)
  - page vs page is allowed via !skb_has_net_iovs() (0 pointer chases)
  - net_iov vs net_iov compares net_iov_owner(niov) for devmem and
    niov->desc.pp for other net_iov providers (e.g., io_uring zcrx)
- Add net_devmem_skb_binding() and use it in
  validate_xmit_unreadable_skb(), zerocopy_fill_skb_from_devmem(), and
  tcp_sendmsg_locked() so frags from different devmem bindings or memory
  providers cannot be mixed on TX.
- Use skb_frags_can_coalesce() across skb_try_coalesce(), skb_shift(),
  and skb_gro_receive().
- Use skb_mem_provider_compat() in skb_gro_receive_list(),
  tcp_skb_can_collapse(), and tcp_skb_can_collapse_rx().
- Reject converting linear head_frag payloads into page frags on
  unreadable skbs in skb_try_coalesce() and skb_gro_receive().
- Reject unreadable skbs in tcp_can_coalesce_send_queue_head() since
  tcp_clone_payload() does not propagate skb->unreadable and merges
  frags via skb_frag_page() (which returns NULL for net_iovs).

This issue is theoretical and was found by manual code inspection and
LLM review; it was not triggered in production. Verified with the
net_core KUnit test suite; not tested on real hardware.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff.h | 74 ++++++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h      |  5 +--
 net/core/datagram.c    |  4 +--
 net/core/dev.c         | 14 +++-----
 net/core/devmem.h      | 22 +++++++++++++
 net/core/gro.c         | 16 +++------
 net/core/net_test.c    | 39 ++++++++++++++++++----
 net/core/skbuff.c      | 28 +++++++---------
 net/ipv4/tcp.c         |  2 +-
 net/ipv4/tcp_output.c  |  3 ++
 10 files changed, 160 insertions(+), 47 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf6ac3e4..7723c24786c34 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1882,6 +1882,16 @@ static inline bool skb_frags_readable(const struct sk_buff *skb)
 	return !skb->unreadable;
 }
 
+/* Return true if frags in this skb are backed by net_iovs.
+ * Assumes skb->unreadable and net_iov-backed frags are equivalent for now;
+ * the two can be decoupled in the future if readable net_iovs in skbs are
+ * introduced.
+ */
+static inline bool skb_has_net_iovs(const struct sk_buff *skb)
+{
+	return skb->unreadable;
+}
+
 static inline void skb_mark_not_on_list(struct sk_buff *skb)
 {
 	skb->next = NULL;
@@ -3763,6 +3773,70 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
 	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
 }
 
+/* Return an opaque pointer identifying the memory provider instance of @skb's
+ * net_iov fragments:
+ * - For devmem (NET_IOV_DMABUF), net_iov_owner(niov) (&binding->area, 1:1 with
+ *   the binding across RX queues and TX).
+ * - For other net_iov providers (e.g., io_uring zcrx), niov->desc.pp (shared
+ *   across all areas of an io_zcrx_ifq).
+ */
+static inline void *skb_net_iov_provider(const struct sk_buff *skb)
+{
+	struct net_iov *niov;
+
+	if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
+		return NULL;
+
+	niov = skb_frag_net_iov(&skb_shinfo(skb)->frags[0]);
+	if (!niov)
+		return NULL;
+
+	if (net_is_devmem_iov(niov))
+		return net_iov_owner(niov);
+
+	return niov->desc.pp;
+}
+
+/* Return true if the memory providers of @skb1 and @skb2 are compatible
+ * for coalescing. For any struct page-backed provider (the buddy allocator
+ * or a future provider handing out struct pages), coalescing is assumed
+ * feasible. For net_iov-backed providers, the provider instance pointer
+ * must match.
+ */
+static inline bool skb_mem_provider_compat(const struct sk_buff *skb1,
+					   const struct sk_buff *skb2)
+{
+	void *prov1, *prov2;
+
+	if ((!skb1->len && !skb_shinfo(skb1)->nr_frags &&
+	     !skb_has_net_iovs(skb1)) ||
+	    (!skb2->len && !skb_shinfo(skb2)->nr_frags &&
+	     !skb_has_net_iovs(skb2)))
+		return true;
+
+	if (skb_has_net_iovs(skb1) != skb_has_net_iovs(skb2))
+		return false;
+
+	if (!skb_has_net_iovs(skb1))
+		return true;
+
+	prov1 = skb_net_iov_provider(skb1);
+	prov2 = skb_net_iov_provider(skb2);
+	return prov1 && prov1 == prov2;
+}
+
+static inline bool skb_frags_can_coalesce(struct sk_buff *to,
+					  struct sk_buff *from)
+{
+	if (to->pp_recycle != from->pp_recycle)
+		return false;
+
+	if (skb_zcopy(to) || skb_zcopy(from))
+		return false;
+
+	return skb_mem_provider_compat(to, from);
+}
+
 /**
  * skb_frag_address_safe - gets the address of the data contained in a paged fragment
  * @frag: the paged fragment buffer
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf8215..07a222c0fe2d7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1268,14 +1268,15 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 		      mptcp_skb_can_collapse(to, from) &&
 		      !skb_cmp_decrypted(to, from) &&
 		      skb_pure_zcopy_same(to, from) &&
-		      skb_frags_readable(to) == skb_frags_readable(from));
+		      skb_mem_provider_compat(to, from));
 }
 
 static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
 					   const struct sk_buff *from)
 {
 	return likely(mptcp_skb_can_collapse(to, from) &&
-		      !skb_cmp_decrypted(to, from));
+		      !skb_cmp_decrypted(to, from) &&
+		      skb_mem_provider_compat(to, from));
 }
 
 /* Events passed to congestion control interface */
diff --git a/net/core/datagram.c b/net/core/datagram.c
index ecc30a6f83023..1e7db61e25a56 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -712,8 +712,8 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	size_t virt_addr, size, off;
 	struct net_iov *niov;
 
-	if (i && skb_frags_readable(skb))
-		return -EFAULT;
+	if (skb->len && net_devmem_skb_binding(skb) != binding)
+		return -EMSGSIZE;
 
 	/* Devmem filling works by taking an IOVEC from the user where the
 	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
diff --git a/net/core/dev.c b/net/core/dev.c
index 1aece2fe2429f..f241d8c650fcd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4169,8 +4169,7 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
-	struct skb_shared_info *shinfo;
-	struct net_iov *niov;
+	struct net_devmem_dmabuf_binding *binding;
 
 	if (likely(skb_frags_readable(skb) ||
 		   dev->netmem_tx == NETMEM_TX_NO_DMA))
@@ -4179,14 +4178,11 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (dev->netmem_tx == NETMEM_TX_NONE)
 		goto out_free;
 
-	shinfo = skb_shinfo(skb);
-
 	/* All net_iovs in an unreadable skb share the same binding. */
-	if (shinfo->nr_frags > 0) {
-		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
-		if (net_is_devmem_iov(niov) &&
-		    (net_devmem_iov_binding(niov)->direction != DMA_TO_DEVICE ||
-		     READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev))
+	if (skb_shinfo(skb)->nr_frags > 0) {
+		binding = net_devmem_skb_binding(skb);
+		if (!binding || binding->direction != DMA_TO_DEVICE ||
+		    READ_ONCE(binding->dev) != dev)
 			goto out_free;
 	}
 
diff --git a/net/core/devmem.h b/net/core/devmem.h
index c4f476947dfaa..33817b9e7c007 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -10,6 +10,7 @@
 #ifndef _NET_DEVMEM_H
 #define _NET_DEVMEM_H
 
+#include <linux/skbuff.h>
 #include <net/net_namespace.h>
 #include <net/netmem.h>
 #include <net/netdev_netlink.h>
@@ -117,6 +118,21 @@ net_devmem_iov_binding(const struct net_iov *niov)
 			    struct net_devmem_dmabuf_binding, area);
 }
 
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_skb_binding(const struct sk_buff *skb)
+{
+	struct net_iov *niov;
+
+	if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
+		return NULL;
+
+	niov = skb_frag_net_iov(&skb_shinfo(skb)->frags[0]);
+	if (!niov || !net_is_devmem_iov(niov))
+		return NULL;
+
+	return net_devmem_iov_binding(niov);
+}
+
 static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return net_devmem_iov_binding(niov)->id;
@@ -250,6 +266,12 @@ net_devmem_iov_binding(const struct net_iov *niov)
 {
 	return NULL;
 }
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_skb_binding(const struct sk_buff *skb)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20db..51a694b26401b 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -100,16 +100,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	struct sk_buff *lp;
 	int segs;
 
-	/* Do not splice page pool based packets w/ non-page pool
-	 * packets. This can result in reference count issues as page
-	 * pool pages will not decrement the reference count and will
-	 * instead be immediately returned to the pool or have frag
-	 * count decremented.
-	 */
-	if (p->pp_recycle != skb->pp_recycle)
-		return -ETOOMANYREFS;
-
-	if (skb_zcopy(p) || skb_zcopy(skb))
+	if (!skb_frags_can_coalesce(p, skb))
 		return -ETOOMANYREFS;
 
 	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
@@ -158,7 +149,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 		NAPI_GRO_CB(skb)->free = NAPI_GRO_FREE;
 		goto done;
-	} else if (skb->head_frag) {
+	} else if (skb->head_frag && skb_frags_readable(skb)) {
 		int nr_frags = pinfo->nr_frags;
 		skb_frag_t *frag = pinfo->frags + nr_frags;
 		struct page *page = virt_to_head_page(skb->head);
@@ -233,6 +224,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 {
+	if (!skb_mem_provider_compat(p, skb))
+		return -ETOOMANYREFS;
+
 	/* make sure to check flush flag and to not merge */
 	if (unlikely(p->len + skb->len >= 65536 ||
 		     NAPI_GRO_CB(skb)->flush))
diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c226636..548c15556cd38 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -1485,9 +1485,10 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
 	};
 	struct sk_buff *to, *from, *clone;
 	struct net_devmem_dmabuf_binding binding = {};
-	struct net_iov niov = {};
+	struct net_iov_area area2 = {};
+	struct net_iov niov = {}, niov2 = {};
 	struct page *pp_page, *reg_page;
-	netmem_ref pp_nm, niov_nm;
+	netmem_ref pp_nm, niov_nm, niov2_nm;
 	struct page_pool *pool;
 	long base_pp_ref, base_iov_ref;
 	int base_pp_page_ref, base_reg_ref;
@@ -1578,18 +1579,19 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
 	from = alloc_skb(0, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, to);
 	KUNIT_ASSERT_NOT_NULL(test, from);
-	skb_put(to, skb_tailroom(to));
 	to->pp_recycle = 1;
-	to->unreadable = 1;
 	from->pp_recycle = 1;
-	skb_add_rx_frag_netmem(from, 0, niov_nm, 0, 64, PAGE_SIZE);
+	skb_add_rx_frag_netmem(to, 0, niov_nm, 0, 32, PAGE_SIZE);
+	napi_pp_get_page(niov_nm);
+	skb_add_rx_frag_netmem(from, 0, niov_nm, 32, 64, PAGE_SIZE);
 	napi_pp_get_page(niov_nm);
 
 	clone = skb_clone(from, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, clone);
 	KUNIT_EXPECT_TRUE(test, skb_try_coalesce(to, from, &fragstolen,
 						 &delta));
-	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 4L);
+	KUNIT_EXPECT_TRUE(test, to->unreadable);
+	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 5L);
 	KUNIT_EXPECT_EQ(test, atomic_long_read(&binding.ref.data->count),
 			base_iov_ref);
 	consume_skb(from);
@@ -1597,6 +1599,31 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
 	consume_skb(to);
 	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 2L);
 
+	/* 4. Reject coalescing net_iov skbs from different bindings. */
+	net_iov_init(&niov2, &area2, NET_IOV_DMABUF);
+	niov2_nm = net_iov_to_netmem(&niov2);
+	netmem_set_pp(niov2_nm, pool);
+	netmem_or_pp_magic(niov2_nm, PP_SIGNATURE);
+	atomic_long_set(&niov2.desc.pp_ref_count, 2);
+	to = alloc_skb(0, GFP_KERNEL);
+	from = alloc_skb(0, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, to);
+	KUNIT_ASSERT_NOT_NULL(test, from);
+	to->pp_recycle = 1;
+	from->pp_recycle = 1;
+	skb_add_rx_frag_netmem(to, 0, niov_nm, 0, 32, PAGE_SIZE);
+	napi_pp_get_page(niov_nm);
+	skb_add_rx_frag_netmem(from, 0, niov2_nm, 0, 32, PAGE_SIZE);
+	napi_pp_get_page(niov2_nm);
+	KUNIT_EXPECT_FALSE(test, skb_try_coalesce(to, from, &fragstolen,
+						  &delta));
+	consume_skb(from);
+	consume_skb(to);
+	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 2L);
+	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov2.desc.pp_ref_count), 2L);
+	netmem_clear_pp_magic(niov2_nm);
+	netmem_set_pp(niov2_nm, NULL);
+
 	page_pool_put_full_page(pool, pp_page, false);
 	page_pool_put_full_page(pool, pp_page, false);
 	__free_page(reg_page);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index dc761ceb4d204..c07ec8193bb09 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4342,10 +4342,9 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 
 	if (skb_headlen(skb))
 		return 0;
-	if (skb_zcopy(tgt) || skb_zcopy(skb))
+	if (!skb_frags_can_coalesce(tgt, skb))
 		return 0;
 
-	DEBUG_NET_WARN_ON_ONCE(tgt->pp_recycle != skb->pp_recycle);
 	DEBUG_NET_WARN_ON_ONCE(skb_cmp_decrypted(tgt, skb));
 
 	todo = shiftlen;
@@ -6301,17 +6300,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	 * tricky (due to potential race with the clone disappearing) and
 	 * rare, so not worth dealing with.
 	 */
-	if (to->pp_recycle != from->pp_recycle)
-		return false;
-
-	/* All frags in an skb must either all be struct page-backed or all
-	 * belong to the same memory provider instance; do not coalesce skbs
-	 * that would mix them.
-	 */
-	if (skb_frags_readable(from) != skb_frags_readable(to))
-		return false;
-
-	if (len <= skb_tailroom(to) && skb_frags_readable(from)) {
+	if (len <= skb_tailroom(to) && to->pp_recycle == from->pp_recycle &&
+	    skb_frags_readable(to) && skb_frags_readable(from)) {
 		if (len) {
 			if (unlikely(skb_copy_bits(from, 0,
 						   skb_tail_pointer(to),
@@ -6325,17 +6315,21 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		return true;
 	}
 
+	if (!skb_frags_can_coalesce(to, from))
+		return false;
+
 	to_shinfo = skb_shinfo(to);
 	from_shinfo = skb_shinfo(from);
 	if (to_shinfo->frag_list || from_shinfo->frag_list)
 		return false;
-	if (skb_zcopy(to) || skb_zcopy(from))
-		return false;
 
 	if (skb_headlen(from) != 0) {
 		struct page *page;
 		unsigned int offset;
 
+		if (!skb_frags_readable(to) || !skb_frags_readable(from))
+			return false;
+
 		if (to_shinfo->nr_frags +
 		    from_shinfo->nr_frags >= MAX_SKB_FRAGS)
 			return false;
@@ -6365,8 +6359,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags += from_shinfo->nr_frags;
-	if (from_shinfo->nr_frags)
+	if (from_shinfo->nr_frags) {
 		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
+		to->unreadable |= from->unreadable;
+	}
 
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags = 0;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b9de7c302ba83..67651b1936a8d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1251,7 +1251,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
 
 		if (copy <= 0 || !tcp_skb_can_collapse_to(skb) ||
-		    unlikely(skb_frags_readable(skb) != !binding)) {
+		    unlikely(net_devmem_skb_binding(skb) != binding)) {
 			bool first_skb;
 
 new_segment:
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cf3ddc055d48d..110dd1c775eb5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2657,6 +2657,9 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
 
 	skb = tcp_send_head(sk);
 	tcp_for_write_queue_from_safe(skb, next, sk) {
+		if (!skb_frags_readable(skb))
+			return false;
+
 		if (len <= skb->len)
 			break;
 
-- 
2.56.0.385.gac671c819a-goog

