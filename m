Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94582344DAE;
	Wed,  9 Sep 2026 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990652; cv=none; b=i3ZIasxM+nJirrx9pMuB3BzOXQPGPnMKYOsvQfuqW4RPMAnk00wYbclE5u9uUv+fS4HtGQ79hDXRbjX49K1oUUn0rRkYx0tooPZ7/DWT1y2HItcHu5e1eQWzD0sGyy4U2HeLcRQupmXw0RYVtdA0QTaF/QUnfUQ4Ex9ejuhNwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990652; c=relaxed/simple;
	bh=pDid7rjntruX2H4VEdeeqsdi59XnWiUaYIdYa5Jg+pg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hF+Xt/JYng9wU6Cz9FtSzAFw49GGzsEUwybajdRCFG2KVkDvzCDq0J8BaN4nzWOwqA+XdZAFqfVDmewVUBLws1BvUDFXhEVOZ4VQ7amaBWyv4Qli1ifl4gWhyBv+xsnoEUyyIDpmws0UU6JD1gjKR5/7io3vDCKu0IftQbYvHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKXBB2OX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKXBB2OX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5613E1F000FF;
	Wed,  9 Sep 2026 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990648;
	bh=SBgTT3VIWig+VgekORUqrYlktN0bs73d9DwAiyf9MpQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IKXBB2OXUFUgcjdpMoqQuDCznorx5HEjNfzuxwg9G7zxBN/vvAtnxrGii/tp1m0iM
	 Szz0AQgsCXLF6PAA9fWdr13BTpGnWc/g5mS06ztymMdfyiz0F5wop/yVjPELhmxSPA
	 prdC2qlgVw6ykcasFwrYpVeF9k0qCJYOJEGzuxFoY+nCrTj5f/SnIovAElGXxS2bIe
	 YMBaS+7Eumu63/XbChQY1wSHGBf/deJVcHNtFHFEIyTNcPpLrblGa21mLlZPxmWfev
	 Z168gTCHoNwscwDgQ+70FTj4azjPfVNLNuOQW3OfmVW3SCxdZkYR7InFHKnkCxCBdq
	 5j8E2PVPkf95g==
Subject:
 Re: [PATCH v2] net: stmmac: clear dma_conf in __stmmac_open error path
From: netdev-bot+sashiko@kernel.org
To: zhaojinming@uniontech.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, horms@kernel.org,
 ansuelsmth@gmail.com, Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 21:50:46 +0000
Message-ID: <178899064691.219967.12835853245703806626@kernel.org>
In-Reply-To: =?utf-8?q?=3C20260904-fix-stmmac-mtu-change-use-after-free-v2-1?=
 =?utf-8?q?-91e680476921=40uniontech=2Ecom=3E?=
References: =?utf-8?q?=3C20260904-fix-stmmac-mtu-change-use-after-free-v2-1-?=
 =?utf-8?q?91e680476921=40uniontech=2Ecom=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 2 (1) · Medium: 2 · Low: 0

- [High] The new `memset(&priv->dma_conf, 0, sizeof(priv->dma_conf))` at
  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:4193 also zeroes the…
- [High] On the `irq_error` path the MAC and all DMA channels are already
  running, but the unwind never stops them, so the descriptor rings the…
- [Medium] The new memset() at stmmac_main.c:4193 also wipes the per-TX-
  queue TBS state in `priv->dma_conf.tx_queue[].tbs` (STMMAC_TBS_EN /…
- [Medium] The whole-struct clear at stmmac_main.c:4193 also erases
  persistent user configuration held in `priv->dma_conf.dma_rx_size` /…

Pre-existing issues:
- [High] After a failed reopen the driver leaves every NAPI instance
  disabled while the netdevice stays logically running, and the next…

--

net: stmmac: clear dma_conf in __stmmac_open error path

This adds a memset of priv->dma_conf on the error paths of
__stmmac_open(), so that the struct no longer points at the descriptor
resources the callers free after a failed open.  A few questions about
what else that whole-struct clear erases, and about the state the failed
open leaves behind.

Link to v1: https://lore.kernel.org/r/20260903-fix-stmmac-mtu-change-use-after-free-v1-1-c81dc7d6d18a@uniontech.com

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 24656b35350b1..4369e64faf9f8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4190,6 +4190,7 @@ static int __stmmac_open(struct net_device *dev,
>  
>  	stmmac_release_ptp(priv);
>  init_error:
> +	memset(&priv->dma_conf, 0, sizeof(priv->dma_conf));
       ^^^^^^

[Severity: High]
Can this memset turn the per-queue txtimer hrtimers into invalid ones?

The struct hrtimer txtimer lives inside priv->dma_conf.tx_queue[], and on
the irq_error path stmmac_init_coalesce() has already initialized them:

  struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
  ...
  hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC,
                HRTIMER_MODE_REL);

After the memset those timers are all-zero, so timer->base is NULL.  Every
teardown path walks them unconditionally, in __stmmac_release(),
stmmac_suspend() and stmmac_xdp_release():

  for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
          hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);

and hrtimer_cancel() -> hrtimer_try_to_cancel() -> hrtimer_active() has no
NULL check:

  base = READ_ONCE(timer->base);
  seq = raw_read_seqcount_begin(&base->seq);

A failed reopen in stmmac_change_mtu() just returns the error, so the
interface stays IFF_UP and the next ip link set down, suspend or XDP
attach reaches those zeroed timers.

The commit message says the memset leaves "the state consistent regardless
of the caller" - but priv->dma_conf is the live object all of those paths
dereference.  Would it be better to invalidate only the freed resource
pointers, or to leave the timers alone, rather than clearing the whole
struct?

[Severity: Medium]
Does this also drop the per-queue TBS state?

tc_setup_etf() in stmmac_tc.c keeps the ETF/launch-time offload state
only in priv->dma_conf:

  if (!(priv->dma_conf.tx_queue[qopt->queue].tbs & STMMAC_TBS_AVAIL))
          return -EINVAL;

  if (qopt->enable)
          priv->dma_conf.tx_queue[qopt->queue].tbs |= STMMAC_TBS_EN;

and the loop at the top of __stmmac_open() exists to carry that bit across
a reopen:

  for (int i = 0; i < priv->plat->tx_queues_to_use; i++)
          if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
                  dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;

After the memset both STMMAC_TBS_EN and STMMAC_TBS_AVAIL are gone while
the etf qdisc is still installed, so a following tc ... etf call returns
-EINVAL.

On the next successful open stmmac_setup_dma_desc() re-derives only AVAIL
from plat->tx_queues_cfg[].tbs_en and stmmac_hw_setup() re-arms the
hardware:

  int enable = tx_q->tbs & STMMAC_TBS_AVAIL;

  stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);

but stmmac_xmit() only programs the launch time when tx_q->tbs &
STMMAC_TBS_EN.  Does that mean launch times are silently ignored from
then on, with no error reported anywhere?

[Severity: Medium]
The same clear erases the ring geometry the user configured through
ethtool -G.  stmmac_reinit_ringparam() stores it directly in the struct
being zeroed:

  priv->dma_conf.dma_rx_size = rx_size;
  priv->dma_conf.dma_tx_size = tx_size;

  if (netif_running(dev))
          ret = stmmac_open(dev);

and stmmac_setup_dma_desc() reads it back, treating 0 as "never
configured":

  dma_conf->dma_tx_size = priv->dma_conf.dma_tx_size;
  dma_conf->dma_rx_size = priv->dma_conf.dma_rx_size;

  if (!dma_conf->dma_tx_size)
          dma_conf->dma_tx_size = DMA_DEFAULT_TX_SIZE;
  if (!dma_conf->dma_rx_size)
          dma_conf->dma_rx_size = DMA_DEFAULT_RX_SIZE;

So after ethtool -G followed by a failed ip link set up,
stmmac_get_ringparam() reports rx_pending 0 / tx_pending 0 - a value
stmmac_set_ringparam() itself rejects as below DMA_MIN_RX_SIZE /
DMA_MIN_TX_SIZE - and the next successful open quietly allocates default
sized rings.  Is losing the configured sizes intended here?

There is a second consumer: stmmac_xdp_open() uses priv->dma_conf in
place without recomputing the sizes or dma_buf_sz:

  ret = alloc_dma_desc_resources(priv, &priv->dma_conf);
  ...
  ret = init_dma_desc_rings(dev, &priv->dma_conf, GFP_KERNEL);

Would a zeroed conf describe zero-length rings to the hardware there?

[Severity: High]
This isn't a bug introduced by this patch, but it affects the same
failure path the commit message says it makes consistent, so it seems
worth raising here: after a failed reopen, NAPI is left disabled while
netif_running() is still true, and the next teardown calls napi_disable()
on it again.

stmmac_change_mtu() calls __stmmac_release() (which runs
stmmac_disable_all_queues() -> __stmmac_disable_all_queues() ->
napi_disable() per queue) and then __stmmac_open().  NAPI is re-enabled
only on the success path:

  stmmac_enable_all_queues(priv);
  netif_tx_start_all_queues(priv->dev);

so both error labels return with NAPI disabled.  napi_disable_locked()
in net/core/dev.c leaves the state bits set and a second call waits on
them:

  while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
          usleep_range(20, 200);
          val = READ_ONCE(n->state);
  }

Nothing clears those bits because napi_enable() is never called, so does
the following ip link set down, suspend, stmmac_xdp_release(),
stmmac_reinit_ringparam() or stmmac_reset_subtask() hang there while
holding rtnl_lock?

If that is the case, the release-side unwind never reaches the
free_dma_desc_resources() the commit message describes, so does the
memset on its own actually make the post-failure state safe?

>  	return ret;
>  }
>  

[Severity: High]
One more question about the same error path: are the DMA engines still
running when the callers free the rings?

stmmac_hw_setup() programs every channel with the new dma_conf ring
addresses, enables MAC Rx/Tx, and ends with:

  /* Start the ball rolling... */
  stmmac_start_all_dma(priv);

If stmmac_request_irq() then fails, the irq_error path only does
phylink_stop(), the per-queue hrtimer_cancel() loop and
stmmac_release_ptp() - there is no stmmac_stop_all_dma().  Compare
__stmmac_release(), which stops the engines first:

  /* Stop TX/RX DMA and clear the descriptors */
  stmmac_stop_all_dma(priv);

  /* Release and free the Rx/Tx resources */
  free_dma_desc_resources(priv, &priv->dma_conf);

Both callers of __stmmac_open() free immediately after the failure, for
example in stmmac_change_mtu():

  free_dma_desc_resources(priv, dma_conf);
  kfree(dma_conf);

Can the Rx DMA engine keep writing incoming frames into those unmapped
and freed descriptors and buffers?  After a failed MTU change the
interface stays IFF_UP, so nothing else stops the engines.  Should the
error path stop the DMA and disable the MAC instead of (or in addition
to) clearing priv->dma_conf?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-fix-stmmac-mtu-change-use-after-free-v2-1-91e680476921%40uniontech.com
