Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AF3C7DF5;
	Tue,  1 Sep 2026 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231569; cv=none; b=ec5O7EcFkHIzf+x/rYv1B43cndN1NnT/exNrufqae6oKQJdorC9YTp/WpKQW2u+hQvd6F3ASjZAhEMF/SjmKa5LDZID/JnXE6CKjhuJ08RrzIcGIRtOgEKqYL5nw2Qh4LK3VvZlaGE0OJQBiKzx/SOznekgPTvEUW6MBzjqllSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231569; c=relaxed/simple;
	bh=N4PK4DI6scUEUeaFQBbo1vozkMaf/Zv8esOB6ubpIWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSWNeNnHk+dCAi+N91QTwVfwuLjho3t+GxzoI//W3HtbCxY1wsNgF969FQhSz9DGdEcRb7IsycEWGt7/pF0oDN2zOalZh3jaa5G5LnwxORmonhbZc673sw3Lz3/9f9+DVQIna0WVj+EBDfgDAumYKPqmuuTOuK3XtpeoAHegyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWmR0xjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWmR0xjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158CE1F000E9;
	Tue,  1 Sep 2026 02:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788231566;
	bh=02GbqUzWLLMFr25w99+0O6J/0Q693xHEP7rfxhgeZmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eWmR0xjtbyfdrXybmWCVhMZzSjbs24yF8RU64JmI5SyXKnHBD7/F99jJjWt2SrJwY
	 +Scg1Bn6ZQY/cvyRbqGHyZte9PLQovNHiYQm/Vh6WscYsb3JDxEiyXHL0uY85qN57l
	 iJzOxVqPivkX22VD0ZPeKmUoSaBktLcHNMUH4azOC0q8/S5FQ9ZfFNRnL1N7djweE8
	 jAOkNRI/haAju20ux6Wt3QrxpcDefXCU2QepmWKnR02HrqfjHw33nlYICzTum7dNJ1
	 HiwzGNwr85TdHvhhtWsiRk3HJR1ucig9LurnhI1zs7rdqXbDEg2iAOZ1nA/k9OeUGa
	 pakcyviKKia/w==
From: Jakub Kicinski <kuba@kernel.org>
To: rosenp@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	claudiu.manoil@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Manfred.Rudigier@omicron.at,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: gianfar: fix DMA unmap of time stamped frames at teardown
Date: Mon, 31 Aug 2026 19:59:23 -0700
Message-ID: <20260901025924.1616280-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828212255.46046-1-rosenp@gmail.com>
References: <20260828212255.46046-1-rosenp@gmail.com>
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
net: gianfar: fix DMA unmap of time stamped frames at teardown

This teaches free_skb_tx_queue() that a time stamped frame occupies an
extra TxBD for the time stamp buffer: the head unmap length is derived
from the time stamp BD length plus GMAC_FCB_LEN and GMAC_TXPAL_LEN, and
the time stamp BD is skipped before the fragment loop runs.  The intent
is to mirror what gfar_clean_tx_ring() does on the transmit path.

A couple of questions about the new walk below.

> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index cf636fc5aafa..c5a716d91fd1 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -1064,21 +1064,41 @@ static void free_skb_tx_queue(struct gfar_priv_tx_q *tx_queue)
>  	txbdp = tx_queue->tx_bd_base;
>  
>  	for (i = 0; i < tx_queue->tx_ring_size; i++) {
> -		if (!tx_queue->tx_skbuff[i])
> +		struct sk_buff *skb = tx_queue->tx_skbuff[i];
> +		bool do_tstamp;
> +		int buflen;
> +
> +		if (!skb)
>  			continue;

[Severity: High]
The commit message says the walk is fixed "the same way gfar_clean_tx_ring()
does on the transmit path", but the cursor here is still anchored at
tx_queue->tx_bd_base and it is not advanced when a tx_skbuff[] slot is NULL.
Should it start from tx_queue->dirty_tx / tx_queue->skb_dirtytx like the
reference implementation does?

gfar_clean_tx_ring() anchors both cursors and advances them together:

	bdp = tx_queue->dirty_tx;
	skb_dirtytx = tx_queue->skb_dirtytx;

	while ((skb = tx_queue->tx_skbuff[skb_dirtytx])) {
		...
		skb_dirtytx = (skb_dirtytx + 1) &
			      TX_RING_MOD_MASK(tx_ring_size);
	}

gfar_init_bds() only resets dirty_tx and skb_dirtytx to the ring base at
startup, so at teardown they sit wherever transmit completion left them.
Outstanding frames live in [dirty_tx, cur_tx) with skb indices
[skb_dirtytx, skb_curtx).

Given that, when skb_dirtytx != 0 does the first processed skb get unmapped
using descriptor 0, i.e. a descriptor belonging to an already completed
frame?  gfar_clear_txbd_status() in gianfar.h keeps only the wrap bit and
never clears bufPtr:

	lstatus &= BD_LFLAG(TXBD_WRAP);
	bdp->lstatus = cpu_to_be32(lstatus);

so the dma_unmap_single() below would use a stale bufPtr with length 0, the
fragment loop would then dma_unmap_page() further stale bufPtr values, and
the head plus fragment mappings of the skb actually being freed are never
released.  Is that not the same leak the commit message is trying to remove?

stop_gfar() does netif_tx_stop_all_queues(), set_bit(GFAR_DOWN),
disable_napi(), gfar_halt() and then free_skb_resources(), without draining
the TX ring, so non-NULL tx_skbuff[] entries with live mappings look like the
normal case here - in particular on the
gfar_timeout() -> gfar_reset_task() -> reset_gfar() -> stop_gfar() path.

> +		do_tstamp = (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
> +			    priv->hwts_tx_en;

[Severity: Medium]
Can priv->hwts_tx_en differ here from the value that was in effect when the
frame was enqueued?  gfar_start_xmit() computes the same expression and that
is where the descriptor topology is fixed (frags + 2 BDs, head BD length set
to GMAC_FCB_LEN, time stamp BD length set to skb_headlen(skb) - fcb_len).

gfar_hwtstamp_set() flips the flag with no lock, no WRITE_ONCE, no TX drain
and no reset_gfar() on the tx_type transitions:

	case HWTSTAMP_TX_OFF:
		priv->hwts_tx_en = 0;
		break;
	case HWTSTAMP_TX_ON:
		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
			return -ERANGE;
		priv->hwts_tx_en = 1;
		break;

For the on-to-off direction, if a genuinely time stamped frame is still in
tx_skbuff[] when the flag is cleared, does this take the non-tstamp branch
and unmap only be16_to_cpu(txbdp->length) == GMAC_FCB_LEN bytes of a
skb_headlen()-sized mapping, then dma_unmap_page() the time stamp BD whose
bufPtr is an interior offset of that same single mapping, leaving the real
fragment BDs unvisited?

For the off-to-on direction, an ordinary frame carrying SKBTX_HW_TSTAMP set
by the socket takes the tstamp branch, sizes the head unmap from
txbdp[1].length belonging to another frame, skips one real fragment BD, and
consumes one BD more than the frame occupied.

Would keying this on SKBTX_IN_PROGRESS, which gfar_start_xmit() sets only
when the time stamp BD was actually emitted, or on a recorded per-frame BD
count, keep the teardown view consistent with what was mapped?

reset_gfar() reaches free_skb_resources() from gfar_reset_task, a workqueue
without rtnl, holding only the GFAR_RESETTING bit that the tx_type path of
gfar_hwtstamp_set() does not test, so the flag can also change while this
walk is running.

> +
> +		/* Sending a time stamped frame requires two additional
> +		 * buffers, the time stamp buffer itself being between the
> +		 * FCB and the actual frame data, all mapped together.
> +		 */
> +		if (unlikely(do_tstamp))
> +			buflen = be16_to_cpu(txbdp[1].length) +
> +				 GMAC_FCB_LEN + GMAC_TXPAL_LEN;
> +		else
> +			buflen = be16_to_cpu(txbdp->length);
> +
>  		dma_unmap_single(priv->dev, be32_to_cpu(txbdp->bufPtr),
> -				 be16_to_cpu(txbdp->length), DMA_TO_DEVICE);
> +				 buflen, DMA_TO_DEVICE);
>  		txbdp->lstatus = 0;
> -		for (j = 0; j < skb_shinfo(tx_queue->tx_skbuff[i])->nr_frags;
> -		     j++) {
> +
> +		if (unlikely(do_tstamp))
> +			txbdp++;
> +
> +		for (j = 0; j < skb_shinfo(skb)->nr_frags; j++) {
>  			txbdp++;
>  			dma_unmap_page(priv->dev, be32_to_cpu(txbdp->bufPtr),
>  				       be16_to_cpu(txbdp->length),
>  				       DMA_TO_DEVICE);
>  		}

[Severity: High]
The new txbdp[1] read and the new txbdp++ use plain pointer arithmetic
rather than the ring helpers.  Should these use next_txbd() / skip_txbd()?

	static inline struct txbd8 *next_txbd(struct txbd8 *bdp, struct txbd8 *base,
					      int ring_size)
	{
		return skip_txbd(bdp, 1, base, ring_size);
	}

gfar_start_xmit() and gfar_clean_tx_ring() step the ring exclusively with
those, and gfar_clean_tx_ring() reads the time stamp BD length through
next_txbd() for exactly this case:

		if (unlikely(do_tstamp)) {
			next = next_txbd(bdp, base, tx_ring_size);
			buflen = be16_to_cpu(next->length) +
				 GMAC_FCB_LEN + GMAC_TXPAL_LEN;
		} else
			buflen = be16_to_cpu(bdp->length);

Without wrapping, when the cursor lands on the last entry of the ring does
txbdp[1] read outside this queue's BD array?  gfar_alloc_skb_resources()
places all tx rings and then all rx rings in one dma_alloc_coherent() block:

	vaddr = dma_alloc_coherent(dev,
				   (priv->total_tx_ring_size *
				    sizeof(struct txbd8)) +
				   (priv->total_rx_ring_size *
				    sizeof(struct rxbd8)),

so the length would come from the adjacent tx ring or from an RxBD whose
length field is written by hardware, and that value is then handed to
dma_unmap_single() / dma_unmap_page().

Both of these look reachable from ordinary teardown - ip link set dev ethX
down, an MTU change, an ethtool ring resize, or the tx-timeout reset path.

Thanks for looking at this code; the time stamp BD handling was clearly
missing here.
-- 
pw-bot: cr
