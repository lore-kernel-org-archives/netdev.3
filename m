Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712753;
	b=VMBZcbbbQLvtwrDfRUxPY+RYMochuBBdnRyP1Nhd10hCFuajwEIQ+go6HHGbq8MMCab0
	 KUHD4VUhMYuLeTZIlxGzRnwI+ZS9mStCgmEICLdyRBOvuP94/bshi2y1qwBX8HsSCOw8+
	 BLA6QrxMn16Y/fZYE7hgdXBQjQReeFdgolSwyoo5SBM5pSjoimQ06B8sRPXCxl+o7JR6D
	 uOC3oe/7yUfVyCr5BviuDookB8ZF5WVBAqpFm3NjCHDqfXmp4SaWMKJQG78C/gKGOB8fV
	 69EqITKfNmLNbxcNW9Q1EcSNdDZctKKtldvj5u4osFO4FUcnXO5LoTGwk+SdIkOGzsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712753;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3IAjmr/zmbR2S1eHfVi3upxEsNfRTP6Y4OyASEJgk+M=;
	b=YUCe9QN1JgPSEJFsg25ovFx6sSsbX5Mt/LlkDrQu/vyo24h2koNKE7rEHYv81ox1o1ed
	 7vtt+mwGQh4EX2Pbg2mhw280V4CGwe56Ym+kpGsT4DTCYd1xbJQjf8NfvYSNIazcB0lSW
	 svo6REAjNrzPVU5dn6U7sxZw+gw469hEvoLRoUcRgR9mo3CcQrISNatf+hhsGnG/GlTaa
	 lpfHXG59XOM0lmqclX2363Ur4YMW/eJLO/1MAypw0rR7ZlMGp0QpVJh2pv/+lP8lrFPmu
	 IRy4glFRW9fXS5pOwujTYRO0eDliXdk+qrpaWMzkXriMWXz8sGuIpw0FLaOLwseXcgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNQyc3Cc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A5606A338
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNQyc3Cc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C11F0093A;
	Tue,  3 Nov 2026 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712752;
	bh=3IAjmr/zmbR2S1eHfVi3upxEsNfRTP6Y4OyASEJgk+M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GNQyc3CcxIUNXgsvX/Tn85rtouR52rYkKMiuH0jdzYRZYnm3keRcMRKvd5eD2fHkc
	 HA8AF7cR5/as7vbDvrpynszM2sFGT/4x7B5zfkdmCZ9r8oXe1daoMLLVMe+08W/wPb
	 l/Bb8/lE87om8jQx6hyK77rvcIkjObYTFx6YBJQ8FsFoy2xBgFjTFz9K5Dlg3gVIHX
	 ijEM6RO8uoIZ8vaYrVtM9/HU4yYCf6ZDmrj/SOZJVaGADdHQVEVX3TBcNcpRsOvkvY
	 wkJ0SkLflW9Y8se+kjcqJVmu0co1zTerDOchiR65wN7CVP2izeggM8d6UqkBHufezz
	 IWyZ1QnvEP0iA==
