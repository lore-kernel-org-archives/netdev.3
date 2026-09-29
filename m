Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237651C079;
	Tue, 29 Sep 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683867; cv=none; b=DPG9rwAcH2yZaOcBRrg7iDi9SI+rtl74p53Z/BhtijEiRJzukbCWqjl9jIGcyhrABxMJf9z4vzrrXHtJVaJ1WW7mByXw+wvIPcxxZql/utm8/QaOkzrICQNoQw+cWYuu0nPK+TZXMAoPAs0WO9OlaYfd3HTsvX1eS36TdQI4MIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683867; c=relaxed/simple;
	bh=8cadxgE6m7HGlBNCWyc+F83lgakCQxg9/O88RMyBSJU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AfaxJ7mniBGFQNphBL+RALx1qjdT93ErQ1N6xh8gpR+Jsbe9fgJRBaBn+/GTGsAVMfdmyIGUcSb7b1/tkviu6HhXJAoLTJ+XU/D4DAuUQ2FuNowr9gUGUIOEpXtPWY8ngVzEZUZRSWR9QY9D4a8nzROJlAOgvVwgq4TEhnT8mMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIfAjOtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIfAjOtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C061F00893;
	Tue, 29 Sep 2026 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683861;
	bh=cbOL7hDoZzuX8z50y+d7XvRXuCqltdGfnWd75Ikn+pU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bIfAjOtkfMk5/96iaoWmEVColEG63KiXwU5Q3fZZxPjQa79TeaZjOKZEOnygjGET/
	 MmUZIsou6J1wbXqHXfr1B80Sqs1Ae8WXwrCcRqD/WSwxcku7Ir3zGB9DCC/XFlY69q
	 0VO6Gs5Jrk8QZh/bbywu0VidAq7Y0bGqbWLWvA5f9mNLtkuubdMTrH4dSu96l/wihU
	 nu2JuWUCxIAUmipq29QGu1MgpfBeVGms7cOFM2HNe5UYSmxnLj2l/O9g9T1cGFfJ2Q
	 jD7lovEqFQcQn20vXr0pTGrftIlOtlpzQErfbfk1Pjb47m0o5jav+Elt+FIWcSnmvo
	 sHOaem9RC/8dQ==
Subject: Re: [PATCH net] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, daniel@iogearbox.net
Date: Tue, 29 Sep 2026 12:11:00 +0000
Message-ID: <179068386068.434549.2275598075562085411@kernel.org>
In-Reply-To: <20260927081034.350422-1-maimon.sagi@gmail.com>
References: <20260927081034.350422-1-maimon.sagi@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds an unguarded walk of lp->tx_bd_v[] to
  axienet_dma_bd_release()…
- [Low] The new TX walk frees never-transmitted, in-flight skbs with
  dev_kfree_skb(), which include/linux/skbuff.h:1479 defines as…
- [Low] The commit message justifies the new unmap/free by saying 'The
  DMA engine has been stopped by then, so the hardware no longer…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the same
  interface-down leak remains in the dmaengine configuration…
- [Medium] This problem wasn't introduced by this patch, but
  axienet_open() allocates the BD rings and maps the RX skbs via…

--

net: axienet: free outstanding TX buffers in axienet_dma_bd_release()

