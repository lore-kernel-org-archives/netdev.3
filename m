Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066910;
	b=imn8HYA/eAqnwnlb1OUvoG4iu1XHHJ9DYhvIeeF//jSkgoaQ0TlYmYyJai2xH2tsmBTs
	 Bag8xdSGHYdbBar+HNOfG8cyqxfWWutgNaTQeMcc3tovUd8OCAedaYiUnE7CJd1+q5mDH
	 c3SBQ0hxE2cz8+oSD2dAHOe3Zl5Snu0VjZtaNfTs5spPCW8/PDpiGMlwQ6JfdlfZ3Vw10
	 BCSOpi5KEjOL6+uCG7fHj6/0hTSZFPIPyFqFGh9Teg1auO/bghx0z9D3td78pP62mlrTS
	 APQZTLrtFAQYxJqKLpwidKZRy6oQwbmz2xTYC32jgF497HUeoa3ZmkOkcddNgGvx0yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066910;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oTlatxiVv9UYZ/odweCxyDE3oqTZzP4Eh9sjjXrDe2Q=;
	b=iRSL8N9vBaGIx9BXAR1LJNKUM5Vs+sShNxkoVMJ9ZU4XhfS6OSBeIL3gzsxXLc4OJzfz
	 nrhYFIBhvlSIgNjFrfChmSXg52aVXXGOFbp9ZvlzXb6l6R4xD7nCq+Cs/wp/MrfWJLdjf
	 0kcaqqo9gBIPkBd/qXWqQM/NxXTDKhMuDQmho7v7Y5TXuxSZ8LppVx2sE31/j+2U5JQC8
	 4xVZMDBp3xpGACEeAb81ASHBZMqzYb6IKOraE/Lx7d3jfu9BF7JnQb2GimTs7VDpIvpaY
	 0ma85svp3An6SGzfRHfQvTf38A/9dHXJM+5dxu+5KQThdEzDaA8B/AIqsfm27qhKEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZokveVUh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44906606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZokveVUh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FC71F0089F;
	Sat,  7 Nov 2026 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794066909;
	bh=oTlatxiVv9UYZ/odweCxyDE3oqTZzP4Eh9sjjXrDe2Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZokveVUhVO8aTa8d60z4daqls8SWhJffNMTEHYS/XL/EVAMFZOxnD7w7MWcGiPFwo
	 +EgdPARh9TURKvo3vd+S/lMuVc3/JzxirV9HdW3IesqbpJOBpPfqMXm+4a5UH5jyFC
	 R/Le10wzbnKhtB2tSU1KDJooPXQg/SibSXYCEBez15H3G7/HMtYpuzuaziluUMXucP
	 9zLjtLR88iDdfTUpzHXyaYgHnHzWAFSbNv5PN3Lp6npT5t55W9/tzR1h/wPSrhVA1g
	 LYsHxtCYoMXcctPFmLxgNZUil4HtuDNB4lpTvqU5huKpx80uSFENgSSXJ64keqeD6G
	 bH47OM59U2cRA==
Subject: Re: [PATCH 1/2] net: thunderbolt: Stop queueing Rx buffers if
 allocation fails
From: netdev-bot+sashiko@kernel.org
To: mika.westerberg@linux.intel.com
Cc: netdev@vger.kernel.org, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Sat, 07 Nov 2026 15:55:08 +0000
Message-ID: <179406690879.994134.8991092134542553771@kernel.org>
In-Reply-To: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
References: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tbnet_poll() (drivers/net/thunderbolt/main.c) can stop Rx
  permanently when a refill fails.
- [High] The new deficit-based cleaned_count in tbnet_poll() (lines
  829-831) lets a NAPI poll that runs after teardown allocate and strand…
- [High] tbnet_poll() no longer completes NAPI while allocations keep
  failing and the ring is empty (the new `return budget` at line 936),…
- [Low] The commit message understates what changed.
- [Low] The new comment in tbnet_poll() (lines 932-935) says that when
  the Rx ring could not be refilled, polling is kept enabled to retry…

--

net: thunderbolt: Stop queueing Rx buffers if allocation fails

