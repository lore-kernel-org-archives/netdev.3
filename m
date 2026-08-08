Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDF3B2FD0;
	Sat,  8 Aug 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218507; cv=none; b=i00F6wifUuxcF2xl0biDgyvC7NJAgY6LiL0qEll2Ngz1VUDY3U7oAHCzNWMCBi7mtPb61NxEmnDGpR7kdy9XA498cdFcPIBAY2LFF4jAz0crGv2ByoCOLEMMCPCp6wVUPyxulG5Oz+R+/zX4629ljs5xMzdSqekTRZAfSsWHgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218507; c=relaxed/simple;
	bh=zG2XFiFtCt5iJNHq4zl1MTchrypFqtUGTEfZtCzOHkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5vdefQlLhdqvAb3NKPBt6Acr2iet0DgbTggbkp1WJLxjiN1L1MANRbqJB7t6oSOvwGDDCukyynvP0L/XaNlSbjHjugY8Dz9mGg2Bqs8dCQknJ5/DuJES5an1GQwZTnOeTd6628+slJAV2PMyGXuMnweYpw06rxO3WXYZ7uPGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8XzciGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8XzciGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344DB1F00A3F;
	Sat,  8 Aug 2026 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218503;
	bh=XOjQzSDANY4/3UAyv7gzABglSByTTfrXyQ282vyDzjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8XzciGcpQ6hZfy1ZFgU1U9P3HBxsoMus2aaqUWVwYvgJN925Hn1llSDrTU7wl7Hu
	 nTAZXEllkAg9zLIV0DJlMpkHVIRLqhYejFvRHaZlyz457ZD2vCcY1Ssq13VWirYuhR
	 uXYMLdmEtUHyVjPp6djKnPwuZxfcLgBdqD2xtOq+fYn3MHx2EOlSDAb79flHOQBSue
	 eYUQHKiAkl99EbTQ1bg2Z/gaEIfi71dNOwF76kcOPh23JMOfKHpWX/RFs6TJcVJXx9
	 zd8ypKDdNAYvldhF+YXwf1a6PObl0zyovIOgV5rUmoxibbdX1HVFuWrKmir3Ab9i7/
	 wWrKLGejuXCVw==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 06/20] net: xilinx: tsn: add the endpoint RX data path
Date: Sat,  8 Aug 2026 12:48:22 -0700
Message-ID: <20260808194822.132771-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-7-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-7-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: xilinx: tsn: add the endpoint RX data path