This patch makes axienet_dma_bd_release() walk the legacy DMA TX
descriptor ring before freeing it. It unmaps every descriptor whose cntrl
is still set and frees any skb still attached. Frames that are in flight
when the interface goes down are then no longer leaked.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f340..02bcb89d1bbef 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -187,6 +187,24 @@ static void axienet_dma_bd_release(struct net_device *ndev)
>  	struct axienet_local *lp = netdev_priv(ndev);
>  
>  	/* If we end up here, tx_bd_v must have been DMA allocated. */
> +	for (i = 0; i < lp->tx_bd_num; i++) {
> +		struct axidma_bd *cur_p = &lp->tx_bd_v[i];
> +
> +		/* axienet_free_tx_chain() clears cntrl when it reclaims a
> +		 * descriptor, so a non-zero value means the mapping is live.
> +		 */
> +		if (cur_p->cntrl) {

[Severity: Medium]
Can lp->tx_bd_v be NULL or already freed when axienet_stop() gets to this
loop?

The comment above says tx_bd_v must have been DMA allocated. However,
axienet_open() throws away the result of axienet_device_reset():

axienet_open() {
	...
	ret = axienet_device_reset(ndev);
	axienet_unlock_mii(lp);

	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
	...
}

So open still succeeds in each of these cases:

- __axienet_device_reset() times out and axienet_dma_bd_init() never runs.
  On the first open tx_bd_v is still NULL. On a later open it still points
  at the ring that the previous stop freed.

- dma_alloc_coherent() for the TX ring fails in axienet_dma_bd_init(), which
  leaves tx_bd_v NULL.

- The RX allocation or mapping fails. The out: label then calls
  axienet_dma_bd_release(), which frees both rings but leaves tx_bd_v and
  rx_bd_v pointing at the freed memory.

On the next ifdown, axienet_stop()->axienet_dma_bd_release() reads
cur_p->cntrl and cur_p->skb through that pointer. If the pointer is NULL
this oopses. If the ring was freed, garbage can be passed to
dma_unmap_single() and dev_kfree_skb().

Before this patch the TX side only called dma_free_coherent(), and
dma_free_attrs() returns early for a NULL cpu_addr. So the NULL cases did
no harm when no traffic had been sent.

The RX half of this function already has a guard:

	if (!lp->rx_bd_v)
		return;

Should the TX walk have a similar check? It might also help to clear
tx_bd_v and rx_bd_v after freeing them, and to check the
axienet_device_reset() return value in axienet_open().

> +			dma_addr_t addr = desc_get_phys_addr(lp, cur_p);
> +
> +			dma_unmap_single(lp->dev, addr,
> +					 (cur_p->cntrl &
> +					  XAXIDMA_BD_CTRL_LENGTH_MASK),
> +					 DMA_TO_DEVICE);

[Severity: Low]
The commit message says:

  "The DMA engine has been stopped by then, so the hardware no longer
  references the buffers."

Is that guaranteed? axienet_dma_stop() checks for HALT at most five times
and carries on without any message if HALT never appears. It then ignores
the return value of __axienet_device_reset():

axienet_dma_stop() {
	...
	sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
	for (count = 0; !(sr & XAXIDMA_SR_HALT_MASK) && count < 5; ++count) {
		msleep(20);
		sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
	}

	/* Do a reset to ensure DMA is really stopped */
	axienet_lock_mii(lp);
	__axienet_device_reset(lp);
	axienet_unlock_mii(lp);
}

__axienet_device_reset() returns -ETIMEDOUT and logs "DMA reset timeout!"
if the reset bit never clears.

If MM2S is still running at that point, could this loop unmap live TX
mappings and free skb data that the engine is still reading?

The RX half of this function and axienet_dma_err_handler() already rely on
the same assumption, so this patch adds little new exposure. Before the
patch, though, the TX buffers were leaked, which meant they stayed valid
in this failure case.

> +		}
> +		if (cur_p->skb)
> +			dev_kfree_skb(cur_p->skb);

[Severity: Low]
Should these frames be freed as drops? dev_kfree_skb() is consume_skb(),
which marks frames that were never transmitted as successfully consumed.

The commit message says this mirrors axienet_dma_err_handler(). That
function frees the same descriptors with:

		if (cur_p->skb)
			dev_kfree_skb_irq(cur_p->skb);

which reports them as drops. With consume_skb(), frames thrown away at
ifdown do not show up in drop_monitor or the kfree_skb tracepoint.
Something like dev_kfree_skb_any() would keep the two paths consistent.

> +	}
> +
>  	dma_free_coherent(lp->dev,
>  			  sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
>  			  lp->tx_bd_v,

[Severity: Medium]
This is a pre-existing issue that this patch did not introduce. The
dmaengine configuration (lp->use_dmaengine) seems to have the same leak on
interface down. In axienet_stop():

	} else {
		dmaengine_terminate_sync(lp->tx_chan);
		dmaengine_synchronize(lp->tx_chan);
		dmaengine_terminate_sync(lp->rx_chan);
		dmaengine_synchronize(lp->rx_chan);

		for (i = 0; i < TX_BD_NUM_MAX; i++)
			kfree(lp->tx_skb_ring[i]);
		kfree(lp->tx_skb_ring);
		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
			kfree(lp->rx_skb_ring[i]);
		kfree(lp->rx_skb_ring);

xilinx_dma_terminate_all()->xilinx_dma_free_descriptors() frees the done,
active and pending descriptors without running their callbacks.

The TX skb and its dma_map_sg() mapping stored by
axienet_start_xmit_dmaengine() are only released in axienet_dma_tx_cb().
The RX skb and its dma_map_single() mapping stored by
axienet_rx_submit_desc() are only released in axienet_dma_rx_cb().

Does each down cycle therefore leak every posted RX skb and any in-flight
TX skbs, along with their DMA mappings?

[Severity: Medium]
This is also a pre-existing issue that this patch did not introduce.
axienet_open() allocates the BD rings and maps the RX skbs through
axienet_device_reset()->axienet_dma_bd_init() before it calls
axienet_init_legacy_dma(). If a request_irq() fails there, the unwind is:

err_tx_irq:
	napi_disable(&lp->napi_tx);
	napi_disable(&lp->napi_rx);
	cancel_work_sync(&lp->dma_err_task);
	dev_err(lp->dev, "request_irq() failed\n");
	return ret;

axienet_open() then jumps to err_phy, which only undoes phylink and the
stats work. Neither path calls axienet_dma_stop() or
axienet_dma_bd_release().

Are the coherent rings, the RX skbs and their mappings leaked here, with
the DMA engine left running? The next open overwrites tx_bd_v and rx_bd_v.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927081034.350422-1-maimon.sagi%40gmail.com
