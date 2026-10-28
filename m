Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231566;
	b=l1AUhy/0sNWCGPwmr8J7t6GHL4IWIXZljRAhNzW0kHxqAwY2nRDw1RAU/kh1av2QzxF5
	 p6uFlY7OyphocR+OgpsbflKcZ8qmyNEeC5D37t1WtN55WpsLQ7SVFoEST9jcwZT7bhyN5
	 6yK8vOTTfYeCucRfqhBUIr/nD17y0K2x0WLzbpLLv0k5mPFfdITdA9QSDSbXy6SmPy81/
	 GIcp72itwt0SqKFYfCuS8NatBZFii+GxYiI8pvscsRHD4EgBBbx6g3LOsHM+5C8hKiZJX
	 owr2tONyUES+z7QOGV6xUBudiKZ2hukWe5aZbhT5H04gWU3cbQ7r0s7TZOvB4YAdO7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231566;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vokIoT9Bk/PARKkrkH9H82xz2Z57SKCL3DuI9iJhxDg=;
	b=L5Wk92Nkv0Ocwi+i8ddznpEcGlFnfIuns2UyGX9zWNKi9sZpjTFm0AEqxFjRzNS/uPyB
	 vgKoDJt/gjTP8JEri/kB/g8D7QHwP1qhVM6dAlPiGkGYUuPs4PWQVJA+EZ8a7OypGbPR1
	 KKZIGKq4Y/8M7X/31UHqqfz8m3SuoVXzHz2fm5gsvMjBn/5g7Lk642ALpH6vUMSuPPXmB
	 BISRo/zkx1wnfNvtV0efGMsPhBx0+SJ7J+cpP3MRtjbl8hQrfIfEgoQlezGkHLw7DS8O8
	 vh9feqbPVqajV3ULYhnx/LoCK/WLd4GFMeyUoGX3uUirBiMOv5NcUj3pH1bunMRhDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfYJRKEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBED606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfYJRKEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2EB1F01825;
	Wed, 28 Oct 2026 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231565;
	bh=vokIoT9Bk/PARKkrkH9H82xz2Z57SKCL3DuI9iJhxDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CfYJRKEMVmkIvkzvfjX5be6XgLqx69gKDFsNBI3M++NLJUDSLD2i5jZxoS3PvdBW0
	 Dk/52bLq5cd+KWio6Fk8mN0LVsQMa5FGbVZt+HXk42oCtJSu6FaWzP0r4I60hC1t4c
	 7+E77ufx9oOOsplW0cHQZGud7hSggHOLSUc8nvADUxHm0cadNqUwJ+qaQu7mOuAHrM
	 ba3484i34ztPcXoszQ4u9hwxJpHGfqgUXSgy59B6ON7xUKRiNFLyLjHsrgU3XlK8ww
	 kPYNoK0SEt+YeZM58sKbKtdzOVJs5yG7Xq+c0PXLCYbN3s9+EUndctUtF2q15gZkMd
	 FfNNlFpQYYTww==
Subject: Re: [PATCH net 1/5] eth: bnxt: recycle agg buffers when Rx head
 buffer allocation fails
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com,
 prashant@broadcom.com, huangjw@broadcom.com, gospo@broadcom.com,
 brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to
Date: Wed, 28 Oct 2026 23:52:43 +0000
Message-ID: <179323156398.3134.2862221492750758183@kernel.org>
In-Reply-To: <20261027234940.1267225-2-kuba@kernel.org>
References: <20261027234940.1267225-2-kuba@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] bnxt_rx_multi_page_skb() now re-posts the head page to the device
  without dma_sync_single_for_device() when napi_build_skb() fails.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  a new consumer of it.
- [Medium] At this commit, the XDP multi-buffer path in bnxt_rx_pkt()
  still leaks buffers when bnxt_rx_agg_netmems_xdp() fails partway.

--

eth: bnxt: recycle agg buffers when Rx head buffer allocation fails

This commit adds an oom_next_rx_agg label to bnxt_rx_pkt(). When the
rx_skb_func() head buffer allocation fails, the label returns the
aggregation buffers to the agg ring, or frees the XDP frags, the same way
the copybreak failure path already does. In bnxt_rx_multi_page_skb(), a
napi_build_skb() failure now releases the newly allocated replacement
buffer and puts the original head page back on the ring, so the XDP frags
in its shinfo are still there for the caller's cleanup.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0682060b048ce..2e7276801fddc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1215,7 +1215,15 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
>  				bp->rx_dir);
>  	skb = napi_build_skb(frag_start, rxr->rx_page_size);
>  	if (!skb) {
> -		page_pool_recycle_direct(rxr->page_pool, page);
> +		struct page *new_page;
> +
> +		new_page = rxr->rx_buf_ring[RING_RX(bp, prod)].data;
> +		/* The caller may still need the XDP frags from shinfo at the
> +		 * end of the head page. Release the new buffer instead and
> +		 * put the head back on the ring.
> +		 */

[Severity: High]
This is a pre-existing issue, not one this patch introduced. It goes back
to 4c6c123c9af9, but this comment relies on it: can the frags in shinfo
still be trusted at this point when DMA goes through swiotlb, or on
non-coherent systems?

In XDP multi-buffer mode, bnxt_xdp_buff_init() syncs only the packet
payload for the CPU:

bnxt_xdp_buff_init()
    dma_sync_single_for_cpu(&pdev->dev, mapping + offset, len, bp->rx_dir);

bnxt_rx_agg_netmems_xdp()->__bnxt_rx_agg_netmems() then writes
shinfo->frags[] and nr_frags at the end of the head page, while that
region is still owned by the device.

Afterwards, bnxt_rx_multi_page_skb() syncs the whole buffer, including
the shinfo:

    dma_addr -= bp->rx_dma_offset;
    dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
                            bp->rx_dir);

