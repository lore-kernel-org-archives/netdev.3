Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C34339370;
	Sun, 20 Sep 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919571; cv=none; b=Xtfit4CO0HGaUCut5/fSNVDm4UHYDX8HS9/pZauvnOk0ZrpPnb7lHsfOXBnWEWQYK+NYFizYfpZdypctzj+guqVozORT4FftrtIfq+Vy2KGCXgBp7DBjTZp436I7ySvhWfGcIeuQDaIs6AYjDUiyhT1lxmsPyaPdSqywMe0+js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919571; c=relaxed/simple;
	bh=SUYn+XWfntW18fPbVHqOQKxZm8do1Zu1MuLqmAPpuBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5CYz5+588aUhW5WqCDFrYZrF2gYpS9oYKEI3rsHT/rkYje03Md+vWZpApx7HUG8a5KQdEJpoR1hIsUKN46wCNBOalurNbN27wHl9HA+OZYPuy/DOSE7GynN/OdwW70qaWKVQ+/cDFD09/cs/2uqw+TLH6C2g0WhsFW9P63PcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=VlEXiNUX; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="VlEXiNUX"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 1EE9624024D;
	Sun, 20 Sep 2026 17:44:10 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id D261D2405F6;
	Sun, 20 Sep 2026 17:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1789919047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLx3hnsb/LGdHsbgXxSEqKgWiz9zRpZHDHOAMlX/Cq8=;
	b=VlEXiNUXdr6ecuU7j2GqyXW7P/SJRCLCanjtH+P2DH+7tytrH0hrbmkh1A/4173824rbI+
	m5CoDmkB/LMsnodDIf9ivXjppbSacTEs2x4YQVL52JYU5ZqrleRu1+qyfNstPNh8MvBQKy
	cVK57wGW95jdy+wjDc4XF23Mj8hXLO5jTUydSbOUQc+1C93o3nMtsv+ouh37B475EbspFh
	crL3d9Kffa2EJFWaUoaYODj6dsFdBdb0s9epIu6bIf00fRoesDB0Cu6olmn5qHrqsClFCT
	GXYJ1JLpQYu99jc8SQvpkn5yzTwXcrBeyx0aTQaND2ho3i0ygjWHEqRWtAE/TQ==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:bc00::d0f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id D77C9240363;
	Sun, 20 Sep 2026 17:44:02 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next 1/2] net: airoha: Add XDP support
Date: Sun, 20 Sep 2026 17:43:28 +0200
Message-ID: <20260920154329.161755-2-mail@tk154.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920154329.161755-1-mail@tk154.de>
References: <20260920154329.161755-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 8b7a1e
X-Rspamd-UID: 5ce64d

Implement eXpress Data Path (XDP) support for the Airoha Ethernet driver.

XDP programs are attached per net_device via the ndo_bpf hook. The BPF
program reference is stored as an RCU-protected pointer in struct
airoha_gdm_dev and replaced atomically on program load/unload via
rcu_replace_pointer().

To support XDP, the following changes are made to the RX path:

- The page pool DMA direction is switched from DMA_FROM_DEVICE to
  DMA_BIDIRECTIONAL, which is required for XDP_TX since the same page
  can be reused for transmit.
- The RX headroom is increased from NET_SKB_PAD to XDP_PACKET_HEADROOM
  so that XDP programs have the required headroom available in the data
  buffer.
- RX buffers use a full page rather than a half-page fragment. This leaves
  sufficient space for XDP headroom, skb_shared_info tailroom, and a
  standard 1500-byte MTU.
- AIROHA_RX_MAX_BUF_SIZE expresses the maximum MTU that fits in an RX
  buffer after headroom, shared-info, Ethernet, VLAN, and FCS overhead.
  MTU changes are rejected when an XDP program is loaded and the requested
  MTU would exceed this limit.
- xdp_rxq_info is registered for each RX queue during initialisation and
  unregistered on cleanup, with the page pool set as the memory model.

The XDP program is run in airoha_run_xdp() for each received buffer.
The following actions are supported:

- XDP_PASS: the buffer is passed to the normal networking stack.
- XDP_TX: the buffer is transmitted back out the same interface using
  the new airoha_xdp_xmit_back() helper.
- XDP_REDIRECT: the buffer is redirected to another interface or map
  via xdp_do_redirect(), with xdp_do_flush() deferred to the end of
  the NAPI poll via a per-queue xdp_flush flag.
- XDP_DROP (and unknown actions): the page is returned to the page pool.

Two new TX path helpers are introduced:

- airoha_xdp_submit_frame() maps an xdp_frame for DMA (or reuses the
  page pool DMA address for XDP_TX) and enqueues it into a TX ring,
  handling multi-buffer frames via skb_shared_info fragments.
- airoha_xdp_xmit_back() converts an xdp_buff to an xdp_frame and
  submits it to the TX queue corresponding to the current CPU.

The ndo_xdp_xmit handler airoha_xdp_xmit() is also added to allow
XDP redirect from other drivers into the Airoha interface. Frames are
submitted using airoha_xdp_submit_frame() with dma_map=true.

struct airoha_queue_entry is extended with an is_xdpf flag and an
xdp_frame pointer (in a union with the existing sk_buff pointer) so
that the TX completion path can correctly free either XDP frames or
SKBs.

The advertised XDP feature flags are set to:
  NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT | NETDEV_XDP_ACT_NDO_XMIT

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 386 +++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_eth.h |  19 +-
 2 files changed, 375 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64619e9a704d..71b25f225a8a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -13,6 +13,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <uapi/linux/ppp_defs.h>
+#include <linux/bpf_trace.h>
 
 #include "airoha_regs.h"
 #include "airoha_eth.h"