Subject:
 Re: [PATCH net 3/9] ice: xsk: fix leaking Rx buffers in multi-buffer path
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com
Date: Tue, 03 Nov 2026 13:32:31 +0000
Message-ID: <179371275153.488856.16170220434241626063@kernel.org>
In-Reply-To: <20261102124950.958345-4-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-4-maciej.fijalkowski@intel.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new zero-length branch in ice_clean_rx_irq_zc()
  (drivers/net/ethernet/intel/ice/ice_xsk.c) is `else if…
- [High] ice: xsk: 0-length buffer assigned to first in
  ice_clean_rx_irq_zc()
- [Medium] As of this commit, if xsk_buff_add_frag() fails in
  ice_clean_rx_irq_zc() because `xdp == first` (aligned-mode duplicate…

Pre-existing issues:
- [Low] When xsk_buff_add_frag() fails on a non-EOP descriptor in
  ice_clean_rx_irq_zc(), `first` is set to NULL and the loop continues.

--

ice: xsk: fix leaking Rx buffers in multi-buffer path

This commit changes ice_clean_rx_irq_zc() to free the xsk buffer of a
zero-length frag. When xsk_buff_add_frag() fails, it now also frees the
current descriptor's buffer in addition to the frame head. It relies on
xp_free() skipping a duplicate buffer that was already freed with the
frame.

> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 0643017541c35..ea8ac0fcdf6ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -618,8 +618,11 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
>  
>  		if (!first) {
>  			first = xdp;
> -		} else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
> +		} else if (unlikely(!size)) {
> +			xsk_buff_free(xdp);

[Severity: High]
Does the zero-length check need to come before the !first check?

With the current ordering, a descriptor with pkt_len 0 is only freed
when a frame is already in progress. If first is NULL, the zero-length
buffer becomes the head of a new frame. If that descriptor is also EOP,
the unlikely(!first) test further down no longer skips it.

One way to get there is the xsk_buff_add_frag() failure path just
below. When xsk_buff_add_frag() fails on a non-EOP descriptor, first is
reset to NULL and the loop moves on. Suppose the next descriptor is the
EOP of the same packet and carries no data. That can happen when the
hardware strips the FCS and the last buffer held only FCS bytes. The
empty buffer is then assigned to first with data_end == data, and
ice_run_xdp_zc() runs on an empty frame.

What happens next depends on the verdict:

- XDP_TX: ice_xmit_xdp_tx_zc() would post a Tx descriptor with a zero
  buffer size and the EOP bit set. E810 may treat that as a malicious
  driver event and stop the queue.

- XDP_PASS: xdp_build_skb_from_zc() builds an skb with len 0, so
  eth_type_trans() has no header to work with. When
  ICE_RX_FLAGS_MULTIDEV is set, ice_process_skb_fields() may also
  __skb_push() ETH_HLEN, which moves skb->data in front of the frame.

- XDP_REDIRECT: the user socket gets a spurious empty descriptor.

libeth_xsk_process_buff() checks the length before anything else:

    if (unlikely(!len)) {
        libeth_xsk_buff_free_slow(xdp);
        return head;
    }

This ordering predates this patch. Since this hunk already adds a
dedicated zero-length branch, would it make sense to test size before
first here?

Then a zero-length buffer would be freed when no frame is in progress,
and first would stay NULL so the descriptor is skipped. There is also
the duplicate fill ring case where xdp aliases first. Given that, the
zero-length branch would presumably still need to avoid freeing the
buffer when it is the current head.

[Severity: High]
Can this free the live head of the frame when xdp == first?

In aligned mode, a duplicate fill ring address maps to the same
pool->heads[] xskb. xsk_buff_add_frag() guards against this explicitly:

    /* Duplicate fill ring entries map to the same xskb in aligned mode */
    if (unlikely(xdp == head || !list_empty(&frag->list_node)))
        return false;

The new zero-size branch has no such check. Suppose the descriptor after
the head comes back with pkt_len 0 and aliases first. Then
xsk_buff_set_size() resets the head's flags, and xsk_buff_free() goes
straight to xp_free(). The head is not on any list, so this:

    void xp_free(struct xdp_buff_xsk *xskb)
    {
        if (!list_empty(&xskb->list_node))
            return;

        xskb->pool->free_list_cnt++;
        list_add(&xskb->list_node, &xskb->pool->free_list);
    }

puts it on pool->free_list while first still points at it.

The frame then either goes on to ice_run_xdp_zc() (TX, REDIRECT or PASS)
or is stashed in rx_ring->xsk. In the same poll,
ice_alloc_rx_bufs_zc()->xp_alloc_batch()->xp_alloc_reused() can take the
buffer off free_list with list_del_init() and post it to the hardware Rx
ring again.

Could the NIC then DMA a later packet into a buffer that is still in use?
That buffer could be the head of the frame being built, sit on the XDP_TX
ring, or be on the user Rx ring.

Also, list_del_init() leaves list_node empty again. A later
xsk_buff_free(first) or XDP_TX completion would then put the buffer back
on free_list while it is still posted to hardware.

The commit message says "xp_free() skips a duplicate already freed with
the frame". Here, though, the duplicate is the live head and has not been
freed yet. Before this patch, the zero-length case did not touch the
buffer.

Would skipping the free when xdp == first avoid this? That would match the
guard in xsk_buff_add_frag(). For comparison, i40e_clean_rx_irq_zc() in
this series does not free a zero-length buffer by itself.

> +		} else if (!xsk_buff_add_frag(first, xdp)) {
>  			xsk_buff_free(first);
> +			xsk_buff_free(xdp);

[Severity: Medium]
Suppose xsk_buff_add_frag() fails because xdp == first, and the head
already has frags attached. Are those frags freed here?

xsk_buff_set_size() has just run on the aliased head:

    xdp->flags = 0;

This clears XDP_FLAGS_HAS_FRAGS, so xsk_buff_free(first) takes the early
exit:

    if (likely(!xdp_buff_has_frags(xdp)))
        goto out;

It then only calls xp_free() on the head. The earlier frags seem to stay
on pool->xskb_list with no owner. They are either lost, or xsk_rcv_zc()
later picks them up as part of another frame. The new zero-size branch
above has the same flag clearing when xdp == first.

This looks to be resolved later in the series by "xsk: do not clear frags
flag when acquiring a buffer". That patch changes xsk_buff_set_size() to
preserve XDP_FLAGS_HAS_FRAGS, and makes xsk_buff_free() clear the flag
after draining.

At this commit, though, the duplicate fill ring case named in the commit
message still strands frag buffers. The stranding also happened before
this patch.

>  			first = NULL;
>  		}

[Severity: Low]
This isn't a bug introduced by this patch, but there is a related
behavior. When xsk_buff_add_frag() fails on a non-EOP descriptor, first is
set to NULL and the loop continues. The next descriptor of the dropped
packet then starts a new frame through:

    if (!first) {
        first = xdp;

So the rest of the dropped frame is assembled and run through XDP as a
standalone packet that starts mid-frame.

The i40e companion patch in this series says this is intended ("Remaining
buffers of this packet, if any, will be processed as a new packet.").

Is that also the intended behavior for ice, rather than discarding
descriptors until EOP?

>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
