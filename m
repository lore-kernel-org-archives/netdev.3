Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B044E3230;
	Mon, 19 Oct 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410191; cv=none; b=ICU9gFAfOGxQ0kwUEsycAKe32HNLPnObWuUpyJ05+KX/HrrCMc5JajMniJvOEEeJXwGiDnduwhU7efaKI3E5BnAfL7OAHmWvuv1e84uT1YfM0NawZD3kQmtZaAgKGoHjtwLaZPlYM5odUTNxI8/8Q4GPBnnYYcprhYIRDIQSCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410191; c=relaxed/simple;
	bh=Jw6dStavmOVOKacMq9oRyJDuX7s494bXU/XThc7VFHQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJJ4e+wJroyA+WODL0poW/Fnhp+s2akOXt6baSi/+GO2lEiZaIkFNqn8+AOXEADRgmINrtHdyPrqSKuO5/wYHtPp8wExNiOQNXAp7cHXVnspjb3LjKnfqtfkS0Ko0n6rD/RRMAeSwcTQ/pOT3gY5DlwlGZQ8uiZDp1Q8k7f9Wvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWtV3d8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWtV3d8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD551F000C4;
	Mon, 19 Oct 2026 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410186;
	bh=TQ+lUK7RetG1VhW+UpX6iXTW5bU/fOhlcqkLNzeU/Qs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KWtV3d8WGL8nXg0EOAYI7Ix/D0ydDknfLLUpqML/mKTd6QxJtga9RVq7legUQ0Esq
	 dTNM3VVnJaZwRNMqR9rRN1SqjeZd3OHfjKxBdfhi5m7wanHZTYyXTUzshNEI4wjmaS
	 xvJDTAANpyBq/4XCqkkCRzMuDso6tfPGSAgzYkMKFKeG3R4RY27OGUy574atn5I33A
	 fCYrXxDo346F9F6A4QAyxUZ3z5z4pNdfO+k4Zbg/L/0//0ViF1cb50ZInzmDzgIRMs
	 KYa/vVfVwotGcP+vYpf8I+8U6jRQkyOW06DwKkorAqteGfhv5LOa6GuxcOnO8Qxk/I
	 gwQSfISFHD7rg==
Subject: Re: [PATCH v4 net 2/8] net: enetc: serialize access to the same TX
 ring from NAPI XDP_TX and ndo_xdp_xmit()
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 11:43:05 +0000
Message-ID: <179241018517.3135.15063923479147037736@kernel.org>
In-Reply-To: <20261015105536.1692348-3-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-3-vladimir.oltean@nxp.com>
X-sashiko-severity: High
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

Critical: 0 · High: 3 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new xdp_lock does not serialize enetc_xdp_xmit()
  (ndo_xdp_xmit) against the regular stack transmit path,…
- [High] Lock-order inversion between tx_ring->xdp_lock and the ERR050089
  MDIO rwlock (enetc_mdio_lock), introduced in enetc_clean_rx_ring_xdp().
- [High] net/enetc: concurrent TX ring corruption from stack and
  XDP_REDIRECT

Pre-existing issues:
- [High] enetc_stop() does not synchronize with ndo_xdp_xmit() calls
  already in progress.

--

net: enetc: serialize access to the same TX ring from NAPI XDP_TX and ndo_xdp_xmit()

This patch adds a spinlock (xdp_lock) to struct enetc_bdr. The lock
serializes the NAPI XDP_TX path and ndo_xdp_xmit() when both target the
same XDP TX ring. NAPI takes the lock for the whole poll cycle, drops it
around napi_gro_receive() and xdp_do_redirect(), and takes it again
around enetc_update_tx_ring_tail().

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 26abc5fafd188..418be387af18b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1817,6 +1817,7 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  	int err = 0;
>  
>  	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
> +	spin_lock(&tx_ring->xdp_lock);

[Severity: High]
When no XDP program is attached to this interface, is the ring picked
here also used by the regular stack transmit path?

With priv->xdp_prog NULL, enetc_num_stack_tx_queues() exposes every TX
ring to the stack:

	if (priv->xdp_prog)
		return num_tx_rings - num_possible_cpus();

	return num_tx_rings;