This adds the RX side of the TSN endpoint: RX buffers are posted to every
RX channel at open time and reaped from the dmaengine completion callback,
which decodes a TUSER port id out of the descriptor metadata and passes
MAC1/MAC2 frames up the stack.  The completion callback also refills the
slot it just consumed, and the channel teardown path grows an extra
terminate/synchronize/terminate sequence.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index fa21d59ade16..207ca3242a12 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -42,6 +43,17 @@
>  #define TX_BD_NUM_DEFAULT		64
>  #define RX_BD_NUM_DEFAULT		128
>  
> +/*
> + * The DMA descriptor sideband status word packs TID/TDEST/TUSER together;
> + * TUSER occupies the low byte, TID/TDEST sit in the upper bits.
> + */
> +#define TSN_TUSER_MASK			GENMASK(7, 0)
> +/* TUSER Input Port ID field (bits [5:4] of the TUSER field) */
> +#define TSN_TUSER_PORT_ID_MASK		GENMASK(5, 4)
> +#define TSN_TUSER_PORT_EP		0x0
> +#define TSN_TUSER_PORT_MAC1		0x1
> +#define TSN_TUSER_PORT_MAC2		0x2
> +
>  /**
>   * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
>   * @sgl: scatter-gather list backing the DMA mapping
> @@ -115,6 +127,147 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
>  	return xchan->skb_ring[idx];
>  }
>  
> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result);
> +
> +static void ep_rx_submit_desc(struct xlnx_tsn_ep_dma_chan *xchan)
> +{
> +	struct dma_async_tx_descriptor *dma_rx_desc;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct xlnx_tsn_ep *ep = xchan->ep;
> +	struct sk_buff *skb;
> +	dma_addr_t addr;
> +
> +	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (RX_BD_NUM_DEFAULT - 1));

[Severity: Low]
This isn't a bug today, but should this use xchan->ring_size instead of
RX_BD_NUM_DEFAULT?

struct xlnx_tsn_ep_dma_chan.ring_size is documented as the number of slots
in skb_ring, is set from the caller-supplied size in ep_alloc_dma_chan(),
and ep_free_dma_chan() masks with it:

    skbuf_dma = chan->skb_ring[chan->ring_tail & (chan->ring_size - 1)];

The new RX code hardcodes RX_BD_NUM_DEFAULT for the ring mask here, for the
mask and CIRC_SPACE() in ep_dma_rx_cb(), and for the prefill count in
ep_init_dmaengine().  The two sides of the same ring now disagree about
where the size comes from, so a per-channel or ethtool-configurable RX ring
size would index out of range on one of them.

> +	if (!skbuf_dma)
> +		return;
> +
> +	skb = dev_alloc_skb(ep->max_frm_size);
> +	if (!skb)
> +		return;
> +
> +	sg_init_table(skbuf_dma->sgl, 1);
> +	addr = dma_map_single(xchan->dma_dev, skb->data, ep->max_frm_size,
> +			      DMA_FROM_DEVICE);
> +	if (unlikely(dma_mapping_error(xchan->dma_dev, addr))) {
> +		if (net_ratelimit())
> +			dev_warn(ep->dev, "DMA mapping error on RX submit\n");
> +
> +		goto err_free_skb;
> +	}
> +	sg_dma_address(skbuf_dma->sgl) = addr;
> +	sg_dma_len(skbuf_dma->sgl) = ep->max_frm_size;
> +	dma_rx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
> +					      1, DMA_DEV_TO_MEM,
> +					      DMA_PREP_INTERRUPT);
> +	if (!dma_rx_desc)
> +		goto err_unmap_skb;
> +
> +	skbuf_dma->skb = skb;
> +	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
> +	skbuf_dma->desc = dma_rx_desc;
> +	dma_rx_desc->callback_param = xchan;
> +	dma_rx_desc->callback_result = ep_dma_rx_cb;
> +	xchan->ring_head++;
> +	dmaengine_submit(dma_rx_desc);
> +
> +	return;
> +
> +err_unmap_skb:
> +	dma_unmap_single(xchan->dma_dev, addr, ep->max_frm_size, DMA_FROM_DEVICE);
> +err_free_skb:
> +	dev_kfree_skb(skb);
> +}
> +
> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
> +{

[ ... ]

> +	metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
> +						   &meta_len,
> +						   &meta_max_len);
> +	if (IS_ERR_OR_NULL(metadata)) {
> +		if (net_ratelimit())
> +			dev_warn(ep->dev, "Failed to get RX metadata pointer\n");
> +
> +		dev_kfree_skb_any(skb);
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		DEV_STATS_INC(ndev, rx_errors);
> +		goto submit_new;
> +	}

[Severity: High]
Does this path drop every received frame on the configuration described by
the binding?

The binding added by this series wires the endpoint to an AXI MCDMA:

    dmas = <&axi_mcdma_0 0>, ... <&axi_mcdma_0 23>;

In drivers/dma/xilinx/xilinx_dma.c, the "xlnx,axistream-connected"
property is only evaluated for XDMA_TYPE_AXIDMA, desc_metadata_modes is
only set to DESC_METADATA_ENGINE under that flag, and async_tx.metadata_ops
is only attached in the AXIDMA prep paths.  xilinx_mcdma_prep_slave_sg(),
which is installed as device_prep_slave_sg for XDMA_TYPE_AXIMCDMA, never
sets metadata_ops.

So for an MCDMA instance:

  ep_dma_rx_cb()
    dmaengine_desc_get_metadata_ptr()
      desc_check_and_set_metadata_mode()   /* desc_metadata_modes == 0 */
        -> -ENOTSUPP
    IS_ERR_OR_NULL(metadata) -> dev_kfree_skb_any() + rx_dropped/rx_errors

