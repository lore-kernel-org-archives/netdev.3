Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B24A3F27;
	Fri, 25 Sep 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344343; cv=none; b=tEmwhi5hITcFiHx2/dDvS6o3ald3CZYqzV8wNrCtffuseEJW2lKiOOdz3J/XVzW4jorKbc6c5QK35biOKucZNAQd4mcgOXoNYW9dWbYI3hs9s3dJ8KWiBaylhYdpWaK/Cv6YSJhCXBo1AMBMFhcCGGBrKmNbuV/3z8Ez9K5x9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344343; c=relaxed/simple;
	bh=h0WaYjbg/NaNZS/l93bZkoCIwxchNnfYxixDNS3R3rY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXOtqXfMCuFr75OeH1IHKissjJQf3+E1Y8A3tYKqXobCH5/We03j1qbU1fJbOv+H9EUmuPs00rcSPnTuRBwwJSonkUGPhVYNGKSYu0dYyxHm0dkRpjfiUPHaSC5Xal3G4xqrUkUSvm/SHHz1Rm/Gt1eXtuac4dA20dab4Q5vO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilQGJYza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilQGJYza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7661F000FF;
	Fri, 25 Sep 2026 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344342;
	bh=XmAUpyL8zz8kuHDd9d/+aHBvbVJnej1uVNgN9e4kMlo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ilQGJYzajpyZtBUZTmma8ZmROziK6Vc+sTs+GD9T4zqOtjyQrvRfMmLU9gAKDL+9m
	 i73nkcUxQwSXDGGKZnjOG19jTt+Ia3X7ZjfqLqZ3DjkZ1gtI0Jdf7Y2Ptvx6zRFRup
	 Vksp1LtnhVhP2OQWgKecFZL3QjELnFn/CjEPD0gnIrUlwzuzSLX61pWhQytXmZaO79
	 6/9923oFniELnNu42ghxbkL8+5emfr9SyOo5NBj9s3kHl1U3r+XL8xZpHdzrrLqqvo
	 CPyF0qznquzJN1ZoEmGhTdycBXD8S5YjG8OtcCJQk3FWJ8IifQ/S9by4MrHssS7KBM
	 4bgFFxv285K0w==
Subject: Re: [PATCH net v3] net: axienet: bound TX completion cleanup by the
 NAPI budget
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robert.hancock@calian.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 13:52:21 +0000
Message-ID: <179034434119.2160803.4103857237545092058@kernel.org>
In-Reply-To: <20260924135052.185129-1-maimon.sagi@gmail.com>
References: <20260924135052.185129-1-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new budget break in axienet_free_tx_chain() (line 801)
  leaves completed descriptors in lp->tx_bd_v.
- [Low] Wrong Fixes: tag.
- [Low] The kernel-doc for axienet_tx_poll() no longer matches its
  behaviour.

--

net: axienet: bound TX completion cleanup by the NAPI budget

This patch stops the TX completion loop in axienet_free_tx_chain() once
the NAPI budget has been used up. The check is skipped on the force path.
A budget of 0 is treated as no limit, and axienet_tx_poll() now returns
0 for a budget of 0, so the netpoll WARN_ONCE() in poll_one_napi() is not
triggered.

> Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")

[Severity: Low]
Is this the right commit for the Fixes: tag?

In 9e2bc267e780, axienet_tx_poll() passed budget as nr_bds, and the
helper returned i, the number of descriptors walked:

    axienet_free_tx_chain(lp, lp->tx_bd_ci, budget, false, &size, budget)

That return value is bounded by budget. With a netpoll budget of 0 the
loop runs zero times, so poll_one_napi() could not warn either.

The call that passes lp->tx_bd_num and returns a packet count comes from
5a6caa2cfabb ("net: xilinx: axienet: Fix packet counting"). git blame on
the baseline points there:

    packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
                                    &size, budget);

Should the tag be the following instead?

    Fixes: 5a6caa2cfabb ("net: xilinx: axienet: Fix packet counting")

The sentence "which the unbounded loop could already do before this
change" also describes the loop added by 5a6caa2cfabb.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 782f903d318f3..7fd77f8cb57c6 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c

[ ... ]

> @@ -788,6 +792,16 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  	dma_addr_t phys;
>  
>  	for (i = 0; i < nr_bds; i++) {
> +		/* A NAPI poll must not return more than its budget.  Stop on a
> +		 * packet boundary once it is spent - cur_p->skb is only set on
> +		 * a packet's last descriptor, so no packet is left half-freed.
> +		 * A zero budget means no limit: netpoll polls with a budget of
> +		 * 0 to reclaim the TX path, so the ring must still be drained;
> +		 * axienet_tx_poll() reports no work to it.
> +		 */
> +		if (!force && budget && packets >= budget)
> +			break;

[Severity: Medium]
Can this break leak the TX skbs and DMA mappings still in the ring when
the interface is brought down?

Completed descriptors left behind after the break still have cur_p->skb
set and a live dma_map_single() mapping. The commit message relies on
NAPI rescheduling the poll to reclaim them. That does not happen while
napi_disable() is pending.

axienet_stop() calls napi_disable(&lp->napi_tx) while TX DMA is still
running. If the TX poll finds more than budget completions, it returns
budget, and __napi_poll() takes this branch:

net/core/dev.c:__napi_poll() {
    ...
	if (unlikely(napi_disable_pending(n))) {
		napi_complete(n);
		return work;
	}
    ...
}

Nothing polls again after that, and axienet_stop() continues:

axienet_stop()
  napi_disable(&lp->napi_tx)
  axienet_dma_stop(lp)
  free_irq(lp->tx_irq, ndev)
  axienet_dma_bd_release(ndev)
    dma_free_coherent(lp->dev,
                      sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
                      lp->tx_bd_v, lp->tx_bd_p)

axienet_dma_bd_release() does not unmap the TX buffers or free
tx_bd_v[i].skb. The only TX ring skb cleanup loop is in
axienet_dma_err_handler(), and the normal stop path does not run it. The
remaining skbs are never freed. Their sk_wmem_alloc charge is never
released, and their streaming DMA mappings are leaked.

Before this patch, a poll running during napi_disable() drained every
descriptor completed by then. ndo_stop already had no TX reclaim for
descriptors still in flight, so that gap predates this patch. The budget
break adds a new way to hit it.

Would it work to drain the ring without the budget bound and clamp only
the return value? Another option is to reclaim all TX descriptors in
axienet_stop() or axienet_dma_bd_release().

[ ... ]

> @@ -1027,7 +1041,11 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>  		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
>  		spin_unlock_irq(&lp->tx_cr_lock);
>  	}
> -	return packets;
> +
> +	/* netpoll polls with a budget of 0 to reclaim the TX path and expects
> +	 * no work to be reported; see poll_one_napi().
> +	 */
> +	return budget ? packets : 0;
>  }

[Severity: Low]
Should the kernel-doc above axienet_tx_poll() be updated too? It still
says:

 * @budget:	Max number of TX packets to process.
 *
 * Return: Number of TX packets processed.

With this patch a budget of 0 means no limit. For that case the function
returns 0 even after it has reclaimed packets and passed them to
netdev_completed_queue() and the u64 stats.

The new @budget text for axienet_free_tx_chain() also contradicts itself.
It first says 0 is used "when not called from NAPI poll", then says
"netpoll polls with it". The netpoll call is a NAPI ->poll() call, since
poll_one_napi() calls napi->poll(napi, 0).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924135052.185129-1-maimon.sagi%40gmail.com
