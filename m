Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610894;
	b=ohraMiJfrRxMnz9uea63jopLAJ29WqoDpd7mW+IVDsK0fJngpKQKpevZRBk+PFjP2y83
	 quT6SCJLIYB3wJ+JDHeVq0otbom6IN4Sok24LKWFTKU9v+1f44Zet/wVMDz9S3X4jikps
	 d6UwiFqZaJsEhlsyMykL1U8MgCOPwzpCS9/fyC4ZzyiMHAAHcyZhakZWOWrN/Zneho03S
	 YG3m9S+0mK/ak3EHK5n1fJ/lN2f7LzXi01LAcZFY8YkJWW3nQal9CDKfmeVnFD8/45hsW
	 MFpwjFqBWzGctInE7B8GVp06pGv3lNHKhYlmlcY12gRriv8hL/ytxXpV77ur/HEjgVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610894;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=b3cWupp/MBqWzOlmajKkVwWoppCoYNRWYWM3JzEQlbs=;
	b=0Ww/7GYZuxEUPOWHK5t69S4Iy0wjx7m7sTC/9GtYAOMjW6TWWKgA+jSRcC8R1T2/g86J
	 /ayi8JnHlhI4E9KmR8D7S9pxYF2qqtNjrOXEyma6AWYOeQsPGFRWOz0ummN92C0FNI2v6
	 t0dtYZJqVB2Vi5cdNwC2GReUpNmeatlh/VduiCYcImBCwJqf3GRBW6gZa7XYP6YoT4x+Z
	 Rx116nhJgmvxgyg6Wdt/6UXV9751k6mH1svIYqIkBAIIHhzsI8fvO/Ft/SvhNfa9OQPAb
	 a7fcdrkqZKctjVF1RA8oTQPmP3VheV8V0aDHKTZIwCZqxBklg6mUQJBjGFOnyQqKjrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IoRHSQ00;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFF606A326;
	Mon,  2 Nov 2026 09:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16EFF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IoRHSQ00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793610901; x=1825146901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6vIBaEBZObkETdySheea9+MKaVh6i5jqj06UXA9pDbI=;
  b=IoRHSQ00o1reQMQUJahCCSR2r0A04CPZJHbsCpXc37ezfWyMl9nco9Ps
   wcdYmywc446x7V/aspXz2HvkpLoojeqZwsJEvMUfX9dD4ODS4Q+jtL1DQ
   6ufHEFfmG5rUiul9+FSWTSWY+hG1yczjhIyR+jF23PyI4PoEb56fEKFix
   Nt4FUhlNyVcF5yu5O34HRcL8Vb1zzqBTZJmrSMq3ZYThwUHPnvRYWIJNw
   bnB7M34ISpmTUx6P1+zHuL5hoWgJLfDbUO36KZGWK582S8t1ivO2XjMvW
   Yqfu64lQ/zJgS5vTBgeEGH4h88MHEPQNfiIH3qyWrKm9bUIalSSqyyOBn
   Q==;
X-CSE-ConnectionGUID: /V9l+2gVTfudp71U3irqEQ==
X-CSE-MsgGUID: a7RtRfgvR0ae5oswmONU0Q==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="64907557"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:15:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 2 Nov 2026 02:14:52 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 2 Nov 2026 02:14:49 -0700
Date: Mon, 2 Nov 2026 10:14:49 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <richardcochran@gmail.com>,
	<horatiu.vultur@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5/lan969x: release the in-flight slot of a
 stale TX skb