Every frame would be freed and counted as an RX error, with only a
net_ratelimit() warning to explain it.  Should ep_init_dmaengine() check
dmaengine_is_metadata_mode_supported() while arming the RX channels and
fail the open, rather than letting ndo_open succeed with a dead RX path?

> +
> +	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
> +	tuser = metadata[1] & TSN_TUSER_MASK;

[Severity: Medium]
Is this metadata layout comment correct, and is metadata[1] the sideband
word?

xilinx_dma_get_metadata_ptr() returns the app array, not the start of the
descriptor status words:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_get_metadata_ptr() {
    ...
	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
	seg = list_first_entry(&desc->segments,
			       struct xilinx_axidma_tx_segment, node);
	return seg->hw.app;
}

And in struct xilinx_aximcdma_desc_hw:

	u32 status;		/* @0x18 */
	u32 sideband_status;	/* @0x1C */
	u32 app[XILINX_DMA_NUM_APP_WORDS]; /* @0x20 */

That makes metadata[0] == app[0] and metadata[1] == app[1]; status and
sideband_status sit before the returned pointer and are not reachable
through this API.  The existing consumer of the same API agrees that index
N maps to app[N]:

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_dma_rx_cb() {
    ...
	rx_len = (app_metadata[LEN_APP] & 0xFFFF);   /* #define LEN_APP 4 */
}

With the base off by two words, tuser and port_id are decoded from an
unrelated AXI4-Stream application word, so frames are either all dropped as
"unexpected TUSER port_id" or, once the later patch adds

	skb_dst_set_noref(skb, &ep->port_md[port_id]->dst);

attributed to the wrong DSA user port.  Could either the index or the
comment be corrected so the claimed layout is verifiable?

> +	rx_len = ep->max_frm_size - result->residue;

[ ... ]

> +	skb_put(skb, rx_len);
> +	skb->dev = ndev;
> +	skb->protocol = eth_type_trans(skb, ndev);
> +	skb->ip_summed = CHECKSUM_NONE;
> +	__netif_rx(skb);
> +
> +	DEV_STATS_INC(ndev, rx_packets);
> +	DEV_STATS_ADD(ndev, rx_bytes, rx_len);

[Severity: Low]
This isn't a bug, but could the changelog say why the RX path is not NAPI
based?  Frames are pushed with __netif_rx() straight from the dmaengine
completion callback, so there is no poll budget and no GRO, and every frame
goes through the per-CPU backlog where overflow is accounted to the core
drop counters rather than the driver.  The per-packet statistics also use
the legacy dev->stats atomics (DEV_STATS_INC/DEV_STATS_ADD) in the hot
path.

> +
> +submit_new:
> +	if (READ_ONCE(ep->closing))
> +		return;
> +
> +	avail = CIRC_SPACE(xchan->ring_head, xchan->ring_tail,
> +			   RX_BD_NUM_DEFAULT);
> +	for (i = 0; i < avail; i++)
> +		ep_rx_submit_desc(xchan);
> +	dma_async_issue_pending(xchan->chan);
> +}

[Severity: Medium]
Can RX stall permanently here if the refills fail?

ep_rx_submit_desc() returns silently on dev_alloc_skb() returning NULL, on
dma_map_single() failure and on dmaengine_prep_slave_sg() returning NULL.
None of those advance ring_head, bump a counter, or tell the caller
anything.

ep_dma_rx_cb() has already done xchan->ring_tail++ unconditionally, so the
number of outstanding descriptors (ring_head - ring_tail) drops by one for
every failed refill.  The loop above then performs avail no-ops.

The only callers of ep_rx_submit_desc() are ep_init_dmaengine() and this
callback; there is no worker, timer or poll routine, as the commit message
notes:

    Refill each slot from the completion callback unless the interface is
    closing, which keeps the ring full without a separate refill worker.

So once the outstanding count reaches zero the DMA engine raises no further
completion, this callback is never entered again, and RX is dead until the
interface is downed and re-opened.  dev_alloc_skb() here runs in the
dmaengine tasklet with GFP_ATOMIC, and a persistent mapping failure (IOMMU
or swiotlb space exhaustion) makes all attempts fail deterministically.
Would a bounded retry, a work item, or an error return from the arming path
be preferable?  This still reads the same way at the end of the series.