@@ -657,6 +658,255 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+static void airoha_unmap_xmit_buf(struct airoha_eth *eth,
+				  struct airoha_queue_entry *e)
+{
+	switch (e->dma_type) {
+	case AIROHA_DMA_MAP_PAGE:
+		dma_unmap_page(eth->dev, e->dma_addr, e->dma_len,
+			       DMA_TO_DEVICE);
+		break;
+	case AIROHA_DMA_MAP_SINGLE:
+		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
+				 DMA_TO_DEVICE);
+		break;
+	case AIROHA_DMA_UNMAPPED:
+	default:
+		break;
+	}
+	e->dma_type = AIROHA_DMA_UNMAPPED;
+}
+
+static int airoha_xdp_submit_frame(struct airoha_gdm_dev *dev,
+				   struct xdp_frame *xdpf,
+				   struct airoha_queue *q,
+				   int qid, u32 msg0, u32 msg1,
+				   bool dma_map)
+{
+	struct airoha_queue_entry *e, *next_e;
+	int len = xdpf->len, nr_frags, i;
+	struct airoha_qdma_desc *desc;
+	struct skb_shared_info *sinfo;
+	void *data = xdpf->data;
+	u16 index, next_index;
+	LIST_HEAD(tx_list);
+	dma_addr_t addr;
+	u32 val;
+
+	sinfo = xdp_get_shared_info_from_frame(xdpf);
+	nr_frags = unlikely(xdp_frame_has_frags(xdpf)) ? sinfo->nr_frags : 0;
+
+	if (q->queued >= q->ndesc - 1 - nr_frags)
+		return -EBUSY;
+
+	for (i = 0; i <= nr_frags; i++) {
+		if (dma_map) {
+			if (i == 0)
+				addr = dma_map_single(dev->eth->dev, data, len,
+						      DMA_TO_DEVICE);
+			else
+				addr = dma_map_page(dev->eth->dev, virt_to_page(data),
+						    offset_in_page(data), len,
+						    DMA_TO_DEVICE);
+			if (unlikely(dma_mapping_error(dev->eth->dev, addr)))
+				goto unmap;
+		} else {
+			struct page *page = virt_to_head_page(data);
+
+			addr = page_pool_get_dma_addr(page) +
+			       (data - (void *)page_address(page));
+			dma_sync_single_for_device(dev->eth->dev, addr, len,
+						   DMA_BIDIRECTIONAL);
+		}
+
+		e = list_first_entry(&q->tx_list, struct airoha_queue_entry, list);
+		list_move_tail(&e->list, &tx_list);
+
+		index = e - q->entry;
+		desc = &q->desc[index];
+
+		e->is_xdpf = true;
+		e->xdpf = (i == nr_frags) ? xdpf : NULL;
+		e->dma_addr = addr;
+		e->dma_len = len;
+		if (dma_map)
+			e->dma_type = i == 0 ? AIROHA_DMA_MAP_SINGLE : AIROHA_DMA_MAP_PAGE;
+		else
+			e->dma_type = AIROHA_DMA_UNMAPPED;
+
+		next_e = list_first_entry(&q->tx_list, struct airoha_queue_entry, list);
+		next_index = next_e - q->entry;
+
+		val = FIELD_PREP(QDMA_DESC_LEN_MASK, len);
+		if (i < nr_frags)
+			val |= FIELD_PREP(QDMA_DESC_MORE_MASK, 1);
+		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
+		WRITE_ONCE(desc->addr, cpu_to_le32(addr));
+		val = FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, next_index);
+		WRITE_ONCE(desc->data, cpu_to_le32(val));
+		WRITE_ONCE(desc->msg0, cpu_to_le32(msg0));
+		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
+		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
+
+		q->queued++;
+
+		if (i < nr_frags) {
+			skb_frag_t *frag = &sinfo->frags[i];
+
+			data = skb_frag_address(frag);
+			len = skb_frag_size(frag);
+		}
+	}
+
+	return next_index;
+
+unmap:
+	list_for_each_entry(e, &tx_list, list) {
+		airoha_unmap_xmit_buf(dev->eth, e);
+		e->is_xdpf = false;
+		e->xdpf = NULL;
+		q->queued--;
+	}
+	list_splice(&tx_list, &q->tx_list);
+
+	return -ENOMEM;
+}
+
+static int airoha_xdp_xmit_back(struct net_device *netdev, struct xdp_buff *xdp,
+				struct airoha_qdma *qdma)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_queue *q;
+	struct xdp_frame *xdpf;
+	u32 msg0, msg1;
+	int qid, index;
+	u8 fport;
+
+	xdpf = xdp_convert_buff_to_frame(xdp);
+	if (unlikely(!xdpf))
+		return -EOVERFLOW;
+
+	qid = airoha_qdma_get_txq(qdma, smp_processor_id());
+	q = &qdma->q_tx[qid];
+
+	msg0 = FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
+			  qid / AIROHA_NUM_QOS_QUEUES) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_QUEUE_MASK,
+			  qid % AIROHA_NUM_QOS_QUEUES);
+
+	fport = airoha_get_fe_port(dev);
+	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
+
+	spin_lock(&q->lock);
+	index = airoha_xdp_submit_frame(dev, xdpf, q, qid, msg0, msg1, false);
+	if (unlikely(index < 0)) {
+		spin_unlock(&q->lock);
+		return index;
+	}
+
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
+			TX_RING_CPU_IDX_MASK,
+			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
+	spin_unlock(&q->lock);
+
+	return 0;
+}
+
+static int airoha_xdp_xmit(struct net_device *netdev, int n,
+			   struct xdp_frame **frames, u32 flags)
+{
+	int qid, index = 0, last_index = -1, i, drops = 0;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma;
+	struct airoha_queue *q;
+	u32 msg0, msg1;
+	u8 fport;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	rcu_read_lock();
+	qdma = rcu_dereference(dev->qdma);
+	if (!qdma) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	qid = airoha_qdma_get_txq(qdma, smp_processor_id());
+	q = &qdma->q_tx[qid];
+
+	msg0 = FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
+			  qid / AIROHA_NUM_QOS_QUEUES) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_QUEUE_MASK,
+			  qid % AIROHA_NUM_QOS_QUEUES);
+
+	fport = airoha_get_fe_port(dev);
+	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
+
+	spin_lock(&q->lock);
+	for (i = 0; i < n; i++) {
+		index = airoha_xdp_submit_frame(dev, frames[i], q, qid, msg0, msg1, true);
+		if (unlikely(index < 0)) {
+			xdp_return_frame_rx_napi(frames[i]);
+			drops++;
+		} else {
+			last_index = index;
+		}
+	}
+	if (n > drops && (flags & XDP_XMIT_FLUSH))
+		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
+				TX_RING_CPU_IDX_MASK,
+				FIELD_PREP(TX_RING_CPU_IDX_MASK, last_index));
+	spin_unlock(&q->lock);
+	rcu_read_unlock();
+
+	return n - drops;
+}
+
+static bool airoha_run_xdp(struct net_device *netdev, struct bpf_prog *prog,
+			   struct xdp_buff *xdp, struct airoha_queue *q,
+			   struct airoha_queue_entry *e, struct page *page)
+{
+	u32 act = bpf_prog_run_xdp(prog, xdp);
+
+	switch (act) {
+	case XDP_PASS:
+		return false;
+	case XDP_TX:
+		if (unlikely(airoha_xdp_xmit_back(netdev, xdp, q->qdma) < 0)) {
+			trace_xdp_exception(netdev, prog, act);
+			page_pool_put_full_page(q->page_pool, page, true);
+		} else {
+			e->buf = NULL;
+		}
+		break;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(netdev, xdp, prog) < 0)) {
+			trace_xdp_exception(netdev, prog, act);
+			page_pool_put_full_page(q->page_pool, page, true);
+		} else {
+			q->xdp_flush = true;
+			e->buf = NULL;
+		}
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(netdev, prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(netdev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		page_pool_put_full_page(q->page_pool, page, true);
+		break;
+	}
+
+	return true;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
@@ -698,6 +948,27 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 		netdev = netdev_from_priv(dev);
 		if (!q->skb) { /* first buffer */
+			struct bpf_prog *xdp_prog;
+
+			rcu_read_lock();
+			xdp_prog = rcu_dereference(dev->xdp_prog);
+			if (xdp_prog) {
+				struct xdp_buff xdp;
+
+				xdp_init_buff(&xdp, q->buf_size, &q->xdp_rxq);
+				xdp_prepare_buff(&xdp, e->buf - AIROHA_RX_HEADROOM,
+						 AIROHA_RX_HEADROOM, len, false);
+
+				if (airoha_run_xdp(netdev, xdp_prog, &xdp, q, e, page)) {
+					rcu_read_unlock();
+					continue;
+				}
+
+				len = xdp.data_end - xdp.data;
+				e->buf = xdp.data;
+			}
+			rcu_read_unlock();
+
 			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
 						q->buf_size);
 			if (!q->skb)
@@ -779,6 +1050,11 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 		done += cur;
 	} while (cur && done < budget);
 
