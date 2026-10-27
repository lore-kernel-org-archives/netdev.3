Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110169;
	b=vH1zdSjuvhST/Ct9tC4pzKrMmudkLP5o3CARgMbkRGVRizYVtiEjtdH+me/pDTgOQRka
	 Et9Q5Us8FsJYmoEiAyNzGcqSAa/9sKEASbEPQpjQ/bSV8WMEb1tUPY9WyD/ryloac5Gmi
	 EUY9DeCSihx7ADlkG6AC+SZHTvNLK868f6QPWgjLSemOWdAh05M5ZXqlz88hQ2Z6H8PVR
	 KI56XGwjy4F+RrVdTZmeBhbVjDi4xk5Ob08kcYonUifWzUSwoiTEpdAXqJxsj6cbWF5xy
	 nJjybXe4pJK/y6pF0/H0wHJXVoV1NXcjWGNO9Bmzg7c8elxJ/OQfWlx1w8kAG0GzG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110169;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=TWBi2T1WCgbjXthkns3DCqng4ByHETZSriM0acceVRs=;
	b=QuyAttm7wB9CBP8W47gdROF8ogyJUS8+f2elz93ftirCXozngn0LT8mK92ejrHVLe8a/
	 HEbTIKgTzenQ3B1OYohRzaqbJMh+u9/KQnMn1kdUMz6O7twM62KCQ7UodMcuNX21oQe6D
	 Zv+IVf2k+o8YFKyQFSL5I3icQGF1Ep3v6blm96r0qD2ngnhYIAhJueha1gI6EnxxGS24y
	 xc7DQVzEjH5d6ratMxUjytnIlTXYInm8cpZh46tR8UEP+oXtieEmrxa5+J94HG9hktZFm
	 zwD291D6F4f9Zhf+5YRvPtLnj02u41SRfFAGe12z61Zo0AvNvZzT7/1kfQhwF6dokwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ZrlOHXDz;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B8606A32C;
	Tue, 27 Oct 2026 14:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978B8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ZrlOHXDz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793110169; x=1824646169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kzXJfUt/mvE6C7COzWQ4NsbuG/TUHC/cZY+nYkGXwi4=;
  b=ZrlOHXDzWd1ZmBPCG+RHOoILce+81XwdJGHpMHH+2DowU83x5epgoaES
   VnDYO44+C2i6/8yehpkFymi2pfnjVA/RPrYPIU3wYtranBsG+bByBgBDF
   XxrUp/7N5Rgt/n+B3MD785e1XpZH3ANQR+magZGRKv3vC2EO+uRdkn3Uf
   9CRIS1QrMgv9MNKFrfGBjxQTutjvSh+nNt0CNL4d1yl6i4eZGRuCR8r6I
   tWsdiXheG6f4wJwHxwfaZBWiWjP6/r/L4/glgbLHo6/Khy5m34LB7VgHi
   n3XpwgcJi1db9/B1Xo+WuW8ijMuDpDAey3raSc2C7yjOgM/etoX4ZOlTq
   Q==;
X-CSE-ConnectionGUID: 9UFWM3DBSnKDHk14w0Thkg==
X-CSE-MsgGUID: zHiH6/adT2ydDwQTnjDNRw==
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="65876301"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2026 07:09:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 27 Oct 2026 07:09:26 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 27 Oct 2026 07:09:24 -0700
Date: Tue, 27 Oct 2026 15:09:24 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: release the in-flight slot of a stale
 TX skb
Message-ID: <20261027140924.k7miu6ykyejh7bag@DEN-DL-M70577.microsemi.net>
References: <20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff@microchip.com>
 <179310889194.3134.8592438113134956885@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179310889194.3134.8592438113134956885@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 (1) · High: 0 (5) · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] After this patch, slots are reclaimed only by