This makes the rings that priv->xdp_tx_ring[] points to ordinary netdev
queues as well. enetc_start_xmit() selects them through
priv->tx_ring[skb->queue_mapping]. It then updates next_to_use,
tx_swbd[] and the TBPIR doorbell while holding only the netdev_queue
xmit lock.

A redirect from another interface does not need a program on this
port. Devmap only checks the advertised NETDEV_XDP_ACT_NDO_XMIT bit
before calling ndo_xdp_xmit(). enetc_xdp_xmit() does not look at
priv->xdp_prog before using priv->xdp_tx_ring[smp_processor_id()].
That path now takes xdp_lock, but enetc_start_xmit() never does, so
the two producers are still not serialized against each other.

Can they then claim the same next_to_use slots and overwrite each
other's tx_swbd[] entries? tx_swbd[] holds a union of skb and
xdp_frame, and the is_xdp_redirect bit selects between them. Completion
could therefore treat an skb as an xdp_frame or the reverse. It could
also free a buffer twice or leak it, and the hardware could be handed a
BD that points at memory that is already unmapped. Any traffic that
another interface redirects into this port is enough to trigger it.

This race predates the patch, since ndo_xdp_xmit() had no locking at
all before. However, the commit message and the new comment on
struct enetc_bdr::xdp_lock present the lock as covering the TX BDR
producer state. It does not do that while the stack shares the ring.

Would it work to take the netdev_queue xmit lock in both XDP
producers instead? That would be __netif_tx_lock() on
netdev_get_tx_queue(ndev, tx_ring->index), as fec, stmmac and igb do.
That would serialize all three writers and make xdp_lock unnecessary.

Alternatively, should enetc_xdp_xmit() refuse frames, or NDO_XMIT be
cleared with xdp_features_clear_redirect_target(), while no program
has reserved the XDP rings?

[Severity: High]
If no XDP program is attached to this port, can enetc_start_xmit() be
writing to this same ring at the same time?

With priv->xdp_prog NULL, enetc_num_stack_tx_queues() gives every ring to
the stack:

	if (priv->xdp_prog)
		return num_tx_rings - num_possible_cpus();

	return num_tx_rings;

So the rings that priv->xdp_tx_ring[] points to are also regular stack
queues. There is no ndo_select_queue, and enetc_start_xmit() uses them
while holding only the netdev_queue xmit lock:

	tx_ring = priv->tx_ring[skb->queue_mapping];

enetc_pf_netdev_setup() always advertises NETDEV_XDP_ACT_NDO_XMIT, and
devmap only checks that feature bit. A redirect from another interface
into this port therefore reaches enetc_xdp_xmit() even when no program
is loaded here. enetc_xdp_xmit() does not check priv->xdp_prog. It takes
only xdp_lock, and the stack path never takes that lock.

Could both producers then claim the same next_to_use slots and
tx_swbd[] entries? tx_swbd[] holds a union of skb and xdp_frame,
selected by is_xdp_redirect and the other bitfields. Completion could
then free an skb as an xdp_frame or the reverse, free a buffer twice,
leak one, or give the hardware a DMA address that is already unmapped.

This window also existed before the patch, because ndo_xdp_xmit() had no
locking at all. However, the commit message says:

  Specifically, the spin lock only synchronizes the stats counters
  relevant to XDP (xdp_tx/xdp_tx_drops) and the TX BDR producer state
  (next_to_use, tx_swbd[] and hardware counterparts). The rest should be
  not necessary.

The new comment on struct enetc_bdr::xdp_lock also names only NAPI and
ndo_xdp_xmit() as writers.

Would it work to take the netdev_queue xmit lock in both XDP producers
instead? That would be __netif_tx_lock() on
netdev_get_tx_queue(ndev, tx_ring->index), as fec, stmmac and igb do. It
would cover all three writers and replace xdp_lock.

Alternatively, could ndo_xdp_xmit be refused, or NDO_XMIT cleared with
xdp_features_clear_redirect_target(), while no program reserves the XDP
rings?

>  
>  	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
>  		     !netif_carrier_ok(ndev))) {

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Does
enetc_stop() synchronize with an enetc_xdp_xmit() call that has already
passed this check?

enetc_stop() does the following without taking xdp_lock or waiting for a
grace period:

	set_bit(ENETC_TX_DOWN, &priv->flags);

	netif_tx_stop_all_queues(ndev);

	enetc_disable_rx_bdrs(priv);

	enetc_wait_bdrs(priv);

	enetc_disable_tx_bdrs(priv);

The napi_disable() calls that follow cover only the enetc vectors. They
do not cover the redirecting device's NAPI, which runs enetc_xdp_xmit()
from the devmap flush.

Suppose the ENETC_TX_DOWN test runs just before set_bit(). Then
enetc_xdp_xmit() keeps writing TX BDs, tx_swbd[] and next_to_use, and
rings TBPIR, while enetc_stop() drains and disables the ring.

After that, enetc_close() calls enetc_free_rxtx_rings() and
enetc_assign_tx_resources(priv, NULL). enetc_reconfigure() frees the
resources in a similar way.

Can the redirecting CPU then write into the freed tx_swbd array and BD
ring?

The core does not seem to close this window either. __dev_close_many()
calls synchronize_net() before ndo_stop, not after, and
enetc_reconfigure() keeps the device up the whole time. The race is
easier to hit on PREEMPT_RT, where softirq processing can be preempted.

The NAPI XDP_TX path has a smaller window of the same kind. It tests
ENETC_TX_DOWN per frame but rings the doorbell at the end of the poll.
napi_synchronize() runs only after enetc_wait_bdrs() and
enetc_disable_tx_bdrs().

On ENETC v1, enetc_setup_txbdr() copies next_to_use and next_to_clean
back from TBPIR/TBCIR. A late doorbell could therefore carry a stale
producer index into the newly allocated ring. Whether the hardware
latches a TBPIR write to a disabled ring has not been verified.

Now that xdp_lock exists, would taking it around set_bit(ENETC_TX_DOWN)
in enetc_stop(), or calling synchronize_net() after the set_bit(), close
this window?

[ ... ]

> @@ -2120,6 +2131,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>  	}
>  
>  out:
> +	spin_unlock(&tx_ring->xdp_lock);
> +
>  	rx_ring->next_to_clean = i;
>  
>  	rx_ring->stats.packets += rx_frm_cnt;

[ ... ]

> @@ -2131,8 +2144,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>  		enetc_lock_mdio();
>  	}
>  
> -	if (xdp_tx_frm_cnt)
> +	if (xdp_tx_frm_cnt) {
> +		spin_lock(&tx_ring->xdp_lock);
>  		enetc_update_tx_ring_tail(tx_ring);
> +		spin_unlock(&tx_ring->xdp_lock);
> +	}

[Severity: High]
Does this reverse the lock order between xdp_lock and enetc_mdio_lock?

In the poll loop and in enetc_xdp_xmit(), xdp_lock is taken first and
enetc_lock_mdio() second:

	spin_lock(&tx_ring->xdp_lock);
	...
	enetc_lock_mdio();

At out:, xdp_lock is dropped while the MDIO read lock is still held, and
the xdp_do_flush() block takes the MDIO read lock again. So this
spin_lock() runs with the MDIO read lock held, which is the opposite
order.

On PREEMPT_RT both are sleeping locks, and this cycle seems possible:

CPU A (enetc_clean_rx_ring_xdp)
  holds enetc_mdio_lock (read)
  spin_lock(&tx_ring->xdp_lock)          <- waits for CPU B

CPU B (enetc_xdp_xmit, same XDP TX ring)
  holds tx_ring->xdp_lock
  enetc_lock_mdio() -> read_lock()       <- waits for CPU C

CPU C (_enetc_rd_mdio_reg_wa)
  write_lock_irqsave(&enetc_mdio_lock)   <- waits for CPU A's reader

rwbase_write_lock() takes the rtmutex and removes READER_BIAS. After
that, __rwbase_read_lock() always goes to
rwbase_rtmutex_slowlock_locked(), so CPU B blocks on the rtmutex owned
by CPU C while CPU C waits for CPU A to drop its read lock.

Can this deadlock on LS1028A with PREEMPT_RT? There, enetc_has_err050089
is enabled and periodic PHY polling is enough to provide the MDIO
writer. On non-RT kernels, qrwlock readers in softirq context are not
blocked by a writer that is only waiting, so this looks RT-specific.

Would ringing the doorbell before dropping xdp_lock at out: keep the
order consistent? Another option would be to call enetc_unlock_mdio()
before taking xdp_lock here and take the MDIO lock again afterwards.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015105536.1692348-1-vladimir.oltean%40nxp.com