+	if (q->xdp_flush) {
+		xdp_do_flush();
+		q->xdp_flush = false;
+	}
+
 	if (done < budget && napi_complete(napi)) {
 		struct airoha_qdma *qdma = q->qdma;
 		int i, qid = q - &qdma->q_rx[0];
@@ -804,17 +1080,17 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		.order = 0,
 		.pool_size = 256,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = DMA_BIDIRECTIONAL,
 		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
 		.dev = qdma->eth->dev,
 		.napi = &q->napi,
 	};
+	int qid = q - &qdma->q_rx[0], thr, err;
 	struct airoha_eth *eth = qdma->eth;
-	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
 
-	q->buf_size = PAGE_SIZE / 2;
+	q->buf_size = PAGE_SIZE;
 	q->qdma = qdma;
 
 	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
@@ -829,15 +1105,22 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
-		int err = PTR_ERR(q->page_pool);
-
-		q->page_pool = NULL;
-		return err;
+		err = PTR_ERR(q->page_pool);
+		goto err_page_pool_create;
 	}
 
 	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
+	err = xdp_rxq_info_reg(&q->xdp_rxq, eth->napi_dev, qid, q->napi.napi_id);
+	if (err)
+		goto err_xdp_rxq_info_reg;
+
+	err = xdp_rxq_info_reg_mem_model(&q->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 q->page_pool);
+	if (err)
+		goto err_xdp_rxq_info_reg_mem_model;
+
 	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);
 	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid),
 			RX_RING_SIZE_MASK,