On an allocation or DMA mapping failure, tbnet_alloc_rx_buffers() now
stops instead of freeing every Rx buffer, including the ones already
posted to the hardware ring. The patch also reorders the
tbnet_connected_work() error path so the rings are stopped before
buffers are freed. tbnet_poll() now refills based on the ring deficit
and keeps polling when the ring cannot be refilled.

Closes: https://sashiko.dev/#/patchset/20260902082128.1148463-1-mika.westerberg%40linux.intel.com

> corruption to happen. Fix this by making tbnet_alloc_rx_buffers() not
> release the buffers already queued and modify the call sites accordingly.

[Severity: Low]
This isn't a bug, but could the commit message say more about what
changes? The patch is tagged for stable, and these tbnet_poll() changes
are not visible from the description:

- cleaned_count now starts from the ring deficit,
  tb_ring_size() - (prod - cons), instead of prod - cons
- a refill failure now breaks out of the Rx loop early
- NAPI now returns budget without completing while the ring is empty
  and the order-1 GFP_ATOMIC allocations keep failing

The patch also includes two separate fixes.

First, tbnet_connected_work() now stops both rings before freeing
buffers. The old err_free_tx_buffers/err_free_rx_buffers labels freed
them while the rings were still running.

Second, the dma_mapping_error() path in tbnet_alloc_rx_buffers() now
frees the page locally. The old goto err_free reached
tbnet_free_buffers(), which called dma_unmap_page() on a stale
tf->frame.buffer_phy left over from an earlier use of the slot.

> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index cf51b9c39f4ee..30b3568a83fc2 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c

[ ... ]

> @@ -826,9 +822,13 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
>  static int tbnet_poll(struct napi_struct *napi, int budget)
>  {
>  	struct tbnet *net = container_of(napi, struct tbnet, napi);
> -	unsigned int cleaned_count = tbnet_available_buffers(&net->rx_ring);
>  	struct device *dma_dev = tb_ring_dma_device(net->rx_ring.ring);
> -	unsigned int rx_packets = 0;
> +	unsigned int cleaned_count, rx_packets = 0;
> +	bool no_buffers = false;
> +
> +	/* Buffers a previous run was not able to return to the ring */
> +	cleaned_count = tb_ring_size(net->rx_ring.ring) -
> +			tbnet_available_buffers(&net->rx_ring);

[Severity: High]
Can a poll that runs after teardown fill the stopped ring with a full
set of DMA-mapped pages here?

tbnet_tear_down() is called from tbnet_disconnect_work(),
tbnet_suspend() and tbnet_shutdown() without napi_disable(). Only
tbnet_stop() disables NAPI. In tbnet_tear_down(),
tbnet_free_buffers(&net->rx_ring) resets prod = cons = 0 after the ring
is stopped. A later poll then computes:

    cleaned_count = 256 - 0 = 256

and calls tbnet_alloc_rx_buffers(net, 256). For each slot it allocates
an order-1 page, maps it, stores it in tf->page and calls
tb_ring_rx_more(). On a stopped ring, __tb_ring_enqueue() takes this
branch:

	} else {
		ret = -ESHUTDOWN;
	}

The return value is ignored, and ring->prod++ still runs.

A poll can run after teardown in three ways: NAPI was already scheduled
when teardown ran, the new no_buffers path below keeps NAPI
rescheduling itself across a disconnect, or socket busy polling calls
the poll directly.

On ifdown or removal, tbnet_stop() calls tbnet_tear_down(), which skips
tbnet_free_buffers() because login_sent and login_received are already
false. tb_ring_free() then drops frames[]. Does this leak up to 256
order-1 pages and their DMA mappings?

On reconnect, tbnet_connected_work() calls
tbnet_alloc_rx_buffers(net, TBNET_RING_SIZE) while frames[0].page is
still set, so this check:

		if (tf->page)
			break;

returns 0 without posting anything. The link then comes up with carrier
on and no Rx descriptors in the hardware ring. Would Rx stay dead in
that case?

Before this patch, cleaned_count was prod - cons, which is 0 after
teardown, so a late poll did nothing.

[ ... ]

