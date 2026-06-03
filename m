Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD093AC0F3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486572; cv=none; b=OBbvr2uGg3ow/EdLO0QAlW86IQ8dUftg/vQjIgRg9U5OF1wIQidQ1hWnNgypo/dtwHw8qfRsj7DZr2KUtIlWokUz8PrMjlw5SqEM5j2G8qbE/Ou+AHkHhc0fzdaXJxkecnFCyMGwCN8yZyf9478djrcR4729rAsyiaeS+2iXnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486572; c=relaxed/simple;
	bh=iCj+cxJ1dgIQ4lTinGoX2hqBALZh9u7kpR3iDLwY04c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=isE04Cv5MoYRwqxsjY2e3caipdnnl4bOcV3GGILheTasSlAGjwyDXJkxN806s1XpBH6g2HpV7TNuumM7BYJ9U7P9Ymr+cAI1Rv8Wm6tPuQC7BPl07KCtgbFPDqQxerxerZsPhTx0UuI9CsDO4bKs9eNrKdCebp1mLe6O7236XuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oeSxu80Z; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oeSxu80Z"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260603113605euoutp022708de30faf8bbb1411cbbdc86793a06~1jxkHegpL0834808348euoutp02h
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:36:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260603113605euoutp022708de30faf8bbb1411cbbdc86793a06~1jxkHegpL0834808348euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780486565;
	bh=4GArOavaImghtalZK1nJoo6wgd+7UQZGdEnbTIMAsNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oeSxu80Zb4DgG0yOZXIgChpcDEAkb0Mtf9Gf8N5qPliWyi2R4zV2ZW8bQ5r1qcC01
	 wihTFqabxHaTFTAUmeMYYlbdkD44FdaULLkeSrzxy2tTbNyAiHGO90QDqnJchaAId5
	 K2qqCFMj4nbKvndl2NFPreCREQa0woGppMECaAeo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260603113604eucas1p22c22d7f597452cf3918273bd759c6c5f~1jxjcZVPo0880508805eucas1p2m;
	Wed,  3 Jun 2026 11:36:04 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260603113603eusmtip1f81c96f49400fcf9c2b09759cbdbc459~1jxiUtrGO3252932529eusmtip1M;
	Wed,  3 Jun 2026 11:36:03 +0000 (GMT)
Date: Wed, 3 Jun 2026 13:36:03 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com
Subject: Re: [PATCH net-next v2 2/2] net/stmmac: Fix free-after-use panic
 when interface goes down
Message-ID: <aiARoy15Yne/PIMP@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601163258.554300-3-j.raczynski@samsung.com>
X-CMS-MailID: 20260603113604eucas1p22c22d7f597452cf3918273bd759c6c5f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_e97e5_"
X-RootMTR: 20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4
X-EPHeader: CA
X-CMS-RootMailID: 20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4
References: <20260601163258.554300-1-j.raczynski@samsung.com>
	<CGME20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4@eucas1p2.samsung.com>
	<20260601163258.554300-3-j.raczynski@samsung.com>

------t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_e97e5_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Gonna respond to Sashiko comments.

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3a66f28425275..2c6abd5efd55a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -292,16 +292,18 @@ static void __stmmac_disable_all_queues(struct stmmac_priv *priv)
> >  static void stmmac_disable_all_queues(struct stmmac_priv *priv)
> >  {
> >  	u8 rx_queues_cnt = priv->plat->rx_queues_to_use;
> > -	struct stmmac_rx_queue *rx_q;
> >  	u8 queue;
> >  
> > -	/* synchronize_rcu() needed for pending XDP buffers to drain */
> >  	for (queue = 0; queue < rx_queues_cnt; queue++) {
> Is this napi_synchronize() loop racy and redundant here?
> __stmmac_disable_all_queues() immediately calls napi_disable(), which
> internally sets NAPI_STATE_DISABLE and spins until NAPI safely exits. Since
> NAPI is not yet disabled during this loop, could a hardware interrupt fire
> and reschedule the NAPI immediately after napi_synchronize() returns?
> Additionally, does this loop fail to cover pure TX queues by only iterating
> up to rx_queues_cnt?

We wouldn't have this commit if that was a case, would we?
Problem is, after this function there is still possible traffic that
will panic the system.
synchronize_rcu() should be good enough for XDP but is not good enough
altogether. napi_synchronize() is proper tool here, as NAPI might be running
on multiple queues.
But are still IRQ's after this possible? As code is written currently,
there is following order:
- disable PHY
- disable NAPI (this), earlier synchronize_rcu()
- disable TX
- disable IRQ's

In original patch, we added synchronize_rcu() after freeing IRQ's as these
were possible, meaning after disabling NAPI there was still IRQ.
In this version we trigger NAPI synchronize which should consume all data,
but IRQ after this might still be possible? It would be very VERY unlucky.

I think napi_synchronize() will consume so much time here that all data
should be processed after disabling PHY.

> > -		rx_q = &priv->dma_conf.rx_queue[queue];
> > -		if (rx_q->xsk_pool) {
> > -			synchronize_rcu();
> > -			break;
> > +		struct stmmac_channel *ch = &priv->channel[queue];
> > +
> > +		if (stmmac_xdp_is_enabled(priv) &&
> > +		    test_bit(queue, priv->af_xdp_zc_qps)) {
> > +			napi_synchronize(&ch->rxtx_napi);
> Does removing synchronize_rcu() introduce a regression in XDP redirect
> synchronization?
> In network drivers, stmmac_xdp_xmit() is called by other CPUs in their own
> NAPI contexts when processing XDP_REDIRECT packets, which is protected by
> rcu_read_lock(). 
> By using a local napi_synchronize(), the driver only waits for its own NAPI
> thread to stop running. Does this leave zero synchronization against other
> CPUs concurrently executing stmmac_xdp_xmit(), causing the exact
> Use-After-Free on TX rings this patch aims to fix when
> free_dma_desc_resources() zeroes out the tx_skbuff arrays?
Not sure I agree but I would gladly be enlightened here.

> > +		} else {
> > +			napi_synchronize(&ch->rx_napi);
> >  		}
> > +
> >  	}
> >  
> >  	__stmmac_disable_all_queues(priv);
> This is a pre-existing issue, but does stmmac_release() fail to cancel
> priv->service_task, allowing the interface to unexpectedly come back up?
> When the interface is brought down normally, dev_close() invokes
> stmmac_release(), but cancel_work_sync(&priv->service_task) is not called.
> If a hardware error schedules service_task just before dev_close() takes
> the rtnl_lock, it will block on the lock and run immediately after the
> interface is down. Because STMMAC_DOWN is not set, it will bypass the
> test_bit(STMMAC_DOWN, &priv->state) check, execute dev_close(), and then
> incorrectly call dev_open() via stmmac_reset_subtask().
Scenario where 'ifconfig down' + queue error/timeout happen at the same time?
Sure, might fix this if requested, but this is the risk I may live with,
it is impossible IMO.

BR
Jakub Raczynski

------t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_e97e5_
Content-Type: text/plain; charset="utf-8"


------t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_e97e5_--
