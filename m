Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614672;
	b=ZPhLkFfXPYofiezhoCTxYw3RY8oiZjj0noFxZ15vDI2GYF78O2TbDridbRWnGy1AZQlW
	 rHZqEo3JKP0deNyAU3e/+VFx0fu8q2AU05Hu1/CMHHHWLIsR3oTmdYXmPeC3QwRjWyJ1N
	 Xq2iNL6TLOpNStCdia50qyT9obE34ykc8Tgg/e4sA8gcZBUqyomL6uTek0snQ1CIgmRjQ
	 gm5tNFPF59JjUblfRiMaRl+0xN3NDyysv12dHaDL5wQ26/+eNM+h0wR3ORleDR3VzHxGC
	 rsjZdA4SIDo+vGu2wnUZWDBGHBmauntIpfGAstfWMJBns2KzVpOFnp/8AxbmrnElpRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614672;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=2Ch/+JXeIwp2fxEguPfcLSwx51AH4CgmlXbkMadrgYA=;
	b=z8ddj/SbUK3Sl7FszU5rrIRId9dXTkq6NLcq/lSvlGmjNgk9q01CMmvsF+lBFOAnQ61X
	 /wFBVtOrHQTk4ezjAbpPZ20pwCZGigzMLnAkYNowbs33C/6WtpneAOTtuYKsaO0XkWMx4
	 jVWaxfexPVtU1+0evJicFlI1TiB8GZaU1aqv7mq4OuJPL0wTxcsOAwvw+8gkGhc5m0+YQ
	 ayPZ7iGSE0py33mGrLWZDexdl8arSPtP14/BnR/ApxzA7zNe7Nb7jmM8DymTWSpfHeFlR
	 VY4mBX5loWQ8ncXAJFtG/s0eLakYvACZYzkv5h5AJXjVRBz/+fgCOmjJEV9OvtmOIvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=NSOasIWJ;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF1606A327;
	Mon,  2 Nov 2026 10:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AADF1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=NSOasIWJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793614671; x=1825150671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4/A1ayAfC4jefMxy6W9aP2+W3fxz1Go9zzAJ94B2z+Q=;
  b=NSOasIWJD9QMUopwYQUwBO1rYiWV100/X8Yv7hIv17cKzz4Gu8DvOoFo
   6WrpeUR9BDI1kO3aDyOtaiZMwlwxH2jFNaU6OB7kndgt/VSCep21u4+RX
   +l1M5pJQQ1u6GKn22ZTB028/XgiEZiRUE07iShMcnr5gAqgtUQQ16l2/i
   hrlx1Ga6l0eyUZtl3NIOcMa/WxVJFhZZs1WS/F6jcb9wqs7fKmG3d8gyO
   PRi1WxZQbpyuOxjuNOMwZDSxpLgQA+IyY1wCq2QSaluO+DUEVPy2OEOT0
   uIpAvj3fjAAF6g9Mx6Sg9P6idU2tX41MaVESu4i8am3u+DPzfWr+r25U4
   Q==;
X-CSE-ConnectionGUID: xNfpb/zrQFCFuXPhZDzT/w==
X-CSE-MsgGUID: wDn1IhVxRd+u/d0P9OTJww==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="297298179"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2026 03:17:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 2 Nov 2026 03:17:44 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 2 Nov 2026 03:17:42 -0700
Date: Mon, 2 Nov 2026 11:17:41 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <devnexen@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: save the RX state after quiescing the
 NAPI in a reload
