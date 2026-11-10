Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306008;
	b=UuMjxdeQHpNteHEEIZwI4XFLemyoQaLrqlVM9iTn9Ebg95NBMLXpURRVSleMhM0C0PRp
	 SWnu5dyTGeKl0P0wCBojPPKPBZ76VZ92M7LceXFyQAoBPow1Spx+JDkLQ0zySYtB0Wv3t
	 ef6x96REPLzqXDua5cr8qegDzTA3vDdf/MQgtB0wiBwlvK8VeY2umwdizBf1NM+AsZNFj
	 BLOaBQEa2J1uNmXZ6efSbd0maeoo67aZ/K5uBQyUrFMUuQTr12/PaemzM/lPThcaAGLqo
	 qSzoxbdc1M84jji1FyVipLyYdx1vBrIo0fYqym7AmH1UW3DrdznYrwojKEBQjTQlfDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306008;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature;
	bh=M8ILNV3ot9wZQoa2UhnQDc7NOfIz0w/9kC5JL/dcSGg=;
	b=ZyzUwDrgW6ckpKJJpdwtnW6QDderM3oLipsT8z2eL4SxEzDV/sPUCAqwy7m1qEKvG4B6
	 JILDjbLNM1e/FkXMFGxIfUn/GIqKqZfce1/jLXhCqm/T+hFWeuBWYlge+5xpjw8WYdRGH
	 4HqBh0J46/sYJAbCA4Cu/3nmNHs/QT73LN/op11bv5Qclz0TZLqWTlpbzFvQhdBBZemfF
	 prMIFDn5GFxC8zenRSSw3WQLZre8r+k1xg4f6lo88YgVjJNlz5UmiCL8B+HYIIwDiap7t
	 jAE4QNELp2eeOgkVgltpmT1CL1PjHbNGVPcvrAfCMgnOOjY1IhScinvGojrNB0IE/qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=KpBXWzW4;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BFD606A32E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90BFD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=KpBXWzW4
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 10 Nov 2026 11:20:01 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"huangjie . albert" <huangjie.albert@bytedance.com>,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH RFC net-next v2 1/4] xdp: add mixed page_pool/page_shared memory type
Date: Tue, 10 Nov 2026 11:19:38 +0100
Message-ID: <20261110101941.1059662-2-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110101941.1059662-1-sst@poczta.fm>
References: <20261110101941.1059662-1-sst@poczta.fm>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1794306004; bh=M8ILNV3ot9wZQoa2UhnQDc7NOfIz0w/9kC5JL/dcSGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=KpBXWzW4876uUrlznwGy0IabYfyeEt7b1cje5Jo60pVdw7ld2lhkk0VfdxHGOiF4n
	 0ATtdmGLMDhMneHR5IZyfbWdWunpVXWL/ZXZoYg0YRm+Oaq1P7UzEbyuTemb++quny
	 tcLWznz979MdLKgPDcBgcp+BqfQa7AV5eNY7hPcQ=

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Generic XDP runs on skb-backed data. In that mode the skb head remains
owned by the skb, but XDP helpers may still release frags, for example
when a program trims a non-linear packet.

With the generic page_pool CoW path, the frags visible to XDP may be
backed by the generic system page_pool. In the fallback path, or for
other skb-backed memory, the same generic XDP rxq may still describe
page-frag based memory. Selecting MEM_TYPE_PAGE_POOL or
MEM_TYPE_PAGE_SHARED purely from the rxq therefore either lies about
page_pool ownership or misses recycling opportunities.

Add MEM_TYPE_MIXED for skb-backed generic XDP users. The
return path inspects the actual netmem: page_pool-backed netmems are
returned through their page_pool, and everything else falls back to
page_frag_free(). Transition netdev_rx_queue's xdp_rxq_info from
MEM_TYPE_PAGE_SHARED to MEM_TYPE_MIXED.

This keeps rxq identity stable for users which inspect xdp->rxq->dev and
xdp->rxq->queue_index, while avoiding per-packet rxq->mem mutation.

