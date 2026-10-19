Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50C4E533B;
	Mon, 19 Oct 2026 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410194; cv=none; b=uydBAqHvoCd7g/gkMO4qQynw+ESQ4ml68BSfR66pXrMt7R9BVXP7tRkAph3JeGLFJczPeFKNi0dTklZGSWp+UgyLU0HT64b5eWQeXplU9MjiE/q1tYuIr2WzNkP9eJY6yyFDzmAy7+tOLuTBHOFId4npM5cUKH17wDxKrR97F+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410194; c=relaxed/simple;
	bh=6q/uzDpM7f7qLbX1JAOqSWYlyXqUTDrDFGQHXrzY3yU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUXYSNKVu3rSppMzJsl4H02tPNGU0VGXMlNyq/jkWduhdG19INe0II9z2D1OcfZQh9EKdfSFlieTjTq1ZSvJD/Bqx0PWrZCFy6vM/2W7RyfdB8D2+odeLJqJdoNlwxRHBFgV5iW84gm87SkMCHoEoZRFaCEVB6ie+LrVRNZdZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLJ8OHNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLJ8OHNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D8C1F000C7;
	Mon, 19 Oct 2026 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410190;
	bh=Rm/ht8J63apjpNZe5sq7J+iq2RtjL3tr80VtoU/E27Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KLJ8OHNX7nnEWNzWfPMJ48N8OD0M0D/GzDWRbyDveKoA166+UikjZvZSb/gqmEtnC
	 h27tbQeSUJXPvNJ/9o57ITyTR3rQFip3vTjLO49ktJonvqW0lstqfNx5Gjrk2pKNJ6
	 HRDH/sC3Zp70UTBRl7zumm9BAklSzMvg/3RSGvMDLiiRiXvImOw10GLc1EyeoduDIH
	 vMIPSDQVrEM1ya1SOc23CmztpvQwyuj75oy6Pkf6ZGnRe7LGeQDdKcDXrqqz4ZKP/n
	 ltlLwE/6rQ7jjdQANn3N4+wTY5pzt3Q6qpD/2Ny2JHBsKWWGfLcIM7MsvHWQKscXg4
	 eOArlziOfPGig==
Subject: Re: [PATCH v4 net 7/8] net: enetc: fix leak of pending XDP_TX frames
 when going down
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 11:43:09 +0000
Message-ID: <179241018957.3135.16343924152218517759@kernel.org>
In-Reply-To: <20261015105536.1692348-8-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-8-vladimir.oltean@nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new XDP_TX branch in enetc_free_tx_frame()
  (drivers/net/ethernet/freescale/enetc/enetc.c:171-178) decrements…

--

net: enetc: fix leak of pending XDP_TX frames when going down

This patch changes enetc_free_tx_frame() so that XDP_TX buffers still in
the TX ring at teardown are handled. It decrements the RX ring's
xdp_tx_in_flight counter and frees the page, so the RX ring is no longer
left waiting for buffers that will never come back.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index d456b9b488acf..218065b9a3777 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -168,6 +168,14 @@ static void enetc_free_tx_frame(struct enetc_bdr *tx_ring,
>  
>  	if (tx_swbd->dma)
>  		enetc_unmap_tx_buff(tx_ring, tx_swbd);
> +	if (tx_swbd->is_xdp_tx) {
> +		struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
> +		struct enetc_bdr *rx_ring;
> +
> +		rx_ring = enetc_rx_ring_from_xdp_tx_ring(priv, tx_ring);
> +		rx_ring->xdp.xdp_tx_in_flight--;
> +		__free_page(tx_swbd->page);
> +	}

[Severity: High]
Should tx_swbd->is_xdp_tx and tx_swbd->page be cleared here, or the whole
swbd memset, after the page is freed?

As written, the swbd still has is_xdp_tx set and still points at the page
that was just freed. enetc_unmap_tx_buff() clears only ->dma, and the code
after this block clears only ->xdp_frame or ->skb. Before this patch,
calling enetc_free_tx_frame() twice on the same swbd did no harm. With
this patch, the second call frees the same page again.

The other release paths do scrub their descriptors. enetc_clean_tx_ring()
does this after enetc_recycle_xdp_tx_buff():

    memset(tx_swbd, 0, sizeof(*tx_swbd));

and enetc_free_rx_ring() sets rx_swbd->page = NULL.

The tx_swbd arrays can be reused after enetc_free_tx_ring() on the error
path of enetc_reconfigure():

    enetc_stop(priv->ndev);
    enetc_free_rxtx_rings(priv);

    /* Interface is down, run optional callback now */
    if (cb) {
        err = cb(priv, ctx);
        if (err)
            goto out_restart;
    }
    [ ... ]
out_restart:
    enetc_setup_bdrs(priv, extended);
    enetc_start(priv->ndev);

Here is one way to reach that path. Detaching an XDP program goes through
enetc_setup_xdp_prog()->enetc_reconfigure()->enetc_reconfigure_xdp_cb().
netif_set_real_num_tx_queues() can fail there with -ENOMEM when the stack
TX queue count grows. The callback then restores the old program, and
enetc_reconfigure() takes out_restart.

The interface then restarts on the old tx_swbd arrays. Any XDP_TX slot
that hardware had sent but NAPI never cleaned before enetc_stop() still
has is_xdp_tx=1 and a pointer to a freed page.

enetc_setup_txbdr() reloads next_to_use and next_to_clean from
TBPIR/TBCIR, so these stale slots can end up outside the active window.
They are only overwritten when enetc_xdp_map_tx_buff() copies a whole new
swbd into them.

At the next enetc_close() or enetc_reconfigure(), enetc_free_tx_ring()
walks every slot:

    for (i = 0; i < tx_ring->bd_count; i++) {
        struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];

        enetc_free_tx_frame(tx_ring, tx_swbd);
    }

Would that call __free_page() a second time on the already freed page,
and decrement xdp_tx_in_flight a second time?

Nothing resets xdp_tx_in_flight. Once it goes negative, this check in
enetc_clean_rx_ring_xdp() is always true:

    if (cleaned_cnt > rx_ring->xdp.xdp_tx_in_flight)
        enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
                             rx_ring->xdp.xdp_tx_in_flight);

Can that ask for more buffers than there are free RX BDs, and overwrite
BDs the hardware still owns?

There is a second variant. If a short XDP frame's pad BD lands in a stale
slot, enetc_map_tx_pad() sets only len, is_eof, do_twostep_tstamp and
check_wb. In that case is_xdp_tx and page are left as they were. When
that BD completes, enetc_clean_tx_ring() would call
enetc_recycle_xdp_tx_buff() on the freed page with dma == 0.

Could that put a freed page back into the RX ring for device DMA, and
decrement xdp_tx_in_flight once more?

Also, on rev1, if PI != CI at restart, the hardware would resume the
stale BDs, which now point at unmapped DMA addresses.

>  
>  	if (xdp_frame) {
>  		xdp_return_frame(tx_swbd->xdp_frame);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015105536.1692348-1-vladimir.oltean%40nxp.com