Message-ID: <20261102101741.2bhiw6ygqrorgotx@DEN-DL-M70577.microsemi.net>
References: <20261029-lan966x-fdma-reload-quiesce-v1-1-daaeda5ca3aa@microchip.com>
 <179339596805.3131.15722665365949001732@kernel.org>
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
In-Reply-To: <179339596805.3131.15722665365949001732@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (4) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch does not fully fix the restore path, even though the
>   commit message says it does.
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   lan966x_fdma_rx_alloc()…
> - [High] This problem wasn't introduced by this patch, but
>   lan966x_fdma_reload() swaps lan966x->rx.page_pool and destroys the old…
> - [High] This problem wasn't introduced by this patch, but it produces
>   the same outcome the commit message describes: a page the stack still…
> - [High] This problem wasn't introduced by this patch, but
>   lan966x_fdma_reload() runs lan966x_fdma_rx_start() and…
> 
> --
> 
> net: lan966x: save the RX state after quiescing the NAPI in a reload
> 
> This patch moves napi_synchronize(), napi_disable() and
> lan966x_fdma_stop_netdev() in lan966x_fdma_reload() so they run before
> the copies of rx->page[] and the RX FDMA state are taken. A NAPI poll
> can then no longer advance the ring after the snapshot. The old_pages
> buffer is still allocated first, so an allocation failure returns
> before anything needs to be undone.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > index 21668bbcc9063..2dbc25c098fec 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > @@ -819,21 +819,21 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
> >       int page_order, max_mtu;
> >       int err, i, j;
> >
> > -     old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
> > -                        GFP_KERNEL);
> > +     old_pages = kmalloc_objs(*lan966x->rx.page, FDMA_DCB_MAX);
> >       if (!old_pages)
> >               return -ENOMEM;
> >
> > +     napi_synchronize(&lan966x->napi);
> > +     napi_disable(&lan966x->napi);
> > +     lan966x_fdma_stop_netdev(lan966x);
> 
> [Severity: High]
> This is a pre-existing issue, but both the success path and the restore
> path of lan966x_fdma_reload() restart things in this order:
> 
>         lan966x_fdma_rx_start(&lan966x->rx);
>         [ ... ]
>         lan966x_fdma_wakeup_netdev(lan966x);
>         napi_enable(&lan966x->napi);
> 
> An FDMA DB interrupt can fire while NAPI is still disabled. Examples are
> a TX completion after netif_wake_queue() on another CPU, or ndo_xdp_xmit
> traffic, which ignores queue state. In that case lan966x_fdma_irq_handler()
> does:
> 
>                 lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
>                 lan_wr(db, lan966x, FDMA_INTR_DB);
> 
>                 napi_schedule(&lan966x->napi);
> 
> The napi_schedule() does nothing, because napi_disable() holds
> NAPI_STATE_SCHED. napi_enable() does not schedule a poll either.
> FDMA_INTR_DB_ENA is only re-armed by the poll, by rx_start, or by the
> first TX activation.
> 
> Could this leave all DB interrupts masked, with RX and TX completion
> dead on every port until the next reload?
> 
> There is also a narrower window between napi_disable() and rx_start().
> The read-modify-write in rx_start only sets the RX channel bit, so a TX
> bit cleared by the handler stays cleared until an RX poll writes 0xff.
> 
> lan966x_fdma_pci_reload() documents this hazard and calls napi_enable()
> first:
> 
>         /* Order matters: napi_enable() must precede the wakes, or a TX that
>          * completes first clears FDMA_INTR_DB_ENA with nothing scheduled to
>          * restore it, leaving RX dead until the next reload.
>          */
> 
> Should the platform reload use the same ordering?
> 
> > +
> >       /* Store these for later to free them */
> > +     memcpy(old_pages, lan966x->rx.page, sizeof(lan966x->rx.page));
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but a refill failure in
> lan966x_fdma_napi_poll() seems to lead to the outcome the commit message
> describes, a page the stack still owns being returned to the old pool:
> 
> allocate_new:
>         while (dcb_reload != fdma->dcb_index) {
>                 [ ... ]
>                 fdma_dcb_add(fdma, old_dcb, FDMA_DCB_INFO_DATAL(fdma->db_size),
>                              FDMA_DCB_STATUS_INTR);
>                 [ ... ]
>         }
> 
> The return value of fdma_dcb_add() is ignored. If
> page_pool_dev_alloc_pages() fails, lan966x_fdma_rx_dataptr_cb() returns
> -ENOMEM without updating rx->page[old_dcb][0]. The slot still points at
> the page that was already passed to the stack, placed in the TX ring,
> redirected, or recycled.
> 
> The DCB is not relinked either. Software eventually stops at that DCB,
> so the stale pointer stays in place.
> 
> The next reload copies that pointer into old_pages here and calls
> page_pool_put_full_page() on it before page_pool_destroy(). Can this
> cause a use-after-free or double free when the skb or xdp_frame owner
> later frees the page? lan966x_fdma_rx_free_pages() at teardown seems to
> have the same exposure.
> 
> >       memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
> 
> [Severity: High]
> The commit message says:
> 
>   "...and the restore path puts back a stale DCB index and last DCB
>   pointer."
> 
> With the snapshot now taken after napi_disable(), the restore path puts
> back the current dcb_index (say k) and last_dcb (DCB k-1). Does the
> hardware agree with that position? The restore path does:
> 
> restore:
>         [ ... ]
>         memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
>         [ ... ]
>         lan966x_fdma_llp_configure(lan966x, lan966x->rx.fdma.dma,
>                                    lan966x->rx.fdma.channel_id);
> 
>         lan966x_fdma_rx_start(&lan966x->rx);
> 
> The LLP points at the ring base (DCB 0), and the channel is reactivated
> without rebuilding the DCB chain.
> 
> After traffic, each NAPI refill through fdma_dcb_add()->__fdma_dcb_add()
> appends the consumed DCB after last_dcb with an INVALID nextptr. The
> chain is then k -> ... -> n-1 -> 0 -> ... -> k-1 (INVALID).
> 
> Starting at DCB 0, the hardware would fill DCBs 0..k-1 and stop at k-1.
> lan966x_fdma_napi_poll() only checks fdma_has_frames() on DCB k. If
> lan966x_fdma_rx_alloc() fails while k != 0, wouldn't RX stop on all
> ports until the next successful reload?
> 
> On its restore path, lan966x_fdma_pci_reload() calls
> lan966x_fdma_pci_reset_mem(). That runs fdma_dcbs_init() to reset the
> indices and rebuild the chain before the LLP is programmed.
> 
> Does the platform restore path need to re-initialise the old ring in a
> similar way, or program the LLP to fdma.dma + dcb_index *
> sizeof(struct fdma_dcb)?

