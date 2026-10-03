Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AE376A13;
	Sat,  3 Oct 2026 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791016665; cv=none; b=oysr/p2PyxCa8cTbRVqbYOtLISvtqx/ORYXJAhJs29QuMao59KLzT1ZersKJAT+j3/n/4dFK+F1FzWTQ1M3KmY2wiy8FP3lUSTiV6vjW/dOmVF5Cx0REOrWplOnWblsg4DdFwIWf07vqGpja+gHQ8MBn8XYLu2ULZCjHDHr+L2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791016665; c=relaxed/simple;
	bh=vS0AkYZt/0/cKPj0347fBsR1ft6eButOwQ81CD0wzUk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z+YBSwyNFRFmmZ79LzWpnhxJL095dyAOD70KEYNvJgP43aRBg3GgFa/bHPihGqU+LOxm0m+fm9xOu/uTzlGNh0ZrUDnFIileLFO3ABJkGUIyOSIvz08ktVmwllAROVzvAFMkxBsVN+FZgQfpjoSyxKOlaJhrWpzahSIvmDdYsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypibnm9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypibnm9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27D31F0089B;
	Sat,  3 Oct 2026 08:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791016663;
	bh=N3fh9wDM3CPmoVmZAzNCOZdAv3wepqAsjEAIC78fLEM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ypibnm9sdse4LPX26ADJTPSuI6B8vpXoq8HPPeqLJpd5bsOamCn4WSZY12nDqaxSW
	 9kriaolqQpGHaFPFFWyacEQeYPmup+wRv1BPxaCdWvWH0SJhvj85KJZu3Nw3o3LYnV
	 Ngx/1vXsclWi6RiRpdBQ26jofDcOba2QHqe/a1qeh4jrsVpd/ax+8vVE9uzwqLsbIW
	 T5xfTlpKxg0VdDDNyxFKchXsBnNcgW6tMsN0Ze4z9bgaMI8OBUWhWT+wIOCv1kxC7g
	 jyDPyUlUtJ0u1pUnN3Zf5/xkU5WGJjLz9RPUVjrvGT+AQQzYxZWbz1wI3b1+ug3yob
	 8011irU+S52rg==
Subject: Re: [PATCH net-next] net: xilinx: axienet: Derive RX frame length
 from residue in dmaengine path
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
Date: Sat, 03 Oct 2026 08:37:42 +0000
Message-ID: <179101666253.434549.6997219153038627116@kernel.org>
In-Reply-To: <20260929081316.803997-1-srinivas.neeli@amd.com>
References: <20260929081316.803997-1-srinivas.neeli@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 1 (3) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In direct (non-SG) AXI DMA mode, the new residue-based length
  makes axienet_dma_rx_cb() deliver RX buffers that the hardware never…
- [High] On MCDMA, which the cover note names as the target of this
  change, the residue-based path accepts successful completions for…
- [High] The commit message says the residue approach is correct
  'including multi-descriptor frames where the residue is summed over…
- [High] The residue-based length cannot tell a complete frame from a
  truncated chunk of an oversized one.
- [Medium] axienet_dma_rx_cb() computes rx_len = lp->max_frm_size -
  result->residue and feeds it straight into skb_put() and…
- [Low] The patch has no Fixes: tag and targets net-next, but its commit
  message describes a user-visible failure of existing code: 'On designs…
- [Low] The commit message describes the old failure only as an 'invalid'
  length.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but RX can stop
  permanently after refill failures.
- [Medium] This problem wasn't introduced by this patch, but
  axienet_rx_submit_desc() advances lp->rx_ring_head before…
- [Medium] This problem wasn't introduced by this patch, but
  axienet_stop() leaks the outstanding RX skbs and their streaming DMA…

--

net: xilinx: axienet: Derive RX frame length from residue in dmaengine path

This patch changes how the axienet dmaengine RX callback gets the frame
length. It now uses the posted buffer length minus the dmaengine residue
instead of the APP metadata words. Failed transfers are detected from
dmaengine_result.result, and the unused LEN_APP macro is removed.

> The dmaengine RX path derived the received frame length from the descriptor
> APP metadata. That only works when the optional AXI4-Stream status/control
> interface is present, because the hardware populates the APP fields solely
> when that interface is enabled. On designs without it the length read back
> is invalid.

[Severity: Low]
This describes a failure users can see in existing code. The patch has no
Fixes: tag and is aimed at net-next. Should it carry a Fixes: tag?

The APP word length read that this patch replaces:

    rx_len = (app_metadata[LEN_APP] & 0xFFFF);

