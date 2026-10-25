Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962182;
	b=H7sFENLKsARUbEE/XTf8f2pwtaeGMRQ6vu8P6pftUKP/ro1Pb50FSmEBzND9zTVZuTKt
	 NXFRCvwaI4g81AdAtCF1jcK1MuJw9MIWz6W8GDoTNGEH3mHRJNkyYhGzCvylOaoZmomVI
	 JXtfOki98pVIkw32wuValHZGsjeJxvuLRrjNGBmY3m0YVUOJXsXntbce7/x5D1zI4jZ9y
	 8H9kzkMb+W18HyFzdVGfGEzM0YG2mcrTwwMaYNNx+S3qHURoWHcdau4GtMgm31KGJqVdr
	 PXxvgBA7sMoDVZAifQ3cB0OjtVRQO5U40wVFjJLYDSYX8C3hr0JaSxVL5PMQj0Dau6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962182;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Sjbp1arTrwlF4+Xkno80p7a7yfoZzwzDofI+XHoK+hQ=;
	b=JhoUB/qiY70DFHW9PhBUeAs8HJ1aVa5RsTY1FqkDTRSEZKhRvDqO+HnnZOeokNuVRshV
	 d3/0tU0vb8JbQF9pfhy6UfnRFrSWPSZlTjo8U8FjOYgwyra5vTMX98Uf9hGs11x2R0Vco
	 X14+xfDCEDahCbxPboQqAkmZKDV5pkhO47mMFRGH2D3p6yxo0SSf6111TEgIcZdVb3Gfw
	 wejLgeYzCi9jmv5txEdwCoytom8L1cz8yON6n0opvapsKVLccZoa5YcdA/k9zQ0HHzj4K
	 2sRunAbieMWIjywe11y13Fk4NV8H9Qf9ZiN81OmibAY8ld32k2AV+LFA8CicVbkbYVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5fFSGkO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B55606A31F;
	Sun, 25 Oct 2026 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5fFSGkO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BCB1F01829;
	Sun, 25 Oct 2026 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792962181;
	bh=Sjbp1arTrwlF4+Xkno80p7a7yfoZzwzDofI+XHoK+hQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I5fFSGkO+VDez7Q53zfyQPt8hdXjSc4nSJT6KVCgPe8+fM1xJciBZNfaKaXxLo0o6
	 Zs0KH5r58AezOTkOt6jvJT+ueBT8RmxFxuR8jvCmTK1RfVxSUlBdSAcsX+hFQGmrqL
	 FMC3y2emcH4L2VgpvmBniBjdFDaxV0mkfejjAhSNlNP15e4TBnM1Hvy5VEulSjMGup
	 kZnRId2bumCt/gb2Nma4rHjLS/ygvY+FXIAQoM0B9Hy+XPf5WIAQod8XV6OsL5fgue
	 GyD653FkjOU8vrT9vVbCNPK7T96BCmjDzG8/8r8rfbsdg/o5OWmfyVjlnCYz5A8SVb
	 CHunxE8e14s1A==
Subject: Re: [PATCH net v2] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 21:03:00 +0000
Message-ID: <179296218017.3134.5170259489302207876@kernel.org>
In-Reply-To: <20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd@tipi-net.de>
References: <20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd@tipi-net.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only partly covers its target.
- [Low] When skb_ensure_writable() fails, the new drop path in
  otx2_sq_append_skb() (otx2_txrx.c:1211-1213) frees the skb with…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but it is the
  same class of bug (the transmit path using a freed skb) in the code…
- [High] This problem wasn't introduced by this patch, but it comes from
  the commit being fixed (195c3d463181), and the patch neither fixes nor…

--

octeontx2-pf: fix skb use-after-free with ipsec crypto offload

This commit removes the skb_unshare() call from otx2_dma_map_skb_frag().
That call freed the caller's skb when it was cloned. The commit instead
calls skb_ensure_writable() in otx2_sq_append_skb() for xfrm offload skbs
that are cloned or have shared frags.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index b11389a841d1..91ebf247f5f9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -2121,10 +2121,8 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
>  	int offset;
>  
>  	/* Crypto hardware need write permission for ipsec crypto offload */
> -	if (unlikely(xfrm_offload(skb))) {
> +	if (unlikely(xfrm_offload(skb)))
>  		dir = DMA_BIDIRECTIONAL;
> -		skb = skb_unshare(skb, GFP_ATOMIC);
> -	}

[Severity: High]
This is a pre-existing issue from the commit being fixed (195c3d463181).
It was not introduced by this patch.

The unmap side of this direction logic reads sg->skb without checking it.
In otx2_dma_unmap_skb_frags():

	skb = (struct sk_buff *)sg->skb;
	if (unlikely(xfrm_offload(skb)))
		dir = DMA_BIDIRECTIONAL;

On the DMA mapping error paths, sg->skb has not been set yet.
otx2_sqe_add_sg() returns before assigning it:

	dma_addr = otx2_dma_map_skb_frag(pfvf, skb, seg, &len);
	if (dma_mapping_error(pfvf->dev, dma_addr))
		return false;
	...
	sq->sg[sq->head].skb = (u64)skb;

After that, otx2_sq_append_skb() calls
otx2_dma_unmap_skb_frags(pfvf, &sq->sg[sq->head]).

otx2_sqe_add_sg_ipsec() returns the same way. The unmap label in
otx2_dma_map_tso_skb() works on sq->sg[first_sqe], whose skb is only
assigned after the last segment.