@@ -853,6 +1136,14 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	airoha_qdma_fill_rx_queue(q);
 
 	return 0;
+
+err_xdp_rxq_info_reg_mem_model:
+	xdp_rxq_info_unreg(&q->xdp_rxq);
+err_xdp_rxq_info_reg:
+	page_pool_destroy(q->page_pool);
+err_page_pool_create:
+	q->page_pool = NULL;
+	return err;
 }
 
 static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
@@ -882,6 +1173,9 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 		q->queued--;
 	}
 
+	if (xdp_rxq_info_is_reg(&q->xdp_rxq))
+		xdp_rxq_info_unreg(&q->xdp_rxq);
+
 	q->head = q->tail;
 	/* Set RX_DMA_IDX to RX_CPU_IDX to notify the hw the QDMA RX ring is
 	 * empty.
@@ -949,25 +1243,6 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 	q->txq_stopped = false;
 }
 
-static void airoha_unmap_xmit_buf(struct airoha_eth *eth,
-				  struct airoha_queue_entry *e)
-{
-	switch (e->dma_type) {
-	case AIROHA_DMA_MAP_PAGE:
-		dma_unmap_page(eth->dev, e->dma_addr, e->dma_len,
-			       DMA_TO_DEVICE);
-		break;
-	case AIROHA_DMA_MAP_SINGLE:
-		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
-				 DMA_TO_DEVICE);
-		break;
-	case AIROHA_DMA_UNMAPPED:
-	default:
-		break;
-	}
-	e->dma_type = AIROHA_DMA_UNMAPPED;
-}
-
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
@@ -1037,7 +1312,12 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		WRITE_ONCE(desc->msg1, 0);
 		q->queued--;
 
-		if (skb) {
+		if (e->is_xdpf) {
+			if (e->xdpf)
+				xdp_return_frame(e->xdpf);
+			e->is_xdpf = false;
+			e->xdpf = NULL;
+		} else if (e->skb) {
 			struct airoha_gdm_dev *dev = netdev_priv(skb->dev);
 			u16 qidx = skb_get_queue_mapping(skb);
 			struct netdev_queue *txq;
@@ -1218,7 +1498,12 @@ static void airoha_qdma_tx_cleanup(struct airoha_qdma *qdma)
 			WRITE_ONCE(desc->msg1, 0);
 			WRITE_ONCE(desc->msg2, 0);
 
-			if (skb) {
+			if (e->is_xdpf) {
+				if (e->xdpf)
+					xdp_return_frame(e->xdpf);
+				e->is_xdpf = false;
+				e->xdpf = NULL;
+			} else if (skb) {
 				struct netdev_queue *txq;
 
 				txq = skb_get_tx_queue(skb->dev, skb);
@@ -2201,6 +2486,12 @@ static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 
+	if (rcu_access_pointer(dev->xdp_prog) && mtu > AIROHA_RX_MAX_BUF_SIZE) {
+		netdev_err(netdev, "MTU too large for XDP (max %lu)\n",
+			   AIROHA_RX_MAX_BUF_SIZE);
+		return -EINVAL;
+	}
+
 	WRITE_ONCE(netdev->mtu, mtu);
 	if (port->users)
 		airoha_dev_set_xmit_frame_size(netdev);
@@ -2377,6 +2668,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 		list_move_tail(&e->list, &tx_list);
 		e->skb = i == nr_frags - 1 ? skb : NULL;
+		e->is_xdpf = false;
 		e->dma_addr = addr;
 		e->dma_len = len;
 
@@ -3321,6 +3613,39 @@ static int airoha_tc_setup_qdisc_htb(struct net_device *netdev,
 	return 0;
 }
 
+static int airoha_xdp_setup(struct net_device *netdev, struct bpf_prog *prog,
+			    struct netlink_ext_ack *extack)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct bpf_prog *old_prog;
+
+	if (netdev->features & NETIF_F_LRO) {
+		NL_SET_ERR_MSG_MOD(extack, "XDP is not supported with LRO");
+		return -EOPNOTSUPP;
+	}
+
+	if (netdev->mtu > AIROHA_RX_MAX_BUF_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
+		return -EOPNOTSUPP;
+	}
+
+	old_prog = rcu_replace_pointer(dev->xdp_prog, prog, lockdep_rtnl_is_held());
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
+}
+
+static int airoha_xdp_bpf(struct net_device *netdev, struct netdev_bpf *xdp)
+{
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return airoha_xdp_setup(netdev, xdp->prog, xdp->extack);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int airoha_dev_tc_setup(struct net_device *dev,
 			       enum tc_setup_type type, void *type_data)
 {
@@ -3347,6 +3672,8 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
 	.ndo_setup_tc		= airoha_dev_tc_setup,
+	.ndo_bpf		= airoha_xdp_bpf,
+	.ndo_xdp_xmit		= airoha_xdp_xmit,
 };
 
 static const struct ethtool_ops airoha_ethtool_ops = {
@@ -3435,6 +3762,9 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 			      NETIF_F_HW_TC;
 	netdev->features |= netdev->hw_features;
 	netdev->vlan_features = netdev->hw_features;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				NETDEV_XDP_ACT_REDIRECT |
+				NETDEV_XDP_ACT_NDO_XMIT;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8277c1c87bb3..cfbc0b8f5bf9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -7,6 +7,7 @@
 #ifndef AIROHA_ETH_H
 #define AIROHA_ETH_H
 
+#include <linux/bpf.h>
 #include <linux/debugfs.h>
 #include <linux/etherdevice.h>
 #include <linux/iopoll.h>
@@ -15,6 +16,7 @@
 #include <linux/reset.h>
 #include <linux/soc/airoha/airoha_offload.h>
 #include <net/dsa.h>
+#include <net/xdp.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_GDM_DEVS		2
@@ -34,7 +36,11 @@
 #define AIROHA_FE_MC_MAX_VLAN_TABLE	64
 #define AIROHA_FE_MC_MAX_VLAN_PORT	16
 #define AIROHA_NUM_TX_IRQ		2
-#define AIROHA_RX_HEADROOM		(NET_SKB_PAD + NET_IP_ALIGN)
+#define AIROHA_RX_HEADROOM		(XDP_PACKET_HEADROOM + NET_IP_ALIGN)
+#define AIROHA_RX_PAD			(AIROHA_RX_HEADROOM + \
+					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define AIROHA_RX_MAX_BUF_SIZE		(PAGE_SIZE - AIROHA_RX_PAD - \
+					 VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define AIROHA_RX_LEN(_n)		((_n) - AIROHA_RX_HEADROOM)
 #define HW_DSCP_NUM			2048
 #define IRQ_QUEUE_LEN(_n)		((_n) ? 1024 : 2048)
@@ -182,12 +188,16 @@ struct airoha_queue_entry {
 		void *buf;
 		struct {
 			struct list_head list;
-			struct sk_buff *skb;
+			union {
+				struct sk_buff *skb;
+				struct xdp_frame *xdpf;
+			};
 			enum airoha_dma_map_type dma_type;
 		};
 	};
 	dma_addr_t dma_addr;
 	u16 dma_len;
+	bool is_xdpf;
 };
 
 struct airoha_queue {
@@ -211,6 +221,9 @@ struct airoha_queue {
 	struct page_pool *page_pool;
 	struct sk_buff *skb;
 
+	struct xdp_rxq_info xdp_rxq;
+	bool xdp_flush;
+
 	struct list_head tx_list;
 };
 
@@ -589,6 +602,8 @@ struct airoha_gdm_dev {
 	unsigned long flags;
 	int nbq;
 
+	struct bpf_prog __rcu *xdp_prog;
+
 	struct airoha_hw_stats stats;
 
 	/* Serialize netdev_tx_completed_queue() calls per TX queue during
-- 
2.55.0

