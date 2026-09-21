Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28743AEF45;
	Mon, 21 Sep 2026 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991861; cv=none; b=hw/Ub/3wsL1KtBZMHJ5o46WzGzo1Ib8gcDRHtadom/PErhBIhCocw5HrQcuve23acAKNBMkGqHlDeuyZK/y9UhgmMkkXSaCKcz3nsW64dp95YEkaf2X/+v6fjseQvdMmHkC2XYy6zx86XWPzYm4ut/S4IHPJvor51e6I96+Hobc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991861; c=relaxed/simple;
	bh=waCNVstASiU9I8wphAy3poJkmaBwwiHYwe3+snj/cO8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGwugQaVPDSAb7VvkDBx7+sts336bCsxiLWbIV9NimoB87AkZxE0gVIMd4AbMs84hI4lcl/zBpg3smIim1xVYHczTdbNMByO4AnmVA+B98huM+Ma12VSpejlBll9B2QUKUlm17+wi48E1UsbFM8TxB98SMdnJUD/R144EeHdAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azcx5PRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azcx5PRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC2F1F000FF;
	Mon, 21 Sep 2026 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789991859;
	bh=BHuvo0BMs5lNofbYQMZ80kY1wIqL0Onu5K/sWBzZHeY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Azcx5PRWvXD2RliqeziEhQOYuCcLhWc5JF1xqnd5ZSMPj4rF+9uLJ8/RSwqTdTZPf
	 9Q7kjd0bStpmDblAQdZ3W79iW0ti3Hze1ysDo5A5HRQWLx5CJXuEbU7A98jZTC2FoM
	 bIwHgafDbK2MVMPG6sdXAc9X1pPcJC56JLCIoZvfzRf6oHPtFozZCYGDuSUuVufdGL
	 mBr8YwX+jGbRXt2wlrAS6ZrPl/HTijqYX6XiFyQm29ErK/lHjcxI7q9m0p5WJRFeGE
	 FZEoMhcbjICsARbTThKmvs9J/h41pT6VO3THPxV/I627YI5eTags8jX5d09xgSl6mP
	 vO5Whu43UMQvg==