> @@ -845,8 +845,14 @@ static int tbnet_poll(struct napi_struct *napi, int budget)
>  		 * time.
>  		 */
>  		if (cleaned_count >= MAX_SKB_FRAGS) {
> -			tbnet_alloc_rx_buffers(net, cleaned_count);
> +			int ret;
> +
> +			ret = tbnet_alloc_rx_buffers(net, cleaned_count);
>  			cleaned_count = 0;
> +			if (ret) {
> +				no_buffers = true;
> +				break;
> +			}
>  		}

[Severity: High]
Can this break stop Rx permanently under memory pressure?

The break comes before tb_ring_poll(), so frames the NHI has already
completed are not reaped, even though reaping needs no allocation.

The keep-polling check at the end of tbnet_poll() is:

	if (no_buffers && !tbnet_available_buffers(&net->rx_ring))
		return budget;

That check uses prod - cons, which also counts descriptors that are
completed but not yet reaped. Unless every buffer has been reaped, NAPI
completes and tb_ring_poll_complete() unmasks the interrupt.

Consider this sequence:

1. One poll reaps 17 (MAX_SKB_FRAGS) frames and the refill fails,
   leaving prod - cons = 239.

2. On every later interrupt, cleaned_count = 256 - 239 = 17, so the
   refill runs first. If it fails, the poll breaks with zero frames
   reaped, and NAPI completes because available is 239.

3. The peer keeps sending until all 239 descriptors are completed. The
   last completion raises the final interrupt. That poll also fails the
   refill and unmasks.

4. With no free descriptor, the NHI cannot complete another frame.
   nhi_unmask_interrupt() only writes the mask register, so no further
   interrupt arrives.

Once memory is available again, what would schedule NAPI? It looks like
Rx stays stalled until the link is torn down.

[ ... ]

> @@ -917,12 +923,19 @@ static int tbnet_poll(struct napi_struct *napi, int budget)
>  		}
>  	}
>  
> -	if (cleaned_count)
> -		tbnet_alloc_rx_buffers(net, cleaned_count);
> +	if (cleaned_count && tbnet_alloc_rx_buffers(net, cleaned_count))
> +		no_buffers = true;
>  
>  	if (rx_packets >= budget)
>  		return budget;
>  
> +	/*
> +	 * We were not able to fill the RX ring for more buffers on this
> +	 * run. Keep the polling enabled to retry the allocation.
> +	 */
> +	if (no_buffers && !tbnet_available_buffers(&net->rx_ring))
> +		return budget;

[Severity: Low]
The comment says polling stays enabled whenever the refill fails. The
condition only keeps polling when no Rx buffers are posted at all.

After a partial refill failure, NAPI completes and the retry depends on
a later Rx interrupt. Could the comment describe the actual condition?

[Severity: High]
This return keeps NAPI polling while allocations fail, and
tbnet_tear_down() does not disable NAPI. Can this poll loop outlive a
disconnect and race with the next connection's tbnet_connected_work()?

Both paths call tbnet_alloc_rx_buffers() on the same net->rx_ring with
no shared lock:

tbnet_connected_work() (process context)
    tb_ring_start(net->rx_ring.ring);
    tbnet_alloc_rx_buffers(net, TBNET_RING_SIZE);

tbnet_poll() (softirq)
    tbnet_alloc_rx_buffers(net, cleaned_count);

Inside tbnet_alloc_rx_buffers():

		unsigned int index = ring->prod & (TBNET_RING_SIZE - 1);
		struct tbnet_frame *tf = &ring->frames[index];
		...
		if (tf->page)
			break;
		...
		tb_ring_rx_more(ring->ring, &tf->frame);

		ring->prod++;

Both callers can read the same ring->prod and see tf->page == NULL.
Each then allocates and maps its own page. The second overwrites
tf->page and tf->frame.buffer_phy, which leaks the first page and its
mapping.

Both then call tb_ring_rx_more() on the same ring_frame. ring->lock in
__tb_ring_enqueue() serializes the list operations. However, a second
list_add_tail() of a frame already on in_flight would corrupt
ring->queue and in_flight, and the same buffer could end up in two
descriptors.

The non-atomic ring->prod++ from both contexts would also break the
prod/cons accounting. Reaping the duplicate completion could then see
tf->page == NULL and pass it to page_address().

Busy polling (net.core.busy_read) also looks like a way to run
tbnet_poll() concurrently with tbnet_connected_work().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103125621.1111198-1-mika.westerberg%40linux.intel.com