rx_dir is DMA_BIDIRECTIONAL here, so __swiotlb_sync_single_for_cpu()
copies the bounce buffer back over the original page. In page mode the
device never writes the shinfo area of the bounce buffer. The frags the
CPU just wrote could therefore be overwritten with stale frags from an
earlier packet. On non-coherent systems, a cache invalidate could drop
them in the same way.

With this patch, the napi_build_skb() failure path continues to
oom_next_rx_agg->bnxt_xdp_buff_frags_free(), which calls
page_pool_recycle_direct() on every page listed in that shinfo. Could
that recycle pages still owned by earlier skbs, while the frags that were
actually received leak?

The success path reads the same data through
bnxt_xdp_build_skb()->xdp_update_skb_frags_info().

Would it work to sync only the range the device wrote, or to do the
full-page sync before the frags are written into shinfo?

> +		page_pool_recycle_direct(rxr->page_pool, new_page);
> +		bnxt_reuse_rx_data(rxr, cons, data);

[Severity: Low]
Does the head page need a dma_sync_single_for_device() before it goes
back on the ring?

The whole buffer was synced for the CPU just above. The old
page_pool_recycle_direct() call synced the page for the device, because
the pool is created with PP_FLAG_DMA_SYNC_DEV. bnxt_reuse_rx_data() only
copies the old DMA address into the producer BD, so that sync no longer
happens.

The CPU also keeps writing to the head page after it has been re-posted.
On the oom_next_rx_agg path, bnxt_xdp_buff_frags_free() sets
shinfo->nr_frags = 0.

For comparison, bnxt_copy_data() pairs both syncs before bnxt_rx_pkt()
reuses the head:

    dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copybreak,
                            bp->rx_dir);

    memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
           len + NET_IP_ALIGN);

    dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copybreak,
                               bp->rx_dir);

The XDP_DROP and XDP_TX ring-full branches in bnxt_rx_xdp() already reuse
the head without a sync for the device, so the new code matches them. It
does drop a sync that the old path did, though.

>  		return NULL;
>  	}
>  	skb_mark_for_recycle(skb);

[ ... ]

> @@ -2424,6 +2423,14 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  
>  	return rc;
>  
> +oom_next_rx_agg:
> +	if (agg_bufs) {
> +		if (!xdp_active)
> +			bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
> +					       false);
> +		else
> +			bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the new label doesn't
cover a partial failure inside bnxt_rx_agg_netmems_xdp(). Are frags
0..i-1 leaked in that case?

If bnxt_alloc_rx_netmem() fails at index i > 0, __bnxt_rx_agg_netmems()
has already put frags 0..i-1 into the head page's shinfo and refilled
their agg ring slots. It then reposts only entries i..agg_bufs-1 and
returns 0:

    --shinfo->nr_frags;
    cons_rx_buf->netmem = netmem;
    ...
    rxr->rx_agg_prod = prod;
    bnxt_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i, tpa);
    return 0;

bnxt_rx_agg_netmems_xdp() sets the frags flag only when total_frag_len
is non-zero:

    if (total_frag_len) {
        xdp_buff_set_frags_flag(xdp);
        shinfo->nr_frags = agg_bufs;
        shinfo->xdp_frags_size = total_frag_len;
    }

So bnxt_xdp_buff_frags_free() would skip these frags even if it were
called. At this revision, bnxt_rx_pkt() also doesn't put the head buffer
back on the ring:

    if (!frag_len)
        goto oom_next_rx;

A later commit in this series, "eth: bnxt: don't leak buffers when XDP
agg buffer allocation fails", appears to fix this. It sets the frags
flag before the loop, frees the frags when total_frag_len is 0, and adds
bnxt_reuse_rx_data() before goto oom_next_rx. With that commit applied,
the end state of the series no longer has this problem.

>  oom_next_rx:
>  	cpr->sw_stats->rx.rx_oom_discards += 1;
>  	rc = -ENOMEM;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027234940.1267225-1-kuba%40kernel.org