came in with commit 6a91b846af85 ("net: axienet: Introduce dmaengine
support"). xilinx_dma has populated the SG residue that the new code
relies on since d8bae21a48dbe1.

If such designs were never considered supported, could the message
describe this as enabling new hardware configurations instead of fixing
invalid behaviour? In either case, the RX length questions below would
probably need to be settled before this is suitable for stable.

[Severity: Low]
Is "the length read back is invalid" accurate for the main target
configurations?

xilinx_dma only installs metadata_ops when xdev->has_axistream_connected
is set. That comes from the "xlnx,axistream-connected" DT property, which
is only parsed for AXIDMA. xilinx_mcdma_prep_slave_sg() never sets
metadata_ops.

In those cases dmaengine_desc_get_metadata_ptr() returns an ERR_PTR. The
old callback then dropped every RX frame with "Failed to get RX metadata
pointer". Before 8bbceba7dc5090 it dereferenced the ERR_PTR instead.

Could the message mention that symptom? It could also say that the RX
path no longer needs a metadata-capable DMA channel.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 782f903d318f3..e7490650482bb 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c

[ ... ]

> @@ -1159,29 +1158,26 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  {

[ ... ]

>  	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
>  	skb = skbuf_dma->skb;
> -	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
> -						       &meta_max_len);
>  	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>  			 DMA_FROM_DEVICE);
>  
> -	if (IS_ERR(app_metadata)) {
> +	if (result->result != DMA_TRANS_NOERROR) {

[Severity: High]
With the metadata check gone, this is the only validation left. Can MCDMA
report DMA_TRANS_NOERROR here for RX descriptors the hardware has not
finished?

xilinx_dma_complete_descriptor() only checks the BD completion bit for
AXI DMA:

    if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
        ... XILINX_DMA_BD_COMP_MASK ...
    }

So on MCDMA, every IOC interrupt retires the whole active_list.

Since commit 60786900347901, xilinx_mcdma_start_transfer() extends the
running chain on every refill. It sets the coalesce threshold from
desc_pendingcount:

    if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
        reg &= ~XILINX_MCDMA_COALESCE_MASK;
        reg |= chan->desc_pendingcount << XILINX_MCDMA_COALESCE_SHIFT;

That count only covers the newly pending batch, which is 1 per refill.
The initial batch of 128 is above XILINX_MCDMA_COALESCE_MAX, so the
threshold is not reprogrammed at all. An IOC after a single packet would
then retire every outstanding RX descriptor.

The hardware never wrote the status of those descriptors, so
xilinx_dma_get_residue() returns the full control length. This callback
then computes rx_len = 0 and passes a zero-length skb to eth_type_trans()
and __netif_rx().

At the same time, xilinx_dma recycles those segments while the hardware
still owns the chain (xilinx_mcdma_clean_hw_desc() memsets the BD). The
hardware can then DMA into buffers that this callback has already
unmapped and handed to the stack. That ownership part predates this
patch, because the old IS_ERR path also freed the skb.

MCDMA is the configuration this change targets. Does the provider need to
validate completion per descriptor before the residue can be trusted
here?

>  		if (net_ratelimit())
> -			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
> +			netdev_err(lp->ndev, "RX DMA transfer failed\n");

[ ... ]

> -	/* TODO: Derive app word index programmatically */
> -	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
> +	/* Actual length = posted buffer length - residue. */
> +	rx_len = lp->max_frm_size - result->residue;
>  	skb_put(skb, rx_len);
>  	skb->protocol = eth_type_trans(skb, lp->ndev);

[Severity: High]
In direct (non-SG) AXI DMA mode, does this hand RX buffers to the stack
that the hardware never wrote?

axienet_init_dmaengine() queues RX_BUF_NUM_DEFAULT (128) descriptors and
calls dma_async_issue_pending() once. In direct mode,
xilinx_dma_start_transfer() programs only the first descriptor, but moves
all 128 to active_list:

    dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
                   hw->control & chan->xdev->max_buffer_len);
    ...
    list_splice_tail_init(&chan->pending_list, &chan->active_list);

When that one transfer completes, xilinx_dma_complete_descriptor()
retires every active descriptor. Without SG, nothing stops the loop:

    if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
        break;

Each descriptor gets the same residue from
xilinx_dma_get_residue_axidma_direct_s2mm(), which is hw->control minus
BTT. With equal-sized buffers, every callback computes rx_len equal to
the first packet's length.

The other skbs came from netdev_alloc_skb() and were never initialized.
skb_put(), eth_type_trans() and __netif_rx() would still pass them up as
packets. Before this patch, the metadata check dropped them via IS_ERR or
gave them rx_len 0.

xilinx_dma supports this mode explicitly (5c9142a8063f71,
60786900347901), and axienet does not reject it. Is "correct across all
designs" in the commit message accurate for this configuration?

[Severity: High]
The commit message says this is correct "including multi-descriptor
frames where the residue is summed over the chain". Does that hold when
one posted RX buffer is split across several hardware BDs?

axienet_rx_submit_desc() posts a single sg entry of lp->max_frm_size.
xilinx_dma_prep_slave_sg() splits it into segments of at most
max_buffer_len:

    copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg), sg_used);

That split happens whenever max_buffer_len (from xlnx,sg-length-width) is
smaller than max_frm_size. Examples are a width of 10 or less with a 1522
byte buffer, or 13 or less with a 9022 byte jumbo buffer.

S2MM closes a BD on TLAST and starts the next frame in the next BD. A
short frame that ends in BD0 can therefore be followed by the next frame
in BD1 of the same descriptor. xilinx_dma_get_residue() just adds up the
per-segment values:

    residue += (axidma_hw->control & chan->xdev->max_buffer_len) -
               (axidma_hw->status & chan->xdev->max_buffer_len);

Take a 1023/499 split and a 500 byte frame. rx_len here comes out as 999.
skb_put() then covers 499 bytes of the unwritten tail of BD0, which is
stale netdev_alloc_skb() memory, followed by the start of the next frame.
That next frame is itself truncated.

Could this leak uninitialized heap contents to AF_PACKET users, or onto
the wire when the port is bridged?

[Severity: High]
How does this tell a complete frame apart from a chunk of an oversized
frame?

For MTU > 1500, axienet_device_reset() enables jumbo receive but sizes
the RX buffer to the local MTU:

    if (ndev->mtu > XAE_MTU && ndev->mtu <= XAE_JUMBO_MTU) {
        lp->max_frm_size = ndev->mtu + VLAN_ETH_HLEN + XAE_TRL_SIZE;
        if (lp->max_frm_size <= lp->rxmem)
            lp->options |= XAE_OPTION_JUMBO;

No receive max-frame limit is programmed. The MAC therefore accepts
frames longer than one posted buffer, up to rxmem.

S2MM then carries such a frame into the BDs of the following descriptors.
Each of those completes with DMA_TRANS_NOERROR. The first has residue 0,
and the later ones hold the remainder.

Only result->result is checked, so each chunk is delivered as its own
frame. eth_type_trans() parses the start of each continuation chunk as a
new Ethernet header.

Can a sender on the link hide an inner frame in the tail of a jumbo frame
and have it processed as if it had arrived directly? That would bypass
MAC address filtering, as well as any VLAN or ACL decision an upstream
switch made on the outer frame.

Before this patch, the last chunk's app4 value (the full frame length)
reached skb_put() and panicked. Now the chunks are delivered silently.
Should full buffers, or chunks that do not start a frame, be dropped
here?

[Severity: Medium]
Should rx_len be checked against [ETH_HLEN, max_frm_size] before
skb_put() and eth_type_trans()?

This code also assumes the residue always covers the full posted length.
In direct S2MM mode with max_buffer_len < max_frm_size,
xilinx_dma_start_transfer() only programs the first segment, and the
residue covers only that segment:

    seg = list_first_entry(&desc->segments, ...);
    hw = &seg->hw;
    return hw->control - finished_len;

rx_len then works out to BTT + (max_frm_size - first_seg_len), which
includes the never-written tail of the netdev_alloc_skb() buffer.

When residue == max_frm_size, as in the MCDMA and direct mode cases
above, rx_len is 0. eth_type_trans() then fails to pull the MAC header
and reads h_proto from unwritten bytes.

A residue larger than max_frm_size would wrap and hit skb_over_panic().
That has not been shown to be reachable with correctly behaving
hardware.

[ ... ]

[Severity: Medium]
This isn't a bug introduced by this patch, but can RX stop for good after
refill failures?

axienet_rx_submit_desc() returns without posting anything when
netdev_alloc_skb(), dma_map_single() or dmaengine_prep_slave_sg() fails:

    skb = netdev_alloc_skb(ndev, lp->max_frm_size);
    if (!skb)
        return;

After init, the only refill point is the loop at the end of
axienet_dma_rx_cb():

    for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
                               RX_BUF_NUM_DEFAULT); i++)
        axienet_rx_submit_desc(lp->ndev);

Suppose allocation keeps failing until every outstanding descriptor has
completed. Then no further callback runs and nothing retries, so RX stays
dead until the interface is brought down and up again.

[Severity: Medium]
This is a pre-existing issue, but axienet_rx_submit_desc() advances the
ring head before submitting, and it ignores the returned cookie:

    lp->rx_ring_head++;
    dmaengine_submit(dma_rx_desc);

xilinx_dma_tx_submit() can fail without queuing the descriptor:

    if (chan->err) {
        err = xilinx_dma_chan_reset(chan);
        if (err < 0)
            return err;
    }

axienet_dma_rx_cb() matches completions only by incrementing
rx_ring_tail. Would a later successful completion then be paired with the
wrong skb and DMA mapping?

[Severity: Medium]
This isn't a bug introduced by this patch, but does axienet_stop() leak
the outstanding RX skbs and their DMA mappings in dmaengine mode?

dmaengine_terminate_sync(lp->rx_chan) ends up in
xilinx_dma_free_descriptors(). That frees the descriptor lists without
calling the client callbacks. axienet_stop() then frees only the
wrappers:

    for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
        kfree(lp->rx_skb_ring[i]);
    kfree(lp->rx_skb_ring);

It never calls dma_unmap_single() or dev_kfree_skb() for the skbs posted
between rx_ring_tail and rx_ring_head. Each ifdown can leak up to 128
max_frm_size skbs and their mappings.

This patch does not change that, because the old IS_ERR path also
refilled the ring.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929081316.803997-1-srinivas.neeli%40amd.com