The completion paths reset sg->skb to NULL after each packet. On a
CONFIG_XFRM kernel, can a DMA mapping failure make
xfrm_offload(NULL)->skb_sec_path()->skb_ext_find() dereference NULL? This
applies to non-IPsec traffic too. After the cn10k_ipsec_transmit() drop
path, sg->skb could also be a stale pointer to a freed skb.

Would it work to pass the direction or the skb in explicitly, or to set
sg->skb before mapping?

>  
>  	/* First segment is always skb->data */
>  	if (!seg) {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 8d2d607bc92f..b98842c7e40e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1205,6 +1205,14 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
>  	if (free_desc < otx2_get_sqe_count(pfvf, skb))
>  		return false;
>  
> +	/* Crypto hardware need write permission for ipsec crypto offload */
> +	if (unlikely(xfrm_offload(skb)) &&
> +	    (skb_cloned(skb) || skb_has_shared_frag(skb)) &&
> +	    skb_ensure_writable(skb, skb->len)) {

[Severity: High]
Does this condition catch every frag that the hardware will overwrite?
The commit message says:

  Also do this for skbs with shared frags, as the hardware writes the
  encrypted data back into them.

skb_has_shared_frag() only tests SKBFL_SHARED_FRAG. That flag is set for
splice, MSG_SPLICE_PAGES and zerocopy. It is not set when frag pages are
shared through ordinary page references.

cn10k_ipsec_init() advertises NETIF_F_HW_ESP but not NETIF_F_GSO_ESP:

	netdev->hw_features |= NETIF_F_HW_ESP;
	netdev->hw_enc_features |= NETIF_F_HW_ESP;

So TCP GSO over an offloaded SA is segmented in software:

validate_xmit_skb()
  esp4_gso_segment()
    tcp_gso_segment()
      skb_segment()

skb_segment() gives each segment a fresh, non-cloned head. It takes page
references on the same frag pages that the TCP retransmit queue skb still
holds. It only inherits the flag:

	skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
				    skb_shinfo(frag_skb)->flags) &
				   SKBFL_SHARED_FRAG;

Plain tcp_sendmsg() data doesn't carry that flag. esp_output_head() then
takes its !skb_cloned() path and appends a trailer frag. The original
frags stay in place.

Such a segment fails both skb_cloned() and skb_has_shared_frag(), so
skb_ensure_writable() is skipped. otx2_sqe_add_sg_ipsec() then maps the
frag pages DMA_BIDIRECTIONAL, and cn10k_ipsec_transmit() does:

	inst.rptr = inst.dptr;

That means CPT writes ciphertext into pages TCP still considers
plaintext.

On a later retransmission, would TCP send that ciphertext as payload? The
TCP checksum is recomputed in software during skb_segment(), so the peer
would accept the corrupted data.

The core stack treats these frags as read-only. skb_cow_data() says
"pages are considered not writable at the moment even if they are
anonymous". Software ESP sets esp->inplace = false for nonlinear non-cloned
skbs.

The old skb_unshare() code had the same gap. Should the check be
skb_cloned(skb) || skb_is_nonlinear(skb) instead, or should the driver use
a separate output buffer, rather than relying on SKBFL_SHARED_FRAG?

> +		dev_kfree_skb_any(skb);
> +		return true;
> +	}

[Severity: Low]
When skb_ensure_writable() fails, the skb is freed and true is returned,
but no drop counter is incremented. otx2_xmit() counts its own drops:

	atomic_long_inc(&dev_stats->tx_discards);
	dev_kfree_skb(skb);
	return NETDEV_TX_OK;

Should this new path bump tx_discards too, so the drop shows up in
tx_dropped? The existing __skb_linearize() failure path in this function
has the same gap.

> +
>  	num_segs = skb_shinfo(skb)->nr_frags + 1;
>  
>  	/* If SKB doesn't fit in a single SQE, linearize it.

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch. Every
xfrm offload skb that passes the new check ends up in
cn10k_ipsec_transmit(), which can use a freed skb in a similar way:

cn10k_ipsec_transmit() {
	...
	sa_info = (struct qmem *)x->xso.offload_handle;
	if (!sa_info)
		goto drop;
	...
drop:
	dev_kfree_skb_any(skb);
	return false;
}

otx2_sq_append_skb() passes that false straight back, and otx2_xmit()
treats it as a full ring:

	if (!otx2_sq_append_skb(pf, txq, sq, skb, qidx)) {
		netif_tx_stop_queue(txq);
		...
		return NETDEV_TX_BUSY;
	}

Can the core then requeue and retransmit the skb that was already freed?
The VF and representor xmit handlers do the same.

This drop path looks reachable during SA deletion or rekey under traffic.
cn10k_ipsec_del_state() does:

	x->xso.offload_handle = 0;

Packets already queued with a sec_path reference to that state still
reach the driver. Clearing OTX2_FLAG_IPSEC_OFFLOAD_ENABLED in
cn10k_outb_cpt_clean() leads to the same label.

The DMA mappings that otx2_sqe_add_sg_ipsec() set up in sq->sg[sq->head]
are not unmapped on this path either. The next xmit resets num_segs for
that slot. Are those IOMMU mappings leaked?

Should the drop path unmap sq->sg[sq->head] and return true once the skb
is freed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd%40tipi-net.de