Respect new mem_type in __xdp_build_skb_from_frame() as veth could
redirect xdp_frame onto cpumap.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
[sst: rename MEM_TYPE_PAGE_POOL_OR_SHARED to MEM_TYPE_MIXED (Björn asked
 for a new name, MEM_TYPE_MIXED was Maciej's proposal), document the type]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 include/net/xdp.h |  1 +
 net/core/dev.c    |  7 ++++++
 net/core/xdp.c    | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..ba055439e497 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -45,6 +45,7 @@ enum xdp_mem_type {
 	MEM_TYPE_PAGE_ORDER0,     /* Orig XDP full page model */
 	MEM_TYPE_PAGE_POOL,
 	MEM_TYPE_XSK_BUFF_POOL,
+	MEM_TYPE_MIXED,           /* skb memory: page_pool or page_frag, per page */
 	MEM_TYPE_MAX,
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 9665f3b2f5cb..6e330fc415cb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11459,6 +11459,13 @@ static int netif_alloc_rx_queues(struct net_device *dev)
 		err = xdp_rxq_info_reg(&rx[i].xdp_rxq, dev, i, 0);
 		if (err < 0)
 			goto err_rxq_info;
+		err = xdp_rxq_info_reg_mem_model(&rx[i].xdp_rxq,
+						 MEM_TYPE_MIXED,
+						 NULL);
+		if (err < 0) {
+			xdp_rxq_info_unreg(&rx[i].xdp_rxq);
+			goto err_rxq_info;
+		}
 	}
 	return 0;
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..7077bc54d7d5 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -22,6 +22,7 @@
 #include <net/xdp_priv.h> /* struct xdp_mem_allocator */
 #include <trace/events/xdp.h>
 #include <net/xdp_sock_drv.h>
+#include "netmem_priv.h"
 
 #define REG_STATE_NEW		0x0
 #define REG_STATE_REGISTERED	0x1
@@ -280,6 +281,12 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 	if (!__is_supported_mem_type(type))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/* MEM_TYPE_MIXED has no allocator of its own: __xdp_return()
+	 * checks every page and returns page_pool pages to their pool.
+	 */
+	if (type == MEM_TYPE_MIXED && allocator)
+		return ERR_PTR(-EINVAL);
+
 	mem->type = type;
 
 	if (!allocator) {
@@ -424,6 +431,23 @@ void xdp_rxq_info_attach_page_pool(struct xdp_rxq_info *xdp_rxq,
 }
 EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
 
+static bool xdp_netmem_is_pp(netmem_ref netmem)
+{
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	return netmem_is_pp(netmem);
+#else
+	return false;
+#endif
+}
+
+static void __xdp_return_page_pool(netmem_ref netmem, bool napi_direct)
+{
+	if (napi_direct && xdp_return_frame_no_direct())
+		napi_direct = false;
+
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, napi_direct);
+}
+
 /* XDP RX runs under NAPI protection, and in different delivery error
  * scenarios (e.g. queue full), it is possible to return the xdp_frame
  * while still leveraging this protection.  The @napi_direct boolean
@@ -433,20 +457,26 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp)
 {
+	netmem_ref head;
+
 	switch (mem_type) {
 	case MEM_TYPE_PAGE_POOL:
 		netmem = netmem_compound_head(netmem);
-		if (napi_direct && xdp_return_frame_no_direct())
-			napi_direct = false;
 		/* No need to check netmem_is_pp() as mem->type knows this a
 		 * page_pool page
 		 */
-		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
-					  napi_direct);
+		__xdp_return_page_pool(netmem, napi_direct);
 		break;
 	case MEM_TYPE_PAGE_SHARED:
 		page_frag_free(__netmem_address(netmem));
 		break;
+	case MEM_TYPE_MIXED:
+		head = netmem_compound_head(netmem);
+		if (xdp_netmem_is_pp(head))
+			__xdp_return_page_pool(head, napi_direct);
+		else
+			page_frag_free(__netmem_address(netmem));
+		break;
 	case MEM_TYPE_PAGE_ORDER0:
 		put_page(__netmem_to_page(netmem));
 		break;
@@ -791,6 +821,19 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
 
+static bool xdp_mem_is_page_pool_backed(enum xdp_mem_type mem_type,
+					netmem_ref netmem)
+{
+	switch (mem_type) {
+	case MEM_TYPE_PAGE_POOL:
+		return true;
+	case MEM_TYPE_MIXED:
+		return xdp_netmem_is_pp(netmem_compound_head(netmem));
+	default:
+		return false;
+	}
+}
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
@@ -836,7 +879,8 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */
 
-	if (xdpf->mem_type == MEM_TYPE_PAGE_POOL)
+	if (xdp_mem_is_page_pool_backed(xdpf->mem_type,
+					virt_to_netmem(xdpf->data)))
 		skb_mark_for_recycle(skb);
 
 	/* Allow SKB to reuse area used by xdp_frame */
-- 
2.56.0