> +
>  static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	dev_kfree_skb(skb);
> @@ -229,8 +382,18 @@ static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
>  	if (!chan)
>  		return;
>  
> -	if (chan->chan)
> +	if (chan->chan) {
> +		/* Drain the in-flight completion callback, then synchronize in
> +		 * case that callback re-armed a descriptor before it observed
> +		 * ep->closing. xilinx_dma_tx_submit() clears chan->terminating
> +		 * on every submit, so a single terminate does not cover a
> +		 * re-arm. The final terminate is a barrier before the channel
> +		 * memory is freed.
> +		 */
>  		dmaengine_terminate_sync(chan->chan);
> +		dmaengine_synchronize(chan->chan);
> +		dmaengine_terminate_sync(chan->chan);
> +	}

[Severity: High]
Does this sequence actually close the window, or does it only clean up
after the damage?

Nothing serializes the re-arm in ep_dma_rx_cb() against the terminate here.
The check-then-act on ep->closing gives no exclusion:

  tasklet: xilinx_dma_chan_desc_cleanup()
	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
		...
		spin_unlock_irqrestore(&chan->lock, flags);
		dmaengine_desc_get_callback_invoke(&desc->async_tx, &result);
		spin_lock_irqsave(&chan->lock, flags);
		...
		xilinx_dma_free_tx_descriptor(chan, desc);
		if (chan->terminating)
			break;
	}

  callback: READ_ONCE(ep->closing) == false

  ip link set down: ep_stop() -> ep_exit_dmaengine() -> ep_free_dma_chan()
	  dmaengine_terminate_sync() -> xilinx_dma_terminate_all()
		  chan->terminating = true;
		  xilinx_dma_free_descriptors();  /* kfree()s done_list
						     entries, including the
						     iterator's `next` */

  callback: ep_rx_submit_desc() -> dmaengine_submit()
	  xilinx_dma_tx_submit()
		  chan->terminating = false;

  tasklet resumes: `if (chan->terminating) break;` is now false, so the
  loop does desc = next and dereferences freed memory.

That looks like a use-after-free plus list_del() on freed memory inside the
DMA engine.  The comment above shows the cleared terminating flag is known
about, but the terminate/synchronize/terminate runs after the corrupting
iteration.  Would a real quiesce (for example refusing the re-arm under the
same lock that the teardown path takes, or fixing the flag handling in
xilinx_dma_tx_submit()) be the right shape here?  This also still reads the
same way at the end of the series.

[Severity: Medium]
The commit message describes only the RX data path and says nothing about
changing teardown.  Could it mention that ep_free_dma_chan(), which is
shared by TX and RX channels, now issues terminate/synchronize/terminate
instead of a single dmaengine_terminate_sync(), and that the reason is an
internal behaviour of one dmaengine provider (xilinx_dma_tx_submit()
clearing chan->terminating)?  As written, the open-coded triple terminate
becomes silently dead code if that provider is ever fixed, and nobody
touching drivers/dma/xilinx/xilinx_dma.c has a pointer to the dependency.

>  
>  	if (chan->is_tx) {
>  		while (chan->ring_tail != chan->ring_head) {

[ ... ]

> @@ -329,6 +492,12 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
>  		rx_allocated++;
>  	}
>  
> +	for (i = 0; i < ep->num_rx_queues; i++) {
> +		for (j = 0; j < RX_BD_NUM_DEFAULT - 1; j++)
> +			ep_rx_submit_desc(ep->rx_chans[i]);
> +		dma_async_issue_pending(ep->rx_chans[i]->chan);
> +	}
> +
>  	return 0;

[Severity: Medium]
Related to the refill question above: every failure inside
ep_rx_submit_desc() is discarded here and this returns 0, so ep_open() can
report success with an under-filled or completely empty RX ring.  Should
this loop count successful submissions and fail the open when none (or too
few) were armed?

>  
>  err_free_chans:
