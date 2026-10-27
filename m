Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108893;
	b=E4QNvQibMZuaO9MlZXRV5k+8kwyh2YSRU1moSYESwXf+XyDaHcaNMAg0fYPm+A+WNKJ1
	 Nc7B4SZbZcmJHQSKODjpkPvcmrBdx6l2ITpNYzE7hCQ3NX6zcj/YNGpFOVLGY6gNs/Aig
	 Zd6gTDysyGD/MYdhZQxkS5PK1YOkHH7yJPgEmrarwxkU82+EgC030zvi4/VtOgYUx8i8C
	 w40JNIpW7sazLJgQ44E+d0Aspozg4zu0Q07Hi/25VOKIkgaDMSUkPBCJoXly4/lnASaEo
	 MuTJ/9/JhOW5KYOYm5S5FJuFfxyjCktVdcAQ/2hYJa9zjASS5TqukbaykM3jRGgVdcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108893;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hcQ+vYLRd2pip651xzN/kPD2VR93IrBSI11gaTgf2Jk=;
	b=h05V8EhsnR0+9DRkTRQM0PzEQFq3WCaI0jp++3P8OMCof8E4QdGASw2FH0ayxFaeo+lT
	 ADzF4FLThkj3M2DLpRiiV1HNrmeFhVcil0NmfiGFkhX8Efzt/cwfbEU+8IjjkOnqVG2+o
	 71Jj7rkqXXJ++nCpHJ8tF0HupS+v51db9OU3tQ0Pky+mHYe316Rq5KCP4VdsOGe5XW14S
	 T3ADMDZQDNTfso5Jlp5BGuuKqp9qfMnjvRoMyToBcCa0DRgmjKgv18H2ppyjrU/xWBOft
	 SgdWxtScatELqA7IJhs9TvPFmVS6GwiIOyJwua9lF1emo8rFocNymQDO7vRoVDqExCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMQMgD0M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA5606A321;
	Tue, 27 Oct 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMQMgD0M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C11F01828;
	Tue, 27 Oct 2026 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108893;
	bh=hcQ+vYLRd2pip651xzN/kPD2VR93IrBSI11gaTgf2Jk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nMQMgD0Mb7IOFzFwZrkUbyR949GoEndaNEora6D2lfTzkzjLVkSiWB7PVXaqKy0ke
	 FJfp3HPFaWr1VaZr/PQuVFwgtgL1VNHSBPL59u/XPxA/+ovXiGv44NUcd2kLfS9VkS
	 wDc+PmlT6r+NAPMLdBxBNTC9s5PkAzgnx0ZjQggI6/TWFAuUKPwA9GoCNIH/5vihel
	 mQ2OiLKPwrHL5K22pMTjgKc9+6Hn28wkWm7R4pbAGiFb/sMYKO8s8ouWizeTBqJz7y
	 Jq1LY6Zbk63EA2YOBOs7jIbP8mGVLsIKp3SmRbtR9NdOh64xNNhshYZPzEhNsr/S/w
	 u1AuwTqgYGOHA==
Subject:
 Re: [PATCH net] net: lan966x: release the in-flight slot of a stale TX skb
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 13:48:11 +0000
Message-ID: <179310889194.3134.8592438113134956885@kernel.org>
In-Reply-To:
 <20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff@microchip.com>
References:
 <20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff@microchip.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 (1) · High: 0 (5) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, slots are reclaimed only by
  lan966x_ptp_txtstamp_old_release(), which ages only the queue of the…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but when the
  shared 512-entry FDMA TX ring is full, lan966x_fdma_xmit() returns…
- [High] This problem wasn't introduced by this patch, but the
  sparx5/lan969x driver has the same leak this patch fixes for lan966x.
- [High] This problem wasn't introduced by this patch, but
  lan966x_ptp_txtstamp_request() makes the skb visible on port->tx_skbs…
- [High] This problem wasn't introduced by this patch, but when
  lan966x_ptp_txtstamp_request() returns -EBUSY, lan966x_port_xmit()…
- [High] This problem wasn't introduced by this patch, but in FDMA mode
  lan966x_fdma_xmit() leaves a two-step skb DMA-mapped and referenced by…
- [High] This problem wasn't introduced by this patch, but
  lan966x_fdma_xmit() can free a two-step skb that is still on…
- [Medium] This problem wasn't introduced by this patch, but
  lan966x_ptp_txtstamp_old_release() frees two-step skbs after…

--

net: lan966x: release the in-flight slot of a stale TX skb

lan966x_ptp_txtstamp_old_release() now returns how many stale two-step TX
skbs it freed. lan966x_ptp_txtstamp_request() subtracts that count from
lan966x->ptp_skbs under ptp_ts_id_lock. Before this, a slot whose
timestamp never arrived was never released, so two-step TX eventually
failed on every port.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> index 8c40db90ee8f..9be2cfe6feeb 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c

[ ... ]

> @@ -389,14 +390,18 @@ static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
>  
>  		__skb_unlink(skb, &port->tx_skbs);
>  		dev_kfree_skb_any(skb);
> +		purged++;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but can this free a two-step
skb that the FDMA engine is still reading?

In FDMA mode, lan966x_fdma_xmit() leaves the skb DMA-mapped and
referenced by the shared TX ring, and hands its lifetime to the PTP code:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_xmit() {
    ...
	next_dcb_buf->data.skb = skb;
    ...
	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
	    LAN966X_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
		next_dcb_buf->ptp = true;
    ...
}

On completion, lan966x_fdma_tx_clear_buf() only unmaps it:

			if (!dcb_buf->ptp)
				napi_consume_skb(dcb_buf->data.skb, weight);

lan966x_ptp_txtstamp_old_release() frees by age alone.
LAN966X_PTP_TIMEOUT is msecs_to_jiffies(10), which is a single jiffy at
HZ=100. Nothing checks whether the FDMA descriptor has completed.

The PTP frame can sit behind other frames in the 512-entry ring that all
ports share, or egress can be slow (10/100 link, PAUSE, shapers). In
either case, the next two-step request on the same port can hand the skb
data back to the allocator while the device can still DMA-read it.

Could the device then send freed or reused memory onto the wire? And
would the late stamp then hit WARN_ON(!skb_match)?

[Severity: Medium]
This is also a pre-existing issue, but because aging here is based only
on time, what happens to a stamp that arrives after its skb has been
aged out?

lan966x_ptp_irq_handler() matches FIFO entries only by the per-port
0..511 id:

		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
			if (LAN966X_SKB_CB(skb)->ts_id != id)
				continue;
		...
		if (WARN_ON(!skb_match))
			continue;

A late stamp either hits the WARN_ON(), or it gets attributed to a newer
skb that reused the id, if the port's ts_id has wrapped in the meantime.

Can userspace then receive a wrong TX hardware timestamp, with the newer
skb's own stamp tripping the WARN later? Frames held in egress past the
timeout would trigger this, for example with taprio/tbf/cbs offload,
PAUSE or a slow link.

ptp_skbs never prevented id reuse, so this patch does not change the
behaviour.

>  	spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
> +
> +	return purged;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does sparx5/lan969x need
the same fix? sparx5_ptp_txtstamp_old_release() in
drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c matches the pre-patch
lan966x version, and it never decrements sparx5->ptp_skbs:

	skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
		if time_after(SPARX5_SKB_CB(skb)->jiffies + SPARX5_PTP_TIMEOUT,
			      jiffies)
			break;

		__skb_unlink(skb, &port->tx_skbs);
		dev_kfree_skb_any(skb);
	}

There are only two other decrements. The IRQ handlers in sparx5_ptp.c
and lan969x.c decrement it for a matched skb, and
sparx5_ptp_txtstamp_release() does so on the xmit busy path.

After SPARX5_MAX_PTP_ID (512) lost stamps,
sparx5_ptp_txtstamp_request() rejects every two-step request:

	if (sparx5->ptp_skbs == SPARX5_MAX_PTP_ID) {
		spin_unlock_irqrestore(&sparx5->ptp_ts_id_lock, flags);
		return -EBUSY;
	}

sparx5_port_xmit_impl() then returns NETDEV_TX_BUSY without stopping the
queue:

		if (sparx5_ptp_txtstamp_request(port, skb) < 0)
			return NETDEV_TX_BUSY;

Wouldn't the qdisc then requeue and retry the same PTP skb forever, and
block all traffic behind it on that TX queue?

A companion patch for sparx5 seems needed. It would return the purged
count and subtract it under ptp_ts_id_lock.

[ ... ]

> @@ -408,9 +413,10 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
>  	if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
>  		return 0;
>  
> -	lan966x_ptp_txtstamp_old_release(port);
> +	purged = lan966x_ptp_txtstamp_old_release(port);
>  
>  	spin_lock_irqsave(&lan966x->ptp_ts_id_lock, flags);
> +	lan966x->ptp_skbs -= purged;
>  	if (lan966x->ptp_skbs == LAN966X_MAX_PTP_ID) {

[Severity: Medium]
The ptp_skbs limit is switch-wide. Slots are only reclaimed by aging the
transmitting port's queue, and only when that port sends a two-step
frame. Can stale skbs on one port still use up the limit for every other
port?

The commit message says idle ports keep their stale skbs. Nothing else
releases them either. lan966x_port_stop() does not purge port->tx_skbs,
and HWTSTAMP_TX_OFF in lan966x_ptp_hwtstamp_set() only does:

	case HWTSTAMP_TX_OFF:
		port->ptp_tx_cmd = IFH_REW_OP_NOOP;
		break;

After that the port can never send a two-step frame again, so its stale
skbs are never aged. Only lan966x_ptp_deinit() purges tx_skbs.

Lost stamps can pile up on a port that then goes quiet: ifdown, TX
timestamping turned off, ptp4l stopped, or a boundary clock port in
passive state. Two-step TX on the other ports is then throttled, and
returns -EBUSY once the total reaches LAN966X_MAX_PTP_ID. That is the
failure this patch sets out to fix.

Would any of these close the gap: aging all ports before rejecting,
aging from a timer or worker, or purging and uncounting on ndo_stop and
HWTSTAMP_TX_OFF?

>  		spin_unlock_irqrestore(&lan966x->ptp_ts_id_lock, flags);
>  		return -EBUSY;

[Severity: High]
This isn't a bug introduced by this patch, but does this -EBUSY path
leak the skb? lan966x_port_xmit() returns the errno directly as its
netdev_tx_t:

		err = lan966x_ptp_txtstamp_request(port, skb);
		if (err)
			return err;

dev_xmit_complete() treats any rc < NET_XMIT_MASK, negative values
included, as meaning the driver consumed the skb. The core therefore
neither requeues nor frees it. The skb is not on port->tx_skbs either,
because this return happens before skb_queue_tail().

So every two-step frame sent while the slot table is full would leak an
skb, and its sk_wmem_alloc charge would keep the sending socket pinned.

Once an admin has enabled HW TX timestamping on a port, could an
unprivileged user fill the table and keep leaking memory? Sending UDP to
port 319 with SOF_TIMESTAMPING_TX_HARDWARE would be enough.

[Severity: High]
This is a pre-existing issue, but further down in
lan966x_ptp_txtstamp_request() the skb is published on port->tx_skbs
before its control block is filled in:

	skb_queue_tail(&port->tx_skbs, skb);
	LAN966X_SKB_CB(skb)->ts_id = port->ts_id;
	LAN966X_SKB_CB(skb)->jiffies = jiffies;

Only ptp_ts_id_lock covers these writes. lan966x_ptp_irq_handler() walks
the list holding only tx_skbs.lock and matches on
LAN966X_SKB_CB(skb)->ts_id.

On PREEMPT_RT, ptp_ts_id_lock is a sleeping lock and the PTP handler is
a threaded IRQ (devm_request_threaded_irq() in lan966x_probe()). The
handler can therefore preempt the sender right after skb_queue_tail().

Suppose the FIFO holds an unmatched stamp, for example a late one for an
aged-out skb, whose id equals the leftover ts_id bytes in the cb. The
handler then unlinks the new skb, and once request() drops the lock it
timestamps and frees it.

Wouldn't lan966x_port_xmit() then keep reading the cb and transmit the
freed skb? Setting ts_id and jiffies before skb_queue_tail() would avoid
this.

[Severity: High]
This is another pre-existing issue. After request() has queued and
counted the skb, lan966x_fdma_xmit() can free it without unlinking it
from port->tx_skbs:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_xmit() {
    ...
	if (skb_put_padto(skb, ETH_ZLEN)) {
		dev->stats.tx_dropped++;
		return NETDEV_TX_OK;
	}
    ...
}

skb_put_padto() passes free_on_error=true, so __skb_pad() frees the skb
when pskb_expand_head(GFP_ATOMIC) or skb_linearize() fails. This return
also skips the lan966x_ptp_txtstamp_release() call that the release:
label makes.

L2 PTP event messages are 58 bytes, which is below ETH_ZLEN. They are
cloned when an AF_PACKET tap is active, and that forces
pskb_expand_head().

Under memory pressure, could a later old_release() or IRQ handler walk
read the freed skb, __skb_unlink() it, and call dev_kfree_skb_any() on
it a second time?

[Severity: Critical]
This isn't introduced by this patch either, but the ring-full path in
lan966x_fdma_xmit() also returns without undoing the reservation made
here:

	next_to_use = lan966x_fdma_get_next_dcb(tx);
	if (next_to_use < 0) {
		netif_stop_queue(dev);
		return NETDEV_TX_BUSY;
	}

The register injection path does undo it, in lan966x_port_ifh_xmit():

err:
	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
	    LAN966X_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
		lan966x_ptp_txtstamp_release(port, skb);

	return NETDEV_TX_BUSY;

On NETDEV_TX_BUSY, dev_hard_start_xmit() overwrites skb->next, and
dev_requeue_skb() links the skb into q->gso_skb. At that point the skb
is still linked on port->tx_skbs and still counted in ptp_skbs.

Can this corrupt port->tx_skbs? A later old_release() or IRQ walk could
follow the overwritten pointers, or free an skb the stack still owns.

When the qdisc retries, request() calls skb_queue_tail() on the same skb
again. If that skb was the tail, skb->next ends up pointing to itself,
and skb_queue_walk_safe() in lan966x_ptp_irq_handler() would loop
forever with tx_skbs.lock held.

The 512-entry ring is shared by all ports, and netif_stop_queue() only
stops TX queue 0 of the current netdev. Ordinary TX congestion plus
two-step traffic on another port or queue looks like enough to reach
this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff%40microchip.com