Yes, this is real. The restore path restarts the RX channel at the base of the
old ring, while the restored DCB index points further into it. I reproduced it
on a lan9668 board, and the fix is similar to what I did on lan966x-pci.

I will send a v2.

pw-bot: cr

> 
> [Severity: High]
> This is a pre-existing issue, but is it safe to destroy this page_pool
> while XDP_TX pages from it can still be queued in the TX ring?
> 
> lan966x_fdma_xmit_xdpf() stores the RX page in the TX ring:
> 
>                 next_dcb_buf->data.page = page;
> 
> These buffers are only reclaimed from NAPI, by
> lan966x_fdma_tx_clear_buf(). That function recycles into whichever pool
> is current:
> 
>                         else
>                                 page_pool_recycle_direct(rx->page_pool,
>                                                          dcb_buf->data.page);
> 
> The TX channel is not drained during the reload. After napi_enable(),
> these old-pool pages would be recycled into the new pool, and
> __page_pool_put_page() does not check page->pp against the pool
> argument.
> 
> Would the old pool's inflight count then never reach zero, so the
> deferred page_pool_destroy() never completes? The new pool's inflight
> accounting would also go negative.
> 
> When the MTU grows (page_order 0 -> 2), the new pool would DMA sync and
> later unmap an order-0 page using its larger max_len and order. On
> non-coherent systems, could that invalidate cache lines past the end of
> the page, or let the device DMA past it? After XDP detach the dma_dir
> would also mismatch (DMA_BIDIRECTIONAL vs DMA_FROM_DEVICE).
> 
> >       page_order = lan966x->rx.page_order;
> >       max_mtu = lan966x->rx.max_mtu;
> >
> > -     napi_synchronize(&lan966x->napi);
> > -     napi_disable(&lan966x->napi);
> > -     lan966x_fdma_stop_netdev(lan966x);
> > -
> >       lan966x_fdma_rx_disable(&lan966x->rx);
> >       lan966x->rx.page_order = round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
> >       lan966x->rx.max_mtu = new_mtu;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but lan966x_fdma_rx_alloc(),
> called right after this, drops the return value of fdma_dcbs_init():
> 
>         fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
>                        FDMA_DCB_STATUS_INTR);
> 
>         lan966x_fdma_llp_configure(lan966x, fdma->dma, fdma->channel_id);
> 
>         return 0;
> 
> Suppose page_pool_dev_alloc_pages() fails at DCB k. This can happen
> because it uses GFP_ATOMIC, with order > 0 for a jumbo MTU.
> lan966x_fdma_rx_dataptr_cb() then returns -ENOMEM before writing
> rx->page[k][0], and fdma_dcbs_init() stops there.
> 
> lan966x_fdma_reload() still takes the success path. It puts every
> old_pages[i][j] back to the old pool and calls page_pool_destroy().
> rx.page[k..n_dcbs-1] are never cleared, so they still point at those
> old pages.
> 
> Could a later lan966x_fdma_rx_free_pages() on deinit, or the memcpy()
> into old_pages on the next reload, put those freed pages again?
> 
> The new ring would also end at DCB k-1, so RX would stall once
> dcb_index reaches k.
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-lan966x-fdma-reload-quiesce-v1-1-daaeda5ca3aa%40microchip.com
> 