>   lan966x_ptp_txtstamp_old_release(), which ages only the queue of the…
> 
> Pre-existing issues:
> - [Critical] This problem wasn't introduced by this patch, but when the
>   shared 512-entry FDMA TX ring is full, lan966x_fdma_xmit() returns…
> - [High] This problem wasn't introduced by this patch, but the
>   sparx5/lan969x driver has the same leak this patch fixes for lan966x.
> - [High] This problem wasn't introduced by this patch, but
>   lan966x_ptp_txtstamp_request() makes the skb visible on port->tx_skbs…
> - [High] This problem wasn't introduced by this patch, but when
>   lan966x_ptp_txtstamp_request() returns -EBUSY, lan966x_port_xmit()…
> - [High] This problem wasn't introduced by this patch, but in FDMA mode
>   lan966x_fdma_xmit() leaves a two-step skb DMA-mapped and referenced by…
> - [High] This problem wasn't introduced by this patch, but
>   lan966x_fdma_xmit() can free a two-step skb that is still on…
> - [Medium] This problem wasn't introduced by this patch, but
>   lan966x_ptp_txtstamp_old_release() frees two-step skbs after…
> 
> --
> 
> net: lan966x: release the in-flight slot of a stale TX skb
> 
> lan966x_ptp_txtstamp_old_release() now returns how many stale two-step TX
> skbs it freed. lan966x_ptp_txtstamp_request() subtracts that count from
> lan966x->ptp_skbs under ptp_ts_id_lock. Before this, a slot whose
> timestamp never arrived was never released, so two-step TX eventually
> failed on every port.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> > index 8c40db90ee8f..9be2cfe6feeb 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
> 
> [ ... ]
> 
> > @@ -389,14 +390,18 @@ static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
> >
> >               __skb_unlink(skb, &port->tx_skbs);
> >               dev_kfree_skb_any(skb);
> > +             purged++;
> >       }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can this free a two-step
> skb that the FDMA engine is still reading?
> 
> In FDMA mode, lan966x_fdma_xmit() leaves the skb DMA-mapped and
> referenced by the shared TX ring, and hands its lifetime to the PTP code:
> 
> drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_xmit() {
>     ...
>         next_dcb_buf->data.skb = skb;
>     ...
>         if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
>             LAN966X_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
>                 next_dcb_buf->ptp = true;
>     ...
> }
> 
> On completion, lan966x_fdma_tx_clear_buf() only unmaps it:
> 
>                         if (!dcb_buf->ptp)
>                                 napi_consume_skb(dcb_buf->data.skb, weight);
> 
> lan966x_ptp_txtstamp_old_release() frees by age alone.
> LAN966X_PTP_TIMEOUT is msecs_to_jiffies(10), which is a single jiffy at
> HZ=100. Nothing checks whether the FDMA descriptor has completed.
> 
> The PTP frame can sit behind other frames in the 512-entry ring that all
> ports share, or egress can be slow (10/100 link, PAUSE, shapers). In
> either case, the next two-step request on the same port can hand the skb
> data back to the allocator while the device can still DMA-read it.
> 
> Could the device then send freed or reused memory onto the wire? And
> would the late stamp then hit WARN_ON(!skb_match)?
> 
> [Severity: Medium]
> This is also a pre-existing issue, but because aging here is based only
> on time, what happens to a stamp that arrives after its skb has been
> aged out?
> 
> lan966x_ptp_irq_handler() matches FIFO entries only by the per-port
> 0..511 id:
> 
>                 skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
>                         if (LAN966X_SKB_CB(skb)->ts_id != id)
>                                 continue;
>                 ...
>                 if (WARN_ON(!skb_match))
>                         continue;
> 
> A late stamp either hits the WARN_ON(), or it gets attributed to a newer
> skb that reused the id, if the port's ts_id has wrapped in the meantime.
> 
> Can userspace then receive a wrong TX hardware timestamp, with the newer
> skb's own stamp tripping the WARN later? Frames held in egress past the
> timeout would trigger this, for example with taprio/tbf/cbs offload,
> PAUSE or a slow link.
> 
> ptp_skbs never prevented id reuse, so this patch does not change the
> behaviour.
> 
> >       spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
> > +
> > +     return purged;
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does sparx5/lan969x need
> the same fix? sparx5_ptp_txtstamp_old_release() in
> drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c matches the pre-patch
> lan966x version, and it never decrements sparx5->ptp_skbs:
> 
>         skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
>                 if time_after(SPARX5_SKB_CB(skb)->jiffies + SPARX5_PTP_TIMEOUT,
>                               jiffies)
>                         break;
> 
>                 __skb_unlink(skb, &port->tx_skbs);
>                 dev_kfree_skb_any(skb);
>         }
> 
> There are only two other decrements. The IRQ handlers in sparx5_ptp.c
> and lan969x.c decrement it for a matched skb, and
> sparx5_ptp_txtstamp_release() does so on the xmit busy path.
> 
> After SPARX5_MAX_PTP_ID (512) lost stamps,
> sparx5_ptp_txtstamp_request() rejects every two-step request:
> 
>         if (sparx5->ptp_skbs == SPARX5_MAX_PTP_ID) {
>                 spin_unlock_irqrestore(&sparx5->ptp_ts_id_lock, flags);
>                 return -EBUSY;
>         }
> 
> sparx5_port_xmit_impl() then returns NETDEV_TX_BUSY without stopping the
> queue:
> 
>                 if (sparx5_ptp_txtstamp_request(port, skb) < 0)
>                         return NETDEV_TX_BUSY;
> 
> Wouldn't the qdisc then requeue and retry the same PTP skb forever, and
> block all traffic behind it on that TX queue?
> 
> A companion patch for sparx5 seems needed. It would return the purged
> count and subtract it under ptp_ts_id_lock.
> 
> [ ... ]
> 
> > @@ -408,9 +413,10 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
> >       if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
> >               return 0;
> >
> > -     lan966x_ptp_txtstamp_old_release(port);
> > +     purged = lan966x_ptp_txtstamp_old_release(port);
> >
> >       spin_lock_irqsave(&lan966x->ptp_ts_id_lock, flags);
> > +     lan966x->ptp_skbs -= purged;
> >       if (lan966x->ptp_skbs == LAN966X_MAX_PTP_ID) {
> 
> [Severity: Medium]
> The ptp_skbs limit is switch-wide. Slots are only reclaimed by aging the
> transmitting port's queue, and only when that port sends a two-step
> frame. Can stale skbs on one port still use up the limit for every other
> port?

Yes, but this is a separate, pre-existing limitation, and the commit message
even says so.

> 
> The commit message says idle ports keep their stale skbs. Nothing else
> releases them either. lan966x_port_stop() does not purge port->tx_skbs,
> and HWTSTAMP_TX_OFF in lan966x_ptp_hwtstamp_set() only does:
> 
>         case HWTSTAMP_TX_OFF:
>                 port->ptp_tx_cmd = IFH_REW_OP_NOOP;
>                 break;
> 
> After that the port can never send a two-step frame again, so its stale
> skbs are never aged. Only lan966x_ptp_deinit() purges tx_skbs.
> 
> Lost stamps can pile up on a port that then goes quiet: ifdown, TX
> timestamping turned off, ptp4l stopped, or a boundary clock port in
> passive state. Two-step TX on the other ports is then throttled, and
> returns -EBUSY once the total reaches LAN966X_MAX_PTP_ID. That is the
> failure this patch sets out to fix.
> 
> Would any of these close the gap: aging all ports before rejecting,
> aging from a timer or worker, or purging and uncounting on ndo_stop and
> HWTSTAMP_TX_OFF?

The bug fixed here is that every lost timestamp leaked its slot for good, so the
limit was eventually hit on any system that lost timestamps.  Aging the queues
of all ports on each request, so an idle port cannot hold slots, I believe is a
change for net-next.

> 
> >               spin_unlock_irqrestore(&lan966x->ptp_ts_id_lock, flags);
> >               return -EBUSY;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this -EBUSY path
> leak the skb? lan966x_port_xmit() returns the errno directly as its
> netdev_tx_t:
> 
>                 err = lan966x_ptp_txtstamp_request(port, skb);
>                 if (err)
>                         return err;
> 
> dev_xmit_complete() treats any rc < NET_XMIT_MASK, negative values
> included, as meaning the driver consumed the skb. The core therefore
> neither requeues nor frees it. The skb is not on port->tx_skbs either,
> because this return happens before skb_queue_tail().
> 
> So every two-step frame sent while the slot table is full would leak an
> skb, and its sk_wmem_alloc charge would keep the sending socket pinned.
> 
> Once an admin has enabled HW TX timestamping on a port, could an
> unprivileged user fill the table and keep leaking memory? Sending UDP to
> port 319 with SOF_TIMESTAMPING_TX_HARDWARE would be enough.
> 
> [Severity: High]
> This is a pre-existing issue, but further down in
> lan966x_ptp_txtstamp_request() the skb is published on port->tx_skbs
> before its control block is filled in:
> 
>         skb_queue_tail(&port->tx_skbs, skb);
>         LAN966X_SKB_CB(skb)->ts_id = port->ts_id;
>         LAN966X_SKB_CB(skb)->jiffies = jiffies;
> 
> Only ptp_ts_id_lock covers these writes. lan966x_ptp_irq_handler() walks
> the list holding only tx_skbs.lock and matches on
> LAN966X_SKB_CB(skb)->ts_id.
> 
> On PREEMPT_RT, ptp_ts_id_lock is a sleeping lock and the PTP handler is
> a threaded IRQ (devm_request_threaded_irq() in lan966x_probe()). The
> handler can therefore preempt the sender right after skb_queue_tail().
> 
> Suppose the FIFO holds an unmatched stamp, for example a late one for an
> aged-out skb, whose id equals the leftover ts_id bytes in the cb. The
> handler then unlinks the new skb, and once request() drops the lock it
> timestamps and frees it.
> 
> Wouldn't lan966x_port_xmit() then keep reading the cb and transmit the
> freed skb? Setting ts_id and jiffies before skb_queue_tail() would avoid
> this.
> 
> [Severity: High]
> This is another pre-existing issue. After request() has queued and
> counted the skb, lan966x_fdma_xmit() can free it without unlinking it
> from port->tx_skbs:
> 
> drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_xmit() {
>     ...
>         if (skb_put_padto(skb, ETH_ZLEN)) {
>                 dev->stats.tx_dropped++;
>                 return NETDEV_TX_OK;
>         }
>     ...
> }
> 
> skb_put_padto() passes free_on_error=true, so __skb_pad() frees the skb
> when pskb_expand_head(GFP_ATOMIC) or skb_linearize() fails. This return
> also skips the lan966x_ptp_txtstamp_release() call that the release:
> label makes.
> 
> L2 PTP event messages are 58 bytes, which is below ETH_ZLEN. They are
> cloned when an AF_PACKET tap is active, and that forces
> pskb_expand_head().
> 
> Under memory pressure, could a later old_release() or IRQ handler walk
> read the freed skb, __skb_unlink() it, and call dev_kfree_skb_any() on
> it a second time?
> 
> [Severity: Critical]
> This isn't introduced by this patch either, but the ring-full path in
> lan966x_fdma_xmit() also returns without undoing the reservation made
> here:
> 
>         next_to_use = lan966x_fdma_get_next_dcb(tx);
>         if (next_to_use < 0) {
>                 netif_stop_queue(dev);
>                 return NETDEV_TX_BUSY;
>         }
> 
> The register injection path does undo it, in lan966x_port_ifh_xmit():
> 
> err:
>         if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
>             LAN966X_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
>                 lan966x_ptp_txtstamp_release(port, skb);
> 
>         return NETDEV_TX_BUSY;
> 
> On NETDEV_TX_BUSY, dev_hard_start_xmit() overwrites skb->next, and
> dev_requeue_skb() links the skb into q->gso_skb. At that point the skb
> is still linked on port->tx_skbs and still counted in ptp_skbs.
> 
> Can this corrupt port->tx_skbs? A later old_release() or IRQ walk could
> follow the overwritten pointers, or free an skb the stack still owns.
> 
> When the qdisc retries, request() calls skb_queue_tail() on the same skb
> again. If that skb was the tail, skb->next ends up pointing to itself,
> and skb_queue_walk_safe() in lan966x_ptp_irq_handler() would loop
> forever with tx_skbs.lock held.
> 
> The 512-entry ring is shared by all ports, and netif_stop_queue() only
> stops TX queue 0 of the current netdev. Ordinary TX congestion plus
> two-step traffic on another port or queue looks like enough to reach
> this.
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff%40microchip.com