Message-ID: <20261102091449.oigddj44eapymqua@DEN-DL-M70577>
References: <20261029-sparx5-ptp-stale-tx-slot-v1-1-ec15f391bbb7@microchip.com>
 <179339983815.3131.4933059375204484548@kernel.org>
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
In-Reply-To: <179339983815.3131.4933059375204484548@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 (1) · High: 0 (2) · Medium: 1 (1) · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch adds a second ptp_skbs decrement path that is not
>   coordinated with sparx5_ptp_txtstamp_release().
> 
> Pre-existing issues:
> - [Critical] Double free and use-after-free of two-step PTP skbs that go
>   through the drop path of sparx5_port_xmit_impl().
> - [High] Use-after-free in lan969x_fdma_tx_clear_buf()
>   (lan969x/lan969x_fdma.c:70-77) for two-step PTP skbs.
> - [High] sparx5_ptp_txtstamp_request() adds the skb to port->tx_skbs with
>   skb_queue_tail() (sparx5_ptp.c:255), which takes and releases…
> - [Medium] Stale skbs, and their global ptp_skbs slots, are aged only
>   when the same port issues another two-step request.
> - [Low] The 10 ms SPARX5_PTP_TIMEOUT used by
>   sparx5_ptp_txtstamp_old_release() treats a frame held in an egress…
> 
> --
> 
> net: sparx5/lan969x: release the in-flight slot of a stale TX skb
> 
> This patch makes sparx5_ptp_txtstamp_old_release() return how many stale
> two step TX skbs it freed. sparx5_ptp_txtstamp_request() then subtracts
> that number from sparx5->ptp_skbs under ptp_ts_id_lock. Without this, an
> skb whose timestamp never arrived kept one of the SPARX5_MAX_PTP_ID
> in-flight slots forever.
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> > index 2826e48af1033..9f61692b243b7 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> 
> [ ... ]
> 
> > @@ -217,8 +218,11 @@ static void sparx5_ptp_txtstamp_old_release(struct sparx5_port *port)
> >
> >               __skb_unlink(skb, &port->tx_skbs);
> >               dev_kfree_skb_any(skb);
> > +             purged++;
> >       }
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but can this walk free a two
> step skb a second time?
> 
> In sparx5_port_xmit_impl(), sparx5_ptp_txtstamp_request() has already
> queued the skb on port->tx_skbs and incremented ptp_skbs. If the backend
> then fails with anything other than -EBUSY, the drop label only frees the
> skb:
> 
> drivers/net/ethernet/microchip/sparx5/sparx5_packet.c:sparx5_port_xmit_impl() {
>     ...
>         if (ret == -EBUSY)
>                 goto busy;
>         if (ret < 0)
>                 goto drop;
>     ...
> drop:
>         stats->tx_dropped++;
>         sparx5->tx.dropped++;
>         dev_kfree_skb_any(skb);
>         return NETDEV_TX_OK;
> busy:
>         if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
>             SPARX5_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
>                 sparx5_ptp_txtstamp_release(port, skb);
>         return NETDEV_TX_BUSY;
> }
> 
> Only the busy path calls sparx5_ptp_txtstamp_release(). On the drop path
> the freed skb stays linked on port->tx_skbs.
> 
> On sparx5, sparx5_fdma_xmit() returns -EINVAL when the TX ring is full:
> 
>         if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
>                 return -EINVAL;
> 
> On lan969x, lan969x_fdma_xmit() can return -ENOMEM from
> pskb_expand_head(GFP_ATOMIC) or on dma_mapping_error().
> 
> The next two step xmit on that port, at least SPARX5_PTP_TIMEOUT later,
> would reach sparx5_ptp_txtstamp_old_release(). It would read
> SPARX5_SKB_CB(skb)->jiffies and skb->next from freed memory, call
> __skb_unlink() on it, and call dev_kfree_skb_any() on it again. The PTP
> IRQ handlers also walk this list and read cb->ts_id of the freed skb.
> 
> With this patch the double-freed entry is also counted in purged, so its
> slot gets reclaimed through the double free.
> 
> Should the drop path call sparx5_ptp_txtstamp_release() for two step skbs,
> as the busy path does?
> 
> [Severity: High]
> This is a pre-existing issue, but on lan969x, can the FDMA TX ring still
> reference the skb freed here?
> 
> lan969x_fdma_xmit() stores the two step skb in the ring with
> db_buf->skb = skb and db_buf->ptp = true, and the PTP code is responsible
> for freeing it. This function and lan969x_ptp_irq_handler() both free the
> skb without clearing db->skb or checking whether the DCB has completed.
> 
> lan969x_fdma_tx_clear_buf() then dereferences db->skb before it checks
> db->ptp:
> 
> drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c:lan969x_fdma_tx_clear_buf() {
>     ...
>                 db->dev->stats.tx_bytes += db->skb->len;
>                 db->dev->stats.tx_packets++;
>                 sparx5->tx.packets++;
> 
>                 dma_unmap_single(sparx5->dev,
>                                  db->dma_addr,
>                                  db->skb->len,
>                                  DMA_TO_DEVICE);
> 
>                 if (!db->ptp)
>                         napi_consume_skb(db->skb, weight);
>     ...
> }
> 
> The PTP IRQ is a separate threaded IRQ with no ordering against NAPI. A
> delayed NAPI poll could therefore read skb->len from freed memory.
> 
> If old_release frees an skb whose DCB has not completed yet, for example
> because the FDMA stalled for more than 10 ms, wouldn't the device still
> DMA-read the freed buffer?
> 
> [Severity: Low]
> This is a pre-existing issue, but is a fixed 10 ms SPARX5_PTP_TIMEOUT long
> enough here?
> 
> A frame held in an egress queue for more than 10 ms, for example behind a
> closed TAS gate or by pause frames, would be freed here as lost. When it
> later egresses, sparx5_ptp_irq_handler() and lan969x_ptp_irq_handler()
> find no matching skb and hit:
> 
>                 if (WARN_ON(!skb_match))
>                         continue;
> 
> The continue skips the ptp_skbs decrement, so the counter itself stays
> consistent with port->tx_skbs.
> 
> [ ... ]
> 
> > @@ -236,9 +241,10 @@ int sparx5_ptp_txtstamp_request(struct sparx5_port *port,
> >       if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
> >               return 0;
> >
> > -     sparx5_ptp_txtstamp_old_release(port);
> > +     purged = sparx5_ptp_txtstamp_old_release(port);
> 
> [Severity: Medium]
> This is a pre-existing issue, and the commit message already mentions it.
> Stale skbs, and their global ptp_skbs slots, are only aged when the same
> port sends another two step frame.
> 
> sparx5_ptp_hwtstamp_set() with HWTSTAMP_TX_OFF does not purge
> port->tx_skbs, and neither does port stop. Only sparx5_ptp_deinit() does.
> A port that stops sending two step frames, because the link went down or
> TX timestamping was turned off, keeps any lost skbs that had not expired
> at its last request.
> 
> If these leftovers add up to SPARX5_MAX_PTP_ID across ports, two step
> xmit on every other port gets -EBUSY. sparx5_port_xmit_impl() turns that
> into NETDEV_TX_BUSY.
> 
> Could port->tx_skbs also be purged from a path that does not depend on the
> port's own traffic, such as HWTSTAMP_TX_OFF or port stop?
> 
> >
> >       spin_lock_irqsave(&sparx5->ptp_ts_id_lock, flags);
> > +     sparx5->ptp_skbs -= purged;
> 
> [Severity: Medium]
> Can this decrement race with sparx5_ptp_txtstamp_release() and count the
> same skb down twice?
> 
> Each port netdev has SPX5_PRIOS TX queues and there is no
> ndo_select_queue, so two CPUs can run sparx5_port_xmit_impl() for the same
> port at the same time. sparx5_ptp_txtstamp_old_release() unlinks while
> holding only tx_skbs.lock. The busy path decrements without checking
> whether the skb is still on the list:
> 
> drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c:sparx5_ptp_txtstamp_release() {
>     ...
>         spin_lock_irqsave(&sparx5->ptp_ts_id_lock, flags);
>         port->ts_id--;
>         sparx5->ptp_skbs--;
>         skb_unlink(skb, &port->tx_skbs);
>         spin_unlock_irqrestore(&sparx5->ptp_ts_id_lock, flags);
> }
> 
> A possible sequence:
> 
> CPU0
> sparx5_ptp_txtstamp_request()
>     skb_queue_tail(&port->tx_skbs, X)
>     sparx5->ptp_skbs++
> spin_lock(&sparx5->tx_lock)   /* waits */
> 
> CPU1
> sparx5_ptp_txtstamp_request()
>     sparx5_ptp_txtstamp_old_release()
>         /* X looks older than SPARX5_PTP_TIMEOUT */
>         __skb_unlink(X); dev_kfree_skb_any(X); purged++
>     sparx5->ptp_skbs -= purged
> 
> CPU0
> ops->fdma_xmit() or sparx5_inject() returns -EBUSY
> sparx5_ptp_txtstamp_release(port, X)
>     sparx5->ptp_skbs--
> 
> At HZ=100, SPARX5_PTP_TIMEOUT is one jiffy, so crossing a single tick is
> enough for X to look expired.
> 
> Before this patch the purge path did not decrement, so X was counted down
> only once. ptp_skbs is a u16 and the limit check only tests for equality.
> 
> If the counter wraps to 65535, does the SPARX5_MAX_PTP_ID limit stop
> working, so that ts_id values can be reused while they are still
> outstanding?
> 
> The same window already lets CPU0 keep using X after CPU1 has freed it.
> That part predates this patch; the double decrement is new.

This fixes a leak seen in normal operation. Each lost timestamp keeps
an in-flight slot, and after SPARX5_MAX_PTP_ID losses, two step
timestamping stops on all ports. The lan966x twin (074caa30a627) is
already in net.

AFAICT, the wrong count can never be used. The second decrement is in the busy
path, which on the very next line unlinks an skb that a purge on
another TX queue has already freed. That use-after-free is
pre-existing and crashes before the count matters.

I am working on a net-next series that reworks PTP TX timestamping and fixes
this and several related issues.

> 
> >       if (sparx5->ptp_skbs == SPARX5_MAX_PTP_ID) {
> >               spin_unlock_irqrestore(&sparx5->ptp_ts_id_lock, flags);
> >               return -EBUSY;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but a little further down in
> sparx5_ptp_txtstamp_request() the skb is added to port->tx_skbs before its
> cb fields are written:
> 
>         skb_queue_tail(&port->tx_skbs, skb);
>         SPARX5_SKB_CB(skb)->ts_id = port->ts_id;
>         SPARX5_SKB_CB(skb)->jiffies = jiffies;
> 
> skb_queue_tail() takes and releases tx_skbs.lock, and the cb writes happen
> under ptp_ts_id_lock only. sparx5_ptp_txtstamp_old_release() and both PTP
> IRQ handlers walk the list holding only tx_skbs.lock.
> 
> With several TX queues per port, another CPU could run old_release on the
> same port and read X's cb->jiffies before it is set. That field still
> holds leftover bytes from earlier layers such as the qdisc. If the value
> looks expired, would old_release free X while CPU0 is still filling in the
> cb and passing X to the injector or FDMA? The IRQ handlers could also
> match a stale cb->ts_id the same way.
> 
> Would writing ts_id and jiffies before skb_queue_tail() close this?
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-sparx5-ptp-stale-tx-slot-v1-1-ec15f391bbb7%40microchip.com