Subject: Re: [PATCH net v2] net: axienet: bound TX completion cleanup by the
 NAPI budget
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 robert.hancock@calian.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 11:57:38 +0000
Message-ID: <178999185805.2160803.2118648689532400433@kernel.org>
In-Reply-To: <20260917115657.20697-1-maimon.sagi@gmail.com>
References: <20260917115657.20697-1-maimon.sagi@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the new budget guard in axienet_free_tx_chain()
  is disabled when @budget == 0 (`if (!force && budget && packets >=…

Pre-existing issues:
- [Medium] Pre-existing (not introduced or claimed to be fixed by this
  patch): axienet_dma_bd_release()…

--

net: axienet: bound TX completion cleanup by the NAPI budget

The patch adds a budget check to axienet_free_tx_chain() so the TX
completion loop stops on a packet boundary once the NAPI budget is spent,
and treats a budget of zero as "no limit" so the netpoll TX reclaim and the
@force callers still drain the ring.  The kernel-doc for @budget is updated
to match.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f340..039885814a5d2 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -772,7 +772,9 @@ static int axienet_device_reset(struct net_device *ndev)
>   * @force:	Whether to clean descriptors even if not complete
>   * @sizep:	Pointer to a u32 accumulating the total byte count of
>   *		completed packets (using skb->len). Ignored if NULL.
> - * @budget:	NAPI budget (use 0 when not called from NAPI poll)
> + * @budget:	NAPI budget. When @force is false, cleanup stops after this
> + *		many completed packets. Zero means no limit, as used by the
> + *		netpoll TX reclaim and by callers outside NAPI poll.
>   *
>   * Would either be called after a successful transmit operation, or after
>   * there was an error when setting up the chain.
> @@ -788,6 +790,15 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  	dma_addr_t phys;
>  
>  	for (i = 0; i < nr_bds; i++) {
> +		/* A NAPI poll must not return more than its budget.  Stop on a
> +		 * packet boundary once it is spent - cur_p->skb is only set on
> +		 * a packet's last descriptor, so no packet is left half-freed.
> +		 * A zero budget means no limit: netpoll polls with a budget of
> +		 * 0 to reclaim the TX path only, and must still clean the ring.
> +		 */
> +		if (!force && budget && packets >= budget)
> +			break;
> +

[Severity: High]
With the "budget &&" term, is the case the commit message is about still
reachable on the netpoll path?

For a budget of 0 the guard never fires, so axienet_free_tx_chain() walks up
to lp->tx_bd_num descriptors and increments packets for every completed
descriptor with a non-NULL cur_p->skb.  axienet_tx_poll() then returns that
count verbatim:

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_tx_poll() {
	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
					&size, budget);
	...
	if (packets < budget && napi_complete_done(napi, packets)) {
	...
	return packets;
}

netpoll is the caller that enforces the invariant:

net/core/netpoll.c:poll_one_napi() {
	/* We explicitly pass the polling call a budget of 0 to
	 * indicate that we are clearing the Tx path only.
	 */
	work = napi->poll(napi, 0);
	WARN_ONCE(work, "%pS exceeded budget in poll\n", napi->poll);
	...
}

lp->napi_tx is on dev->napi_list (netif_napi_add(ndev, &lp->napi_tx,
axienet_tx_poll) in axienet_probe()), so netpoll_poll_dev()->poll_napi()->
poll_one_napi() reaches axienet_tx_poll() with budget 0.  If netconsole or
kgdboe is active on the interface and at least one TX descriptor has
XAXIDMA_BD_STS_COMPLETE_MASK set with cur_p->skb != NULL, doesn't that poll
return non-zero work for a budget of 0 and trip the WARN_ONCE?

The "packets < budget" test is also false for budget 0, so
napi_complete_done() is skipped on that pass, which is the secondary symptom
the changelog describes.

Would it work better to keep the unlimited reclaim for budget 0 (it is
already bounded by lp->tx_bd_num) but have axienet_tx_poll() report
"budget ? packets : 0", while still doing the byte/packet accounting?

The new kernel-doc says zero means "no limit, as used by the netpoll TX
reclaim".  netpoll asks for two things: drain the TX path, and report zero
work.  Could the kernel-doc and the in-loop comment mention both?

One more nit on the changelog:

  "Zero therefore means no limit, which also covers the @force callers that
  clean up after a DMA mapping failure with a budget of 0."

The guard is already gated on !force, so the @force callers are unaffected by
the value of @budget here.

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the TX
reclaim path: does axienet_dma_bd_release() leak the outstanding TX skbs and
their streaming DMA mappings?

The RX side walks the ring and cleans up:

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_dma_bd_release() {
	for (i = 0; i < lp->rx_bd_num; i++) {
		...
		dev_kfree_skb(lp->rx_bd_v[i].skb);
		...
		dma_unmap_single(lp->dev, phys, lp->max_frm_size, DMA_FROM_DEVICE);
	}
	...
	/* If we end up here, tx_bd_v must have been DMA allocated. */
	dma_free_coherent(lp->dev,
			  sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
			  lp->tx_bd_v,
			  lp->tx_bd_p);
}

The TX ring is freed with no equivalent pass over lp->tx_bd_v, so descriptors
between lp->tx_bd_ci and lp->tx_bd_tail keep their cur_p->skb and their
dma_map_single() mapping.

axienet_stop() disables TX reclamation before the release, so nothing can run
afterwards:

	napi_disable(&lp->napi_tx);
	...
	axienet_dma_stop(lp);
	cancel_work_sync(&lp->dma_err_task);
	free_irq(lp->tx_irq, ndev);
	free_irq(lp->rx_irq, ndev);
	axienet_dma_bd_release(ndev);

So an "ip link set down" or a driver unbind with frames in flight would lose
up to lp->tx_bd_num skbs and mappings.  The budget cap added here can leave
completed-but-unreclaimed descriptors around for a later poll, which slightly
widens the window, but the leak is independent of this change.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917115657.20697-1-maimon.sagi%40gmail.com
